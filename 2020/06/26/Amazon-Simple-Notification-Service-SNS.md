---
path: "./2020/06/26/Amazon-Simple-Notification-Service-SNS.md"
date: "2020-06-26T16:03:00"
title: "Amazon SNS Quick Reference"
description: "Quick Reference - Amazon Simple Notification Service (SNS) Cheat sheet"
tags: ["AWS", "Amazon", "Amazon Simple Notification Service (Amazon SNS)", "Message Delivery Status", "Message Filtering", "dead-letter"]
lang: "en-us"
---

### What is Amazon Simple Notification Service (Amazon SNS) ###

Amazon Simple Notification Service (Amazon SNS) is a web service that
coordinates and manages the delivery or sending of messages to subscribing
endpoints or clients. Supported endpoints: Lambda, SQS, HTTP/S, Email, SMS.

__How Amazon SNS Works__
<br/>[How Amazon SNS Works](https://docs.aws.amazon.com/sns/latest/dg/images/sns-how-works.png)
<br/>_How Amazon SNS Works. Source: docs.aws.amazon.dom_

__Security__

- You can enable server-side encryption (SSE) for a topic to protect its data.

- All requests to topics with SSE enabled must use HTTPS and Signature Version 4.

- Use VPC endpoint to keep messages secure and within AWS network (i.e messages do not traverse the internet)

__VPC endpoint for SNS__
<br/>[VPC endpoint for SNS](https://docs.aws.amazon.com/sns/latest/dg/images/vpce-tutorial-architecture.png)
<br/>_VPC endpoint for SNS. Source: docs.aws.amazon.com/sns_

__Message Delivery Status__

-    Whether message was delivered to endpoint

-    Determine how long it took from publication till SNS sent message to endpoint

-    Identify response by the endpoint

Amazon SNS provides support to log the delivery status of notification messages sent to topics with the following Amazon SNS endpoints:

-    Application

-    HTTP

-    Lambda

-    SQS

__Message Filtering__

- By default, an Amazon SNS topic subscriber receives every message published to the topic. To receive a subset of the messages, a subscriber must assign a filter policy to the topic subscription.

- Filter policy - A simple JSON object containing attributes that define which messages the subscriber receives.

- A subscription filter policy allows you to specify attribute names and assign a list of values to each attribute name. When Amazon SNS evaluates message attributes against the subscription filter policy, it ignores message attributes that aren't specified in the policy.

- Additions or changes to a subscription filter policy require up to 15 minutes to fully take effect.

__Large Payloads__

- Amazon SNS and Amazon SQS let you send and receive large payloads (from 64 to 256 kilobytes in size).

- To send large payloads, you must use an AWS SDK that supports Signature Version 4.

- To avoid having Amazon SQS and HTTP/S endpoints process the JSON formatting of messages, Amazon SNS also allows raw message delivery

- When you enable raw message delivery for an Amazon SQS endpoint, any Amazon SNS metadata is stripped from the published message and the message is sent as is.

__Monitoring and Logging__

- `AWS X-Ray` - You can use X-Ray with Amazon SNS to trace and analyze the
messages that travel through your application.

- `CloudTrail` - captures API calls for Amazon SNS as events.

- `CloudWatch` - integrates with Amazon SNS. For example, you can set an alarm to send you an email notification if a specified threshold is met for an Amazon SNS metric, such as NumberOfNotificationsFailed.

__General Notes__

- A dead-letter queue is an Amazon SQS queue that an Amazon SNS subscription can target for messages that can't be delivered to subscribers successfully.

- `10` - The maximum number of attributes a message can have.

### References ###

- [Amazon SNS - Developer Guide](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)

- [AWS Certified Solutions Architect - Quick Reference](/2020/05/20/AWS-Certified-Solutions-Architect-Quick-Reference)

- [AWS Certified Solutions Architect Associate - Part 8 - Application Deployment](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-8_Application-deployment)
