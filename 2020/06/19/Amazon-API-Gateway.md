---
path: "./2020/06/19/Amazon-API-Gateway.md"
date: "2020-06-19T15:15:00"
title: "AWS API Gateway Quick Reference"
description: "Quick Reference, Cheat sheet - AWS API Gateway"
tags: ["AWS", "Amazon", "API Gateway", "RESTful APIs", "WebSocket APIs", "Features of API Gateway", "API endpoint", "Routes for HTTP APIs", "Endpoint types", "Edge optimized endpoint", "Regional endpoint", "Private endpoint", "Serverless Application Model (SAM)", "Lambda authorizers", "API keys"]
lang: "en-us"
---

### Introduction ###

__What is Amazon API Gateway__

>Amazon API Gateway is an AWS service for creating, publishing, maintaining, monitoring, and securing REST, HTTP, and WebSocket APIs at any scale. API developers can create APIs that access AWS or other web services, as well as data stored in the AWS Cloud. As an API Gateway API developer, you can create APIs for use in your own client applications. Or you can make your APIs available to third-party app developers.

__Types of API supported__

- __RESTful APIs__

  * Are HTTP-based.

  * Enable stateless client-server communication.

  * Implement standard HTTP methods such as GET, POST, PUT, PATCH, and DELETE.

- __WebSocket APIs__

  * Adhere to the WebSocket

  * Protocol, which enables stateful, full-duplex communication between client and server.

  * Route incoming messages based on message content.

### Features of API Gateway ###

- Support for stateful (WebSocket) and stateless (HTTP and REST) APIs.

- Powerful, flexible authentication mechanisms, such as AWS Identity and Access Management policies, Lambda authorizer functions, and Amazon Cognito user pools.

- Developer portal for publishing your APIs.

- Canary release deployments for safely rolling out changes.

- CloudTrail logging and monitoring of API usage and API changes.

- CloudWatch access logging and execution logging, including the ability to set alarms.

- Ability to use AWS CloudFormation templates to enable API creation.

- Support for custom domain names.

- Integration with AWS WAF for protecting your APIs against common web exploits.

- Integration with AWS X-Ray for understanding and triaging performance latencies.

__API endpoint format__. `{api-id}.execute-api.{region}.amazonaws.com`

__CloudFront__. Each deployment of Amazon API Gateway includes an Amazon CloudFront distribution under the covers.

__In-memory Cache__. You can improve the performance of specific API requests by using Amazon API Gateway to store responses in an optional in-memory cache.

Amazon API Gateway provides the ability to create Mock Integrations that allow you to generate API responses directly from API Gateway that client applications can develop against.

### Directing Traffic ###

__Routes for HTTP APIs__

>Routes direct incoming API requests to backend resources. Routes consist of two parts: an HTTP method and a resource path—for example, GET /pets. You can define specific HTTP methods for your route. Or, you can use the ANY method to match all methods that you haven't defined for a resource. You can create a $default route that acts as a catch-all for requests that don’t match any other routes.

Supports both path variables e.g `/pets/{petID}` and query string e.g `/pets?petID={petID}`

__Endpoint types for API Gateways__

An API endpoint type refers to the hostname of the API. The API endpoint type can be `edge-optimized`, `regional`, or `private`, depending on where the majority of your API traffic originates from.

- __Edge optimized__ - The default for REST APIs. Best for geographically distributed clients. API requests are routed to the nearest CloudFront Point of Presence (POP).

  * Any custom domain name that you use for an edge-optimized API applies across all regions.
  * Edge-optimized APIs capitalize the names of HTTP headers.

- __Regional__ -  Intended for clients in the same region. When a client running on an EC2 instance calls an API in the same region, or when an API is intended to serve a small number of clients with high demands, a regional API reduces connection overhead.

  * Any custom domain name that you use is specific to the region where the API is deployed. If you deploy a regional API in multiple regions, it can have the same custom domain name in all regions.
  * Regional API endpoints pass all header names through as-is.

- __Private__ - Can only be accessed from your VPC using an interface VPC endpoint.

  * Private API endpoints pass all header names through as-is.  

### Security ###

API Gateway automatically protects your backend from DDoS attacks whether
attacked with counterfeit requests (Layer 7) or SYN floods (Layer 3)

All requests to your APIs can be made via HTTPS to enable encryption in transit.

Your AWS Lambda functions can restrict access so that there is a trust relationship only between a particular API within Amazon API Gateway and a particular function in AWS Lambda. There will be no other way to invoke that Lambda function except by using the API through which you’ve chosen to expose it.

The Amazon API Gateway allows you to generate client SDKs to integrate with your APIs. That SDK also manages the signing of requests when APIs require authentication. Those API credentials used on the client side for authentication are passed directly to your AWS Lambda function –where further authentication can occur within code that you own and write, if needed.

Each resource/method combination that you create as part of your API is granted its own specific Amazon Resource Name (ARN) that can be referenced in AWS Identity and Access Management (IAM)8policies.

- This means your APIs are treated as first class citizens along with the other AWS-owned APIs. IAM policies can be fine-grained; they can reference specific resources/methods of an API created using Amazon API Gateway.

- API access is enforced by the IAM policies that you create outside the context of your application code. This means that you do not have to write any code to be aware of or enforce those access levels. Code cannot contain bugs or be exploited if it does not exist.

- Authorizing clients using AWS Signature version 4 (SigV4) authorization and IAM policies for API access allows those same credentials to restrict or permit access to other AWS services and resources as needed (for example, Amazon S3 buckets or Amazon DynamoDB tables).

__Access Control__

You can use AWS Serverless Application Model (SAM) to control who can access your API Gateway APIs by enabling authorization within your AWS SAM template. AWS SAM supports several mechanisms for controlling access to your API Gateway APIs:

__Lambda authorizers__. A Lambda authorizer (formerly known as a custom authorizer) is a Lambda function that you provide to control access to your API. When your API is called, this Lambda function is invoked with a request context or an authorization token that is provided by the client application. The Lambda function returns a policy document that specifies the operations that the caller is authorized to perform, if any.

A Lambda authorizer is useful if you want to implement a custom authorization scheme that uses a bearer token authentication strategy such as OAuth or SAML, or that uses request parameters to determine the caller's identity.

When a client makes a request to one of your API's methods, API Gateway calls your Lambda authorizer, which takes the caller's identity as input and returns an IAM policy as output.

Types of Lambda authorizers:

- A `token-based Lambda authorizer` (also called a TOKEN authorizer) receives the caller's identity in a bearer token, such as a JSON Web Token (JWT) or an OAuth token.

- A `request parameter-based Lambda authorizer` (also called a REQUEST authorizer) receives the caller's identity in a combination of headers, query string parameters, _stageVariables_, and _$context_ variables.

The Lambda authorizer function authenticates the caller by means such as the following:

- Calling out to an OAuth provider to get an OAuth access token.

- Calling out to a SAML provider to get a SAML assertion.

- Generating an IAM policy based on the request parameter values.

- Retrieving credentials from a database.

__Amazon Cognito__ user pools. Amazon Cognito user pools are user directories in Amazon Cognito. A client of your API must first sign a user in to the user pool, and obtain an identity or access token for the user. Then your API is called with one of the returned tokens. The API call succeeds only if the required token is valid.

To use an Amazon Cognito user pool with your API, you must first create an authorizer of the `COGNITO_USER_POOLS` type and then configure an API method to use that authorizer. After the API is deployed, the client must first sign the user in to the user pool, obtain an identity or access token for the user, and then call the API method with one of the tokens, which are typically set to the request's Authorization header.

__IAM permissions__. You can control who can invoke your API using IAM permissions. Users calling your API must be authenticated with IAM credentials. Calls to your API only succeed if there is an IAM policy attached to the IAM user that represents the API caller, an IAM group that contains the user, or an IAM role that is assumed by the user.

You control access to your Amazon API Gateway API with IAM permissions by controlling access to the following two API Gateway component processes:

- __Control Access for Managing API__. To create, deploy, and manage an API in API Gateway, you must grant the API developer permissions to perform the required actions supported by the API management component of API Gateway.

- __Control Access for Invoking API__. To call a deployed API or to refresh the API caching, you must grant the API caller permissions to perform required IAM actions supported by the API execution component of API Gateway. `When an API is integrated with an AWS service (for example, AWS Lambda) in the back end, API Gateway must also have permissions to access integrated AWS resources` (for example, invoking a Lambda function) on behalf of the API caller.

__API keys__. API keys are alphanumeric string values that you distribute to application developer customers to grant access to your API. API Gateway can generate API keys on your behalf, or you can import them from a CSV file. You can generate an API key in API Gateway, or import it into API Gateway from an external source.

- API key values must be unique. If you try to create two API keys with different names and the same value, API Gateway considers them to be the same API key.

- An API key can be associated with more than one usage plan. A usage plan can be associated with more than one stage. However, a given API key can only be associated with one usage plan for each stage of your API.

__Best Practices__

- Don't rely on API keys as your only means of authentication and authorization for your APIs. For one thing, if you have multiple APIs in a usage plan, a user with a valid API key for one API in that usage plan can access all APIs in that usage plan. Instead, use an IAM role, a Lambda authorizer, or an Amazon Cognito user pool.

- If you're using a developer portal to publish your APIs, note that all APIs in a given usage plan are subscribable, even if you haven't made them visible to your customers.

__Resource policies__. Resource policies are JSON policy documents that you can attach to an API Gateway API to control whether a specified principal (typically an IAM user or role) can invoke the API. Use Amazon API Gateway resource policies to allow your API to be securely invoked by:

- Users from a specified AWS account.
- Specified source IP address ranges or CIDR block.
- Specified VPCs or VPC endpoints (in any account),

In addition, you can use AWS SAM to customize the content of some API Gateway error responses.

### Integrations ###

__With what backends can API Gateway communicate?__

- Execute lambda functions in your account, or another account.
- Start AWS step functions state machines.
- Call HTTP endpoints hosted on Elastic Beanstalk, EC2, non-AWS HTTP operations
via public internet.
- VPC Private Link (API gateway private endpoint service). You can use API Gateway
to front APIs hosted by backends that exist privately in on-premises data centers,
using AWS DirectConnect links to your VPC.

### Takeaways ###

- API Gateway supports `RESTful APIs` (stateless) and `WebSocket APIs` (stateful)

- API endpoint format: `{api-id}.execute-api.{region}.amazonaws.com`

- Each deployment of Amazon API Gateway includes an `Amazon CloudFront` distribution under the covers.

- Use `in-memory cache` to improve performance

- Amazon API Gateway provides the ability to create Mock Integrations that allow you to generate API responses directly from API Gateway that client applications can develop against.

- API endpoint type can be `edge-optimized`, `regional`, or `private`, depending on where the majority of your API traffic originates from.

  * Edge optimized - The default for REST APIs. Capitalizes the names of HTTP headers.
  * Regional -  Reduces connection overhead. Pass all header names through as-is.
  * Private - Can only be accessed from your VPC using an interface VPC endpoint. Pass all header names through as-is.

- API Gateway `automatically protects your backend from DDoS attacks` whether
attacked with counterfeit requests (Layer 7) or SYN floods (Layer 3)

- Each resource/method combination that you create as part of your API is granted its own specific Amazon Resource Name (ARN) that can be referenced in AWS Identity and Access Management (IAM)8policies.

- Lambda authorizer functions authenticates the caller by:
`calling Oauth or SAML provider`, `generating IAM Policy` or `retrieving credentials from database`.
Lambda auhorizers useful if you want to implement a custom authorization scheme that uses:
  * A bearer token authentication strategy such as OAuth or SAML.
  * Request parameters to determine the caller's identity.

- `When an API is integrated with an AWS service (for example, AWS Lambda) in the back end, API Gateway must also have permissions to access integrated AWS resources` (for example, invoking a Lambda function) on behalf of the API caller.

- API key values must be unique. If you try to create two API keys with different names and the same value, API Gateway considers them to be the same API key.

- An API key can be associated with more than one usage plan. A usage plan can be associated with more than one stage. However, a given API key can only be associated with one usage plan for each stage of your API.

- Don't rely on API keys as your only means of authentication and authorization for your APIs. For one thing, if you have multiple APIs in a usage plan, a user with a valid API key for one API in that usage plan can access all APIs in that usage plan. Instead, use an IAM role, a Lambda authorizer, or an Amazon Cognito user pool.

- If you're using a developer portal to publish your APIs, note that all APIs in a given usage plan are subscribable, even if you haven't made them visible to your customers.

- Resource policies are JSON policy documents that you can attach to an API Gateway API to allow access to:

  * Users from a specified AWS account.
  * Specified source IP address ranges or CIDR block.
  * Specified VPCs or VPC endpoints (in any account),

- You can use AWS SAM to customize the content of some API Gateway error responses.

- API Gateway can:

  * Execute lambda functions in your account, or another account.
  * Start AWS step functions state machines.
  * Call HTTP endpoints hosted on Elastic Beanstalk, EC2, non-AWS HTTP operations
  via public internet.
  * VPC Private Link (API gateway private endpoint service). You can use API Gateway
  to front APIs hosted by backends that exist privately in on-premises data centers,
  using AWS DirectConnect links to your VPC.

### References ###

- [AWS API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

- [AWS Serverless Multi-tier Achitectures](https://d0.awsstatic.com/whitepapers/AWS_Serverless_Multi-Tier_Archiectures.pdf)   

- [AWS Serverless Application Model](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)  
