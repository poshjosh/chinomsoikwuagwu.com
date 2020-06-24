---
path: "./2020/06/18/AWS-Lambda.md"
date: "2020-06-18T17:55:00"
title: "AWS Lambda Quick Reference"
description: "Quick Reference, Cheat sheet - AWS Lambda"
tags: ["Amazon", "AWS", "AWS Lambda", "Lambda Qualifier", "Lambda Runtime", "Lambda Event", "Lambda Concurrency", "Lambda Trigger", "Reserved concurrency", "Provisioned concurrency", "Lambda Autoscaling"]
lang: "en-us"
---

### Introduction ###

__What is AWS Lambda__

AWS Lambda allows code encapsulated in functions to be triggered in response to an event. That event can be one of several programmatic triggers (aka event source). Event sources are described [below](#integrating-with-other-services). You write the function in any of the supported languages (Node, JVM based, Python, Ruby, Go, .NET as of June 2020).

>AWS Lambda is a compute service that lets you run code without provisioning or managing servers. AWS Lambda executes your code only when needed and scales automatically, from a few requests per day to thousands per second. You pay only for the compute time you consume - there is no charge when your code is not running.

You can use AWS Lambda to:

- Run your code in response to events, such as changes to data in an S3 bucket.
- Run your code in response to HTTP requests using Amazon API Gateway
- Invoke your code using API calls made using AWS SDKs.

__Handling Business Logic__

When used in conjunction with Amazon API Gateway, an AWS Lambda function can be triggered directly by an HTTPS request, representative of the way web services are designed.

Functions are called handlers.

Create functions one per API or one per API method

Functions are free to reach out to any other dependencies it has (such as other functions, libraries, native binaries, or even external web services).

Lambda allows you to package all of your required dependencies in your function definition during creation. When you create your function, you specify which method inside your deployment package will act as the request handler.

__Amazon VPC Integration__

>AWS Lambda, the core of your logic tier, will be the component directly integrating with the data tier. Because the data tier will often contain sensitive business or user information, the data tier should be tightly secure. For AWS services with which you can integrate from a Lambda function, you can manage access control using IAM policies. These services include Amazon S3, Amazon DynamoDB, Amazon Kinesis, Amazon Simple Queue Service (Amazon SQS), Amazon Simple Notification Service (Amazon SNS), other AWS Lambda functions, and more. However, you might have a component that governs its own access control, such as a relational database. With components such as this you could achieve better security by deploying them within a VPC.

Resources (like databases) within a VPC can be made inaccessible over the Internet. The VPC also ensures that the only way to interact with your data from the Internet will be through the APIs that you’ve defined and the Lambda code functions that you’ve written

__Security__

To execute a Lambda function, it must be triggered by an event or service that has been permitted to do so via an IAM policy. It is possible to create a Lambda function that cannot be executed at all unless it is invoked by an API Gateway request that you define.

Each Lambda function itself assumes an IAM role. That IAM role defines the other AWS services/resources your Lambda function will be able to interact with (such as an Amazon DynamoDB table or an Amazon S3 bucket). This means you don't have to work directly with API keys.

__Integrating with the Data Tier__

By using AWS Lambda as your logic tier, you have a wide number of data storage options for your data tier. These options fall into two broad categories: Amazon VPC hosted data stores and IAM-enabled data stores. AWS Lambda has the ability to securely integrate with both.

Amazon VPC Hosted Data Stores: RDS, ElastiCache, Redshift, Private web services host by EC2

IAM-Enabled Data Stores: DynamoDB, S3, Elasticsearch Service

### Concepts ###

__Qualifier__ - When you invoke or view a function, you can include a qualifier to specify a version or alias.

__Runtime__ - Lambda runtimes allow functions in different languages to run in the same base execution environment. You configure your function to use a runtime that matches your programming language.

__Event__ - An event is a JSON formatted document that contains data for a function to process. The Lambda runtime converts the event to an object and passes it to your function code.

__Concurrency__ - Concurrency refers to the number of requests that your function is serving at any given time. When your function is invoked, Lambda provisions an instance of it to process the event. When the function code finishes running, it can handle another request. If the function is invoked again while a request is still being processed, another instance is provisioned, increasing the function's concurrency.

__Trigger__ - A trigger is a resource or configuration that invokes a Lambda function. This includes AWS services that can be configured to invoke a function, applications that you develop, and event source mappings. An event source mapping is a resource in Lambda that reads items from a stream or queue and invokes a function.

### Lambda Features ###

__Local storage__ - Your function has access to local storage in the `/tmp` directory. Instances of your function that are serving requests remain active for a few hours before being recycled.

__In order Processing__ - Unless noted otherwise, incoming requests might be processed out of order or concurrently.

__Application State__ - Store your application's state in other services, and don't rely on instances of your function being long lived. Use local storage and class-level objects to increase performance, but keep the size of your deployment package and the amount of data that you transfer onto the execution environment to a minimum.

__Concurrency controls__ - Use concurrency settings to ensure that your production applications are highly available and highly responsive.

- `Reserved concurrency` - To prevent a function from using too much concurrency.
Reserve a portion of your account's available concurrency for a function.

- `Provisioned concurrency` - To enable functions to scale without fluctuations in latency.
For functions that take a long time to initialize, or require extremely low latency for all invocations, provisioned concurrency enables you to pre-initialize instances of your function and keep them running at all times.

__Autoscaling__ - Lambda integrates with Application Auto Scaling to support auto scaling for provisioned concurrency based on utilization.

### Monitoring Lambda Applications ###

>AWS Lambda automatically monitors Lambda functions on your behalf and reports metrics through Amazon CloudWatch. To help you monitor your code as it executes, Lambda automatically tracks the number of requests, the execution duration per request, and the number of requests that result in an error. It also publishes the associated CloudWatch metrics. You can leverage these metrics to set CloudWatch custom alarms.

The Lambda console provides a built-in monitoring dashboard for each of your functions and applications.

__Metrics__. Each time your function is invoked, Lambda records metrics for the request, the function's response, and the overall state of the function. You can use metrics to set alarms that are triggered when function performance degrades, or when you are close to hitting concurrency limits in the current Region.

__Logs__. To debug and validate that your code is working as expected, you can output logs with the standard logging functionality for your programming language. The Lambda runtime uploads your function's log output to CloudWatch Logs. You can view logs in the CloudWatch Logs console, in the Lambda console, or from the command line.

__AWS X-Ray__. You can use AWS X-Ray to trace and debug requests served by your application.

### Resilience in AWS Lambda ###

__Versioning__ – You can use versioning in Lambda to save your function's code and configuration as you develop it. Together with aliases, you can use versioning to perform blue/green and rolling deployments.

__Scaling__ – Lambda automatically scales to handle `1,000 concurrent executions per Region`. When your function receives a request while it's processing a previous request, Lambda launches another instance of your function to handle the increased load.

__High availability__ – Lambda runs your function in multiple Availability Zones to ensure that it is available to process events in case of a service interruption in a single zone. If you configure your function to connect to a virtual private cloud (VPC) in your account, specify subnets in multiple Availability Zones to ensure high availability.

__Reserved concurrency__ – To make sure that your function can always scale to handle additional requests, you can reserve concurrency for it. Setting reserved concurrency for a function ensures that it can scale to, but not exceed, a specified number of concurrent invocations. This ensures that you don't lose requests due to other functions consuming all of the available concurrency.

__Retries__ – For asynchronous invocations and a subset of invocations triggered by other services, Lambda automatically retries on error with delays between retries. Other clients and AWS services that invoke functions synchronously are responsible for performing retries.

__Dead-letter queue__ – For asynchronous invocations, you can configure Lambda to send requests to a dead-letter queue if all retries fail. A dead-letter queue is an Amazon SNS topic or Amazon SQS queue that receives events for troubleshooting or reprocessing.

### AWS Lambda Use Cases ###

__In combination with other AWS products__ - Manipulating objects in an S3 bucket, processing events from a Kinesis Stream, database
items from a DynamoDB table or messages in an SQS queue, responding to REST API requests, etc

__Serverless Website or Mobile App Backend__ - While static content can be stored in S3 and CloudFront, dynamic API requests can be served by AWS Lambda in combination with API Gateway or AppSync.

__Unpredictable, high-variance load__ - Lambda is usually a good fit for workloads whose demand is un-predicable and highly variable,
due to its highly scalable performance.

__File Manipulation__ - A Lambda function can provide a quick and stable way to manipulate any kind of file: text, video, compressed, etc.

__Artificial intelligence__ - Implementing and maintaining an infrastructure to run AI systems on a large scale can be difficult. Some machine learning frameworks and libraries, such as Scikit Learn, SciPy, NumPy, spaCy, etc. can run smoothly on AWS Lambda. Models that are too big to deploy with the Lambda package can be stored in S3 and retrieved on demand. It’s possible to keep the model in memory for a warm start in the next invocations served by the same Lambda container.

__Disaster recovery__ - AWS Lambda can be used to automate tasks such as EBS snapshot and AMI creation to backup resources when configuring EC2 instances. Lambda can also be used to restore backup images and run CloudFormation templates.

__Extract, Transform, Load (ETL)__ - ETL jobs can be easily automated and scaled with AWS Lambda.

For more on Lambda use cases [click here](/2020/03/09/AWS-lamda-limitations-and-use-cases)

### AWS Lambda Limitations ###

__Runtime environment limitations as of 21/01/2020:__

-    The disk space is limited to 512 MB.
-    The default deployment package size is 50 MB.
-    Memory range is from 128 to 3008 MB. Previously, the maximum amount of memory available to your functions was 1536 MB.
-    Maximum execution timeout for a function is 15 minutes.
-    Request limitations by Lambda: Request and response body payload size are maximized to 6 MB.
-    The event request body can be up to 128 KB.
-    Lambda Cold Start. Takes some time for the Lambda function to handle the first request, because Lambda has to start a new instance of the function. This means infrequently-used serverless code may suffer from greater response latency. (This can be mitigated by periodically pinging your function.)
-    Application dependencies can be troublesome, especially if third-party libraries link to external packages like C programs for Python code. This becomes a problem with the 50 MB package size limitation.
-    Monitoring Lambda via cloud watch logs can get costly if you need that sort of thing.

For more on Lambda limitations [click here](/2020/03/09/AWS-lamda-limitations-and-use-cases)

<a name="integrating-with-other-services"></a>
### Integrating with other Services ###

AWS Lambda integrates with other AWS services to invoke functions. You can configure triggers to invoke a function in response to resource lifecycle events, respond to incoming HTTP requests, consume events from a queue, or run on a schedule.

__Services that Lambda reads events from__

- Amazon Kinesis

- Amazon DynamoDB

- Amazon Simple Queue Service (SQS)

__Services that invoke your Lambda function directly__

You grant the other service permission in the function's resource-based policy, and configure the other service to generate events and invoke your function. Depending on the service, the invocation can be synchronous or asynchronous.

- `Services that invoke Lambda functions synchronously` - Service waits for the response from your function and might retry on errors.

    Elastic Load Balancing (Application Load Balancer)

    Amazon Cognito

    Amazon Lex

    Amazon Alexa

    Amazon API Gateway

    Amazon CloudFront (Lambda@Edge)

    Amazon Kinesis Data Firehose

    AWS Step Functions

    Amazon Simple Storage Service Batch

- `Services that invoke Lambda functions asynchronously` - Lambda queues the event before passing it to your function. The other service gets a success response as soon as the event is queued and isn't aware of what happens afterwards. If an error occurs, Lambda handles retries, and can send failed events to a destination that you configure.

    Amazon Simple Storage Service

    Amazon Simple Notification Service

    Amazon Simple Email Service

    AWS CloudFormation

    Amazon CloudWatch Logs

    Amazon CloudWatch Events

    AWS CodeCommit

    AWS Config

    AWS IoT

    AWS IoT Events

    AWS CodePipeline

__Services that integrate with Lambda in other ways__ Some services integrate with Lambda in other ways that don't involve invoking functions.

    Amazon Elastic File System

    AWS X-Ray

Integrating Lambda with other Services is described in detail [here](https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html#intro-core-components-event-sources)

### Notes ###


### Troubleshooting ###

- `Problem` - The Lambda runtime needs permission to read the files in your deployment package.
`Solution` - You can use the `chmod` command to change the file mode.

- `Problem` - When you upload a function's deployment package from an Amazon S3 bucket, the bucket must be in the same Region as the function.
`Solution` - Create a deployment artifact bucket for each Region where you develop applications.

- The maximum size of the variables object that is stored in the function's configuration must not exceed 4096 bytes. This includes key names, values, quotes, commas, and brackets.

- Lambda reserves some environment variable keys for internal use. For example, AWS_REGION is used by the runtime to determine the current Region and cannot be overridden. Other variables, like PATH, are used by the runtime but can be extended in your function configuration.

For more on troubleshoot [click here](https://docs.aws.amazon.com/lambda/latest/dg/lambda-troubleshooting.html)

### Takeaways ###

- You can use AWS Lambda to:
  * Run your code in response to events, such as changes to data in an S3 bucket.
  * Run your code in response to HTTP requests using Amazon API Gateway
  * Invoke your code using API calls made using AWS SDKs.

- To execute a Lambda function, it must be triggered by an event or service that has been permitted to do so via an IAM policy.

- Each Lambda function itself assumes an IAM role that defines the other AWS services/resources your Lambda function can interact with.

- AWS Lambda has the ability to securely integrate with:

  * `Amazon VPC Hosted Data Stores`: RDS, ElastiCache, Redshift, Private web services host by EC2

  * `IAM-Enabled Data Stores`: DynamoDB, S3, Elasticsearch Service

- __Qualifier__ - When you invoke or view a function, you can include a qualifier to specify a version or alias.

- __Runtime__ - Lambda runtimes allow functions in different languages to run in the same base execution environment. You configure your function to use a runtime that matches your programming language.

- __Event__ - An event is a JSON formatted document that contains data for a function to process. The Lambda runtime converts the event to an object and passes it to your function code.

- __Concurrency__ - Concurrency refers to the number of requests that your function is serving at any given time.

  - `Reserved concurrency` - Reserve a portion of your account's available concurrency for a function, to prevent a function from using too much concurrency.

  - `Provisioned concurrency` - Enable dynamic changes in concurrency, to enable functions to scale without fluctuations in latency.

- __Trigger__ - A trigger is a resource or configuration that invokes a Lambda function.

- __Local storage__ - Your function has access to local storage in the `/tmp` directory.

- __In order Processing__ - `Incoming requests might be processed out of order` or concurrently, unless noted otherwise.

- __Application State__ - Store your application's state in other services, and don't rely on instances of your function being long lived.

- __Autoscaling__ - Lambda integrates with Application Auto Scaling to support auto scaling for provisioned concurrency based on utilization.

- __Metrics__. Lambda functions are monitored on your behalf and reports metrics through Amazon CloudWatch. Automatically tracked include: `number of requests`, `execution duration`, `number of error requests`.

- __Logs__. To debug and validate that your code is working as expected, you can output logs with the standard logging functionality for your programming language. The Lambda runtime uploads your function's log output to CloudWatch Logs. You can view logs in the CloudWatch Logs console, in the Lambda console, or from the command line.

- __AWS X-Ray__. You can use AWS X-Ray to trace and debug requests served by your application.

- __Versioning__ – You can use versioning in Lambda to save your function's code and configuration as you develop it.

- __Scaling__ – Lambda automatically scales to handle `1,000 concurrent executions per Region`.

- __High availability__ – Lambda runs your function in multiple AZs. If you configure your function to connect to a VPC in your account, specify subnets in multiple AZs.

- __Retries__ – Lambda automatically retries on error with delays between retries, for asynchronous invocations and a subset of invocations triggered by other services. Other clients and AWS services that invoke functions synchronously are responsible for performing retries.

- __Dead-letter queue__ – For asynchronous invocations, you can configure Lambda to send requests to a dead-letter queue if all retries fail.

__Lambda Use Cases__

- __In combination with other AWS products__ - Manipulating objects in an S3 bucket, processing events from a Kinesis Stream, database
items from a DynamoDB table or messages in an SQS queue, responding to REST API requests, etc

- __Serverless Website or Mobile App Backend__ - While static content can be stored in S3 and CloudFront, dynamic API requests can be served by AWS Lambda in combination with API Gateway or AppSync.

- __Unpredictable, high-variance load__

- __File Manipulation__

- __Artificial intelligence__ - Implementing and maintaining an infrastructure to run AI systems on a large scale can be difficult. Some machine learning frameworks and libraries, such as Scikit Learn, SciPy, NumPy, spaCy, etc. can run smoothly on AWS Lambda.

- __Disaster recovery__ - AWS Lambda can be used to automate tasks such as EBS snapshot and AMI creation to backup resources when configuring EC2 instances. Lambda can also be used to restore backup images and run CloudFormation templates.

- __Extract, Transform, Load (ETL)__ - ETL jobs can be easily automated and scaled with AWS Lambda.

__AWS Lambda Limitations as of 21/01/2020:__

-    The disk space is limited to 512 MB.
-    The default deployment package size is 50 MB.
-    Memory range is from 128 to 3008 MB. Previously, the maximum amount of memory available to your functions was 1536 MB.
-    Maximum execution timeout for a function is 15 minutes.
-    Request limitations by Lambda: Request and response body payload size are maximized to 6 MB.
-    The event request body can be up to 128 KB.
-    Lambda Cold Start. Takes some time for the Lambda function to handle the first request, because Lambda has to start a new instance of the function. This means infrequently-used serverless code may suffer from greater response latency. (This can be mitigated by periodically pinging your function.)
-    Application dependencies can be troublesome, especially if third-party libraries link to external packages like C programs for Python code. This becomes a problem with the 50 MB package size limitation.
-    Monitoring Lambda via cloud watch logs can get costly if you need that sort of thing.

- __Services that Lambda reads events from__

  * Amazon Kinesis
  * Amazon DynamoDB
  * Amazon Simple Queue Service (SQS)

- __Services that invoke your Lambda function directly__

  * `Synchronously` - Service waits for the response from your function and might retry on errors.

    Elastic Load Balancing (Application Load Balancer)
    Amazon Cognito
    Amazon Lex
    Amazon Alexa
    Amazon API Gateway
    Amazon CloudFront (Lambda@Edge)
    Amazon Kinesis Data Firehose
    AWS Step Functions
    Amazon Simple Storage Service Batch

  * - `Services that invoke Lambda functions asynchronously` - Lambda queues the event before passing it to your function. The other service gets a success response as soon as the event is queued and isn't aware of what happens afterwards. If an error occurs, Lambda handles retries, and can send failed events to a destination that you configure.

    Amazon Simple Storage Service
    Amazon Simple Notification Service
    Amazon Simple Email Service
    AWS CloudFormation
    Amazon CloudWatch Logs
    Amazon CloudWatch Events
    AWS CodeCommit
    AWS Config
    AWS IoT
    AWS IoT Events
    AWS CodePipeline

- __Services that integrate with Lambda in other ways__ Some services integrate with Lambda in other ways that don't involve invoking functions.

    Amazon Elastic File System
    AWS X-Ray

### References ###

- [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)

- [AWS Serverless Multi-tier Achitectures](https://d0.awsstatic.com/whitepapers/AWS_Serverless_Multi-Tier_Archiectures.pdf)   

- [AWS Serverless Application Model](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)  

- [Lambda Limitations and Use Cases](/2020/03/09/AWS-lamda-limitations-and-use-cases)
