---
path: "./2020/05/06/AWS-CloudFront-FAQs_curated.md"
date: "2020-05-06T17:58:44"
title: "AWS CloudFront FAQs - Curated"
description: "Curated FAQs on AWS CloudFront + A must read summary for quick start"
tags: ["AWS", "FAQ", "CloudFront", "Edge Locations", "Geo Restriction", "CloudFront compliance", "Field-Level Encryption", "Server Name Indication", "SNI Custom SSL", "Dedicated IP Custom SSL", "AWS Shield", "AWS Shield Advanced", "web application firewall (WAF)", "CloudFront limits", "cloudfront events", "lamda@edge", "ipv6", "price classes"]
lang: "en-us"
---

### Introduction ###

- This article features a curated set of FAQs on AWS CloudFront

- It is an estimated 17 - minute read.

- __TL;DR__ - Read the Takeaways at the end of this article.

### General ###

Q. __What is Amazon CloudFront?__

>Amazon CloudFront is a web service that gives businesses and web application developers an easy and cost effective way to distribute content with low latency and high data transfer speeds. Like other AWS services, Amazon CloudFront is a self-service, pay-per-use offering, requiring no long term commitments or minimum fees. With CloudFront, your files are delivered to end-users using a global network of edge locations.

Q. __How do I use Amazon CloudFront?__

To use Amazon CloudFront, you:

- Register the servers containing your static or/and dynamic content with Amazon CloudFront through a simple API call. This call will return a CloudFront.net domain name that you can use to distribute content from your origin servers via the Amazon CloudFront service. For instance, you can register the Amazon S3 bucket `bucketname.s3.amazonaws.com` as the origin for all your static content and an Amazon EC2 instance `dynamic.myoriginserver.com` for all your dynamic content. Then, using the API or the AWS Management Console, you can create an Amazon CloudFront distribution that might return `abc123.cloudfront.net` as the distribution domain name.

- Include the cloudfront.net domain name, or a CNAME alias that you create, in your web application, media player, or website.

Q. __Does Amazon charge for data transfer out to Amazon CloudFront?__

If you are using an AWS origin (e.g., Amazon S3, Amazon EC2, etc.), effective December 1, 2014, we are no longer charging for AWS data transfer out to Amazon CloudFront. This applies to data transfer from all AWS regions to all global CloudFront edge locations.

Q. __Does Amazon CloudFront work with non-AWS origin servers?__

Yes. There is no additional charge to use a custom origin.

Q. __How does Amazon CloudFront enable origin redundancy?__

For every origin that you add to a CloudFront distribution, you can assign a backup origin that can be used to automatically serve your traffic if the primary origin is unavailable. You can choose a combination of HTTP 4xx/5xx status codes that, when returned from the primary origin, trigger the failover to the backup origin. The two origins can be any combination of AWS and non-AWS origins.

### Edge Locations ###

Q. __Can I choose to serve content (or not serve content) to specified countries?__

Yes, the Geo Restriction feature lets you specify a list of countries in which your users can access your content. Alternatively, you can specify the countries in which your users cannot access your content. In both cases, CloudFront responds to a request from a viewer in a restricted country with an HTTP status code 403 (Forbidden).

Q. __Can I serve a custom error message to my end users?__

Yes, you can create custom error messages (for example, an HTML file or a .jpg graphic)

Q. __How long will Amazon CloudFront keep my files at the edge locations?__

The expiration period is __24 hours__. By default, if no cache control header is set, each edge location checks for an updated version of your file whenever it receives a request more than 24 hours after the previous time it checked the origin for changes to that file. For expiration period set to 0 seconds, Amazon CloudFront will revalidate every request with the origin server.

Q. __How do I remove an item from Amazon CloudFront edge locations?__

You can simply delete the file from your origin and as content in the edge locations reaches the expiration period defined in each object’s HTTP header, it will be removed. In the event that content needs to be removed before the specified expiration time, you can use the `Invalidation API`.

### Compliance ###

Q. __Is Amazon CloudFront PCI compliant?__

Yes, Amazon CloudFront is included in the set of services that are compliant with the Payment Card Industry Data Security Standard (PCI DSS) Merchant Level 1, the highest level of compliance for service providers

Q. __Is Amazon CloudFront HIPAA eligible?__

Yes, AWS has expanded its HIPAA compliance program to include Amazon CloudFront.

Q: __Is Amazon CloudFront SOC compliant?__

Yes, Amazon CloudFront is compliant with SOC (System & Organization Control) measures.

### HTTP and HTTP/2 ###

Q. __What types of HTTP requests are supported by Amazon CloudFront?__

Amazon CloudFront currently supports GET, HEAD, POST, PUT, PATCH, DELETE and OPTIONS requests.

Q. __Does Amazon CloudFront cache POST responses?__

Amazon CloudFront does not cache the responses to POST, PUT, DELETE, and PATCH requests

Q. __Does Amazon CloudFront support HTTP/2 without TLS?__

Not currently. However, most of the modern browsers support HTTP/2 only over an encrypted connection. You can learn more about using SSL with Amazon CloudFront here.

Q. __How do I enable my Amazon CloudFront distribution to support the WebSocket protocol?__

You can use WebSockets globally, as it is now supported by default.

### Security ###

Q. __What is Field-Level Encryption?__

>Field-Level Encryption is a feature of CloudFront that allows you to securely upload user-submitted data such as credit card numbers to your origin servers. Using this functionality, you can further encrypt sensitive data in an HTTPS form using field-specific encryption keys (which you supply) before a PUT/ POST request is forwarded to your origin. This ensures that sensitive data can only be decrypted and viewed by certain components or services in your application stack. To learn more about field-level encryption, see Field-Level Encryption in our documentation.

Q. __I am already using SSL/ TLS encryption with CloudFront, do I still need Field-Level Encryption?__

>Many web applications collect sensitive data such as credit card numbers from users that is then processed by application services running on the origin infrastructure. All these web applications use SSL/TLS encryption between the end user and CloudFront, and between CloudFront and your origin. Now, your origin could have multiple micro-services that perform critical operations based on user input. However, typically sensitive information only needs to be used by a small subset of these micro-services, which means most components have direct access to these data for no reason. A simple programming mistake, such as logging the wrong variable could lead to a customer’s credit card number being written to a file.

>With field-level encryption, CloudFront’s edge locations can encrypt the credit card data. From that point on, only applications that have the private keys can decrypt the sensitive fields. So the order fulfillment service can only view encrypted credit card numbers, but the payment services can decrypt credit card data. This ensures a higher level of security since even if one of the application services leaks cipher text, the data remains cryptographically protected.

Q. __What is Server Name Indication?__

Server Name Indication (SNI) is an extension of the Transport Layer Security (TLS) protocol. It allows a single IP address to be used across multiple servers. SNI requires browser support to add the server name, and while most modern browsers support it, there are a few legacy browsers that do not. For more details see the SNI section of the [CloudFront Developer Guide](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/SecureConnections.html#CNAMEsAndHTTPS) or the [SNI Wikipedia article](http://en.wikipedia.org/wiki/Server_Name_Indication).

Q. __What is the difference between SNI Custom SSL and Dedicated IP Custom SSL of Amazon CloudFront?__

Dedicated IP Custom SSL uses a one to one mapping between IP addresses and SSL certificates. Thus, Dedicated IP Custom SSL works with browsers and other clients that do not support SNI. Due to the current IP address costs, Dedicated IP Custom SSL is $600/month prorated by the hour. SNI Custom SSL is available at no additional cost beyond standard CloudFront data transfer and request fees.

Q. __Does Amazon CloudFront support access controls for paid or private content?__

Yes, Amazon CloudFront has an optional private content feature. When this option is enabled, Amazon CloudFront will only deliver files when you say it is okay to do so by securely signing your requests.

Q. __How can I safeguard my web applications delivered via CloudFront from DDoS attacks?__

`AWS Shield` is a managed service that provides protection against DDoS attacks for web applications running on AWS. As an AWS customer, you get AWS Shield Standard at no additional cost.
AWS Shield Standard provides protection for all AWS customers against common and most frequently occurring Infrastructure (layer 3 and 4) attacks like SYN/UDP Floods, Reflection attacks, and others.

`AWS Shield Advanced` is an optional paid service available to AWS Business Support and AWS Enterprise Support customers. AWS Shield Advanced provides additional protections against larger and more sophisticated attacks for your applications running on Elastic Load Balancing (ELB), Amazon CloudFront and Route 53.

Q. __How can I protect my web applications delivered via CloudFront?__

You can integrate your CloudFront distribution with `AWS WAF, a web application firewall` that helps protect web applications from attacks by allowing you to configure rules based on IP addresses, HTTP headers, and custom URI strings.

### Caching ###

Q. __Can I add or modify request headers forwarded to the origin?__

Yes, you can configure Amazon CloudFront to add custom headers, or override the value of existing headers, to requests forwarded to your origin.

Q. __How does Amazon CloudFront handle HTTP cookies?__
Amazon CloudFront supports delivery of dynamic content that is customized or personalized using HTTP cookies. To use this feature, you specify whether you want Amazon CloudFront to forward some or all of your cookies to your custom origin server.

Q. __Can I specify which query parameters are used in the cache key?__

Yes, the query string whitelisting feature allows you to easily configure Amazon CloudFront to only use certain parameters in the cache key, while still forwarding all of the parameters to the origin.

Q. __Is there a limit to the number of query parameters that can be whitelisted?__

Yes, you can configure Amazon CloudFront to whitelist up to 10 query parameters.

Q. __Does CloudFront support gzip compression?__

Yes, simply specify in your cache behavior settings and ensure that your client adds `Accept-Encoding: gzip` in the request header (most modern web browsers do this by default)

### Streaming ###

Q. __Does Amazon CloudFront support video-on-demand (VOD) streaming protocols?__

Yes.

If you have media files that have been converted to HLS, MPEG-DASH, or Microsoft Smooth Streaming, for example using AWS Elemental MediaConvert, prior to being stored in Amazon S3 (or a custom origin), you can use an Amazon CloudFront web distribution to stream in that format without having to run any media servers.

Alternatively, you can also run a third party streaming server (e.g. Wowza Media Server available on AWS Marketplace) on Amazon EC2, which can convert a media file to the required HTTP streaming format. This server can then be designated as the origin for an Amazon CloudFront web distribution.
Visit the [Video on Demand (VOD)](https://aws.amazon.com/answers/media-entertainment/video-on-demand-on-aws/) on AWS page to learn more.

### Limits ###

Q. __Can I use Amazon CloudFront if I expect usage peaks higher than 10 Gbps or 15,000 RPS?__

>Yes. Complete our request for higher limits [here](https://aws.amazon.com/cloudfront-request/), and we will add more capacity to your account within two business days.

Q: __Is there a limit to the number of distributions my Amazon CloudFront account may deliver?__

For the current limit on the number of distributions that you can create for each AWS account, see [Amazon CloudFront Limits](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_cloudfront) in the Amazon Web Services General Reference. To request a higher limit, please go to the [CloudFront Limit Increase Form](https://aws.amazon.com/support/createCase?type=service_limit_increase&serviceLimitIncreaseType=cloudfront-distributions).

Q: __What is the maximum size of a file that can be delivered through Amazon CloudFront?__

The maximum size of a single file that can be delivered through Amazon CloudFront is __20 GB__. This limit applies to all Amazon CloudFront distributions.

### Logging and reporting ###

Q: __Can I get access to request logs for content delivered through Amazon CloudFront?__

Yes. When you create or modify a CloudFront distribution, you can enable access logging. When enabled, this feature will automatically write detailed log information in a W3C extended format into an Amazon S3 bucket that you specify. Access logs contain detailed information about each request for your content, including the object requested, the date and time of the request, the edge location serving the request, the client IP address, the referrer, the user agent, the cookie header, and the result type (for example, cache hit/miss/error).

Q: __Does Amazon CloudFront offer ready-to-use reports so I can learn more about my usage, viewers, and content being served?__

Yes. You can access all our reporting options by visiting the Amazon CloudFront Reporting & Analytics dashboard in the AWS Management Console.

Q: __Can I tag my distributions?__

Yes.

Q: __Can I get a history of all Amazon CloudFront API calls made on my account for security, operational or compliance auditing?__

Yes. Turn on AWS `CloudTrail`, to receive a history of all Amazon CloudFront API calls made on your account.

Q: __Do you have options for monitoring and alarming metrics in real time?__

Yes. Use `CloudWatch` to monitor, alarm and receive notifications on the operational performance of your Amazon CloudFront distributions. CloudFront automatically publishes six operational metrics, each at 1-minute granularity, into Amazon CloudWatch.

### Lambda@Edge ###

Q. __What is Lambda@Edge?__

>[Lambda@Edge](https://aws.amazon.com/lambda/edge/) allows you to run code at global AWS edge locations without provisioning or managing servers, responding to end users at the lowest network latency. You just upload your Node.js/Python code to [AWS Lambda](https://aws.amazon.com/lambda/) and configure your function to be triggered in response to Amazon CloudFront requests (i.e., when a viewer request lands, when a request is forwarded to or received back from the origin, and right before responding back to the end user). The code is then ready to execute at every AWS edge location when a request for content is received, and scales with the volume of requests across CloudFront edge locations. Learn more in our [documentation](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-at-the-edge.html).

Q. __How do I customize content with Lambda@Edge?__

>Once you have identified a content delivery decision you would like to make at the CloudFront edge, identify which cache behaviors, and what point in the request flow the logic applies to (i.e., when a viewer request lands, when a request is forwarded to or received back from the origin, or right before responding back to the end viewer). Next, write a Node.js/Python Lambda function using the Lambda console or API, and associate it with the selected CloudFront trigger event for your distribution. Once saved, the next time an applicable request is made to your distribution, the function is propagated to the CloudFront edge, and will scale and execute as needed. Learn more in our [documentation](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-at-the-edge.html).

Q. __What events can be triggered with Amazon CloudFront?__

Four (4) events: Viewer request, Viewer response, Origin request, Origin response.

View   `- viewer request ->`   CloudFront   `- origin request ->`   Origin Server

View   `<- viewer response -`   CloudFront   `<- origin response -`   Origin Server

`Origin request` is made when requested object is not in cache or the cached version has expired.

### IPv6 ###

Q. __Should I expect a change in Amazon CloudFront performance when using IPv6?__

No

Q. __Are there any Amazon CloudFront features that will not work with IPv6?__

No, though there are changes you may need for internal IPv6 address processing before you turn on IPv6 for your distributions. Click here for the [changes you may need for internal ipv6 processing](https://aws.amazon.com/cloudfront/faqs/)

Q: __Does that mean if I want to use IPv6 at all I cannot use Trusted Signer URLs with IP whitelist?__

> No. If you want to use IPv6 and Trusted Signer URLs with IP whitelist you should use two separate distributions. You should dedicate a distribution exclusively to your Trusted Signer URLs with IP whitelist and disable IPv6 for that distribution. You would then use another distribution for all other content, which will work with both IPv4 and IPv6.

Q. __If I enable IPv6, will the IPv6 address appear in the Access Log?__

Yes, your viewer’s IPv6 addresses will now be shown in the “c-ip” field of the access logs

Q. __Can I disable IPv6 for all my new distributions?__

Yes, for both new and existing distributions

Q. __If I use Route 53 to handle my DNS needs and I created an alias record pointing to an Amazon CloudFront distribution, do I need to update my alias records to enable IPv6?__

>Yes, you can create Route 53 alias records pointing to your Amazon CloudFront distribution to support both IPv4 and IPv6 by using “A” and “AAAA” record type respectively. If you want to enable IPv4 only, you need only one alias record with type “A”.

### Billing ###

Q. __How will I be charged for my use of Amazon CloudFront?__

Amazon CloudFront charges are based on actual usage of the service in four areas: Data Transfer Out, HTTP/HTTPS Requests, Invalidation Requests, and Dedicated IP Custom SSL certificates associated with a CloudFront distribution.

- __Data Transfer Out__ - volume in GB

  * __Data Transfer Out to Internet__

  You are charged for the volume of data transferred out from Amazon CloudFront edge locations, measured in GB. You can see the rates for Amazon CloudFront data transfer to the internet here. Note that your data transfer usage is totaled separately for specific geographic regions, and then cost is calculated based on pricing tiers for each area. If you use other AWS services as the origins of your files, you are charged separately for your use of those services, including for storage and compute hours. If you use an AWS origin (such as Amazon S3, Amazon EC2, and so on), effective December 1, 2014, we do not charge for AWS data transfer out to Amazon CloudFront. This applies to data transfer from all AWS Regions to all global CloudFront edge locations.

  * __Data Transfer Out to Origin__ - volume in GB

  You will be charged for the volume of data transferred out, measured in GB, from the Amazon CloudFront edge locations to your origin (both AWS origins and other origin servers). You can see the rates for Amazon CloudFront data transfer to Origin here.

- __HTTP/HTTPS Requests__ - count

You will be charged for number of HTTP/HTTPS requests made to Amazon CloudFront for your content. You can see the rates for HTTP/HTTPS requests here.

- __Invalidation Requests__ - count paths in invalidation request

You are charged per path in your invalidation request. A path listed in your invalidation request represents the URL (or multiple URLs if the path contains a wildcard character) of the object you want to invalidate from CloudFront cache. You can request up to 1,000 paths each month from Amazon CloudFront at no additional charge. Beyond the first 1,000 paths, you will be charged per path listed in your invalidation requests. You can see the rates for invalidation requests here.

- __Dedicated IP Custom SSL__ $600 per month pro-rated by the hour

You pay $600 per month for each custom SSL certificate associated with one or more CloudFront distributions using the Dedicated IP version of custom SSL certificate support. This monthly fee is pro-rated by the hour. For example, if you had your custom SSL certificate associated with at least one CloudFront distribution for just 24 hours (i.e. 1 day) in the month of June, your total charge for using the custom SSL certificate feature in June will be (1 day / 30 days) * $600 = $20. To use Dedicated IP Custom SSL certificate support, upload a SSL certificate and use the AWS Management Console to associate it with your CloudFront distributions. If you need to associate more than two custom SSL certificates with your CloudFront distribution, please include details about your use case and the number of custom SSL certificates you intend to use in the CloudFront Limit Increase Form.

Usage tiers for data transfer are measured separately for each geographic region.

Q. __Can I choose to only serve content from less expensive Amazon CloudFront regions?__

Yes, with __Price Classes__ you reduce your delivery prices by excluding Amazon CloudFront’s more expensive edge locations from your Amazon CloudFront distribution.

### Takeaways ###

- Effective 1 December 2014, Amazon is no longer charging for AWS data transfer out to Amazon CloudFront, if you are using an AWS origin (e.g., Amazon S3, Amazon EC2, etc.)

- Amazon CloudFront works with non-AWS origin servers

- `Geo Restriction` feature lets you specify a list of countries in which your users can access your content. Alternatively, you can specify the countries in which your users cannot access your content.

- You can create custom error messages (for example, an HTML file or a .jpg graphic)

- The default CloudFront cache expiration period is __24 hours__.

- To remove an item from CloudFront edge locations, simply delete the file from your origin and as content in the edge locations reaches the expiration period defined in each object’s HTTP header, it will be removed. In the event that content needs to be removed before the specified expiration time, you can use the `Invalidation API`.

- Amazon CloudFront is compliant with:

  * Payment Card Industry Data Security Standard (PCI DSS) Merchant Level 1
  * HIPAA
  * System & Organization Control (SOC) measures

- Amazon CloudFront currently supports GET, HEAD, POST, PUT, PATCH, DELETE and OPTIONS requests.

- Amazon CloudFront does not cache the responses to POST, PUT, DELETE, and PATCH requests

- CloudFront supports HTTP/2 only over an encrypted connection.

- `Field Level Encryption` enables you further encrypt sensitive data in an
HTTPS form using field-specific encryption keys (which you supply) before a
PUT/ POST request is forwarded to your origin. only applications that have the
private keys can decrypt the sensitive fields. This could be useful when for
example multiple microservices receive form inputs but only those with the
required private key can decrypt and use the actual value of the credit card field.

- Amazon CloudFront has an optional private content feature. When this option is enabled, Amazon CloudFront will only deliver files when you say it is okay to do so by securely signing your requests.

- `AWS Shield` is a managed service that provides protection against DDoS attacks for web applications running on AWS. As an AWS customer, you get AWS Shield Standard at no additional cost. AWS Shield Standard provides protection for all AWS customers against common and most frequently occurring Infrastructure (layer 3 and 4) attacks like SYN/UDP Floods, Reflection attacks, and others.

- `AWS Shield Advanced` is an optional paid service available to AWS Business Support and AWS Enterprise Support customers. AWS Shield Advanced provides additional protections against larger and more sophisticated attacks for your applications running on Elastic Load Balancing (ELB), Amazon CloudFront and Route 53.

- You can integrate your CloudFront distribution with `AWS WAF, a web application firewall` that helps protect web applications from attacks by allowing you to configure rules based on IP addresses, HTTP headers, and custom URI strings.

- With CloudFront caching, you can:

  * Modify, add request headers forwarded to origin server

  * Specify whether you want Amazon CloudFront to forward some or all of your cookies to your custom origin server.

  * Specify which query parameters are used in the cache key

  * You can configure Amazon CloudFront to whitelist up to 10 query parameters.

  * Amazon CloudFront support video-on-demand (VOD) streaming protocols

- You can use Amazon CloudFront for usage peaks higher than 10 Gbps or 15,000 RPS. Complete the request for higher limits [here](https://aws.amazon.com/cloudfront-request/)

- The maximum size of a single file that can be delivered through Amazon CloudFront is __20 GB__.

- When you create or modify a CloudFront distribution, you can enable access logging. When enabled, this feature will automatically write detailed log information in a W3C extended format into an Amazon S3 bucket that you specify. Access logs contain detailed information about each request for your content, including the object requested, the date and time of the request, the edge location serving the request, the client IP address, the referrer, the user agent, the cookie header, and the result type (for example, cache hit/miss/error).

- You can access all CloudFront reporting options by visiting the Amazon CloudFront Reporting & Analytics dashboard in the AWS Management Console.

- Turn on AWS `CloudTrail`, to receive a history of all Amazon CloudFront API calls made on your account.

- Use `CloudWatch` to monitor, alarm and receive notifications on the operational performance of your Amazon CloudFront distributions. CloudFront automatically publishes six operational metrics, each at 1-minute granularity, into Amazon CloudWatch.

- [Lambda@Edge](https://aws.amazon.com/lambda/edge/) allows you to run code at global AWS edge locations without provisioning or managing servers, responding to end users at the lowest network latency.

- Four (4) events can be triggered with Amazon CloudFront: Viewer request, Viewer response, Origin request, Origin response.

  View   `- viewer request ->`   CloudFront   `- origin request ->`   Origin Server

  View   `<- viewer response -`   CloudFront   `<- origin response -`   Origin Server

`Origin request` is made when requested object is not in cache or the cached version has expired.

- If you enable IPv6, your viewer’s IPv6 addresses will now be shown in the `c-ip` field of the access logs

- You can disable IPv6 for both new and existing distributions

- Amazon CloudFront charges are based on actual usage of the service in four areas:

  * Data Transfer Out (to internet & to origin server) - volume  in GB
  * HTTP/HTTPS Requests - number of requests
  * Invalidation Requests - number of paths in invalidation requests
  * Dedicated IP Custom SSL certificates - $600 per month pro-rated by the hour

- `Price Classes` enable you reduce your delivery prices by excluding Amazon CloudFront’s more expensive edge locations from your Amazon CloudFront distribution.

### References ###

- [AWS FAQs](https://aws.amazon.com/faqs/)

- [AWS CloudFront FAQs](https://aws.amazon.com/cloudfront/faqs/)

- [AWS Developer Guide - Secure Connections](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/SecureConnections.html#CNAMEsAndHTTPS)

- [Server Name Indication](http://en.wikipedia.org/wiki/Server_Name_Indication)
