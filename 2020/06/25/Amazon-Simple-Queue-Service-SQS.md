---
path: "./2020/06/25/Amazon-Simple-Queue-Service-SQS.md"
date: "2020-06-24T12:47:00"
title: "Amazon SQS Quick Reference"
description: "Quick Reference - Amazon Simple Queue Service (SQS) Cheat sheet"
tags: ["AWS", "Amazon", "Amazon Simple Queue Service (SQS)", "message retention period", "standard queue", "fifo queue", "message deduplication ID", "deduplication interval", "Message group Id", "Receive request attempt ID", "AWSTraceHeader", "short polling", "long polling", "dead-letter queue", "visibility timeout"]
lang: "en-us"
---

### Introduction ###

Amazon Simple Queue Service (SQS) is a fully managed message queuing service.

- `4 days` - Default message retention period. (Possible values 60 secs - 14 days)

- `256kb` - max size of SQS messages. (Including attributes but excluding message system attributes)

- Queue name format: `https://sqs.[AWS Region].amazonaws.com/[AWS Account Number]/[Queue Name]`
e.g `https://sqs.us-east-2.amazonaws.com/123456789012/MyQueue`

- The name of a FIFO queue must end with the `.fifo` suffix. The suffix counts towards the 80-character queue name quota.

SQS Queue Types

Queue Property      | Standard                | FIFO
--------------------|-------------------------|----------------------------------
Sequential delivery | NO                      | YES
Transactions/sec    | Unlimited               | 3000 with batching, 300 without
Message delivery    | At least once           | Exactly once
Delays              | Per message & per queue | Only per queues                      
Message group ID    | Not required            | Required

- `SNS not compatible with FIFO queues.`

- `The Amazon SQS Buffered Asynchronous Client doesn't currently support FIFO queues.`

### Working with Messages ###

- If a message with a particular `message deduplication ID` is sent
successfully, any messages sent with the same message deduplication ID are
accepted successfully but aren't delivered during the 5-minute `deduplication interval`.

- `Message group Id` - Messages that belong to the same message group are always processed in order.

- `Receive request attempt ID` - The token used for deduplication of ReceiveMessage calls.

- `Sequence number` - The large, non-consecutive number that Amazon SQS assigns to each message.

- Message deduplication applies to an entire queue, not to individual message groups.

- Amazon SQS continues to keep track of the message deduplication ID even after the message is received and deleted.

- To configure deduplication, you must do ONE of the following:

  * Enable content-based deduplication. This instructs Amazon SQS to use a SHA-256 hash to generate the message deduplication ID using the body of the message.

  * Explicitly provide the message deduplication ID. (Use this, particularly if your application may send identical message bodies)

- If it takes a long time to process messages and your visibility timeout is set to a high value, consider adding a receive request attempt ID to each ReceiveMessage action. This allows you to retry receive attempts in case of networking failures and prevents queues from pausing due to failed receive attempts.

- If you receive a message more than once, each time you receive it, you get a different receipt handle. You must provide the most recently received receipt handle when you request to delete the message (otherwise, the message might not be deleted).

- Each message can have up to 10 attributes.

- You can use message attributes to attach custom metadata. Likewise, you can use
message system attributes to store metadata for other AWS services, such as AWS X-Ray.

- `AWSTraceHeader is the only supported message system attribute`, as at 25
June 2020. Its type must be String and its value must be a correctly formatted
AWS X-Ray trace header string.

### Short and long polling ###

- `Short polling` - The default. The ReceiveMessage request queries only a
subset of the servers (based on a weighted random distribution) to find messages
that are available to include in the response. Amazon SQS sends the response
right away, even if the query found no messages.

- `Long polling` - The ReceiveMessage request queries all of the servers for
messages. Amazon SQS sends a response after it collects at least one available
message, up to the maximum number of messages specified in the request. Amazon
SQS sends an empty response only if the polling wait time expires.

- When the wait time for the ReceiveMessage API action is greater than 0,
long polling is in effect.

- `20 seconds` - The maximum long polling wait time.

- `Reduce cost` with long polling as it eliminates the number of empty responses

### Dead letter queue ###

Amazon SQS supports dead-letter queues, which other queues (source queues) can target for messages that can't be processed (consumed) successfully.

>The redrive policy specifies the source queue, the dead-letter queue, and the conditions under which Amazon SQS moves messages from the former to the latter if the consumer of the source queue fails to process a message a specified number of times. When the ReceiveCount for a message exceeds the maxReceiveCount for a queue, Amazon SQS moves the message to a dead-letter queue (with its original message ID). For example, if the source queue has a redrive policy with maxReceiveCount set to 5, and the consumer of the source queue receives a message 6 times without ever deleting it, Amazon SQS moves the message to the dead-letter queue.

The dead-letter queue of a FIFO queue must also be a FIFO queue. Similarly, the dead-letter queue of a standard queue must also be a standard queue.

Don’t use a dead-letter queue with standard queues when you want to be able to keep retrying the transmission of a message indefinitely. For example, don’t use a dead-letter queue if your program must wait for a dependent process to become active or available.

Don’t use a dead-letter queue with a FIFO queue if you don’t want to break the exact order of messages or operations. For example, don’t use a dead-letter queue with instructions in an Edit Decision List (EDL) for a video editing suite, where changing the order of edits changes the context of subsequent edits.

### Visibility Timeout ###

Immediately after a message is received, it remains in the queue. To prevent other consumers from processing the message again, Amazon SQS sets a visibility timeout, a period of time during which Amazon SQS prevents other consumers from receiving and processing the message.

The default visibility timeout for a message is 30 seconds. The minimum is 0 seconds. The maximum is 12 hours.

For standard queues, the visibility timeout isn't a guarantee against receiving a message twice.

A message is considered to be in flight after it is received from a queue by a consumer, but not yet deleted from the queue

120,000 - Max inflight messages for standard queue

20,000 - Max inflight messages for FIFO queue  

### General Notes ###

- Delay queues let you postpone the delivery of new messages to a queue for a number of seconds, for example, when your consumer application needs additional time to process messages. If you create a delay queue, any messages that you send to the queue remain invisible to consumers for the duration of the delay period.

- The default (minimum) delay for a queue is 0 seconds. The maximum is 15 minutes.

- Delay queues are similar to visibility timeouts because both features make messages unavailable to consumers for a specific period of time.

- Temporary queues help you save development time and deployment costs when using common message patterns such as request-response. Temporary queues are automatically mapped onto a single Amazon SQS queue.

- For example you create a temporary queue for a login request and after receiving the response, delete the temporary queue.

- Message timers let you specify an initial invisibility period for a message added to a queue. For example, if you send a message with a 45-second timer, the message isn't visible to consumers for its first 45 seconds in the queue. The default (minimum) delay for a message is 0 seconds. The maximum is 15 minutes.

- You can use the `Amazon SQS Extended Client Library for Java` and S3 to manage Amazon SQS messages. This is especially useful for storing and consuming messages up to 2 GB in size. Use the library to send a message that references a single message object stored in an Amazon S3 bucket. Also get and delete the message from the S3 bucket.

- Server-side encryption (SSE) lets you transmit sensitive data in encrypted queues. SSE protects the contents of messages in queues using keys managed in AWS Key Management Service (AWS KMS).

- CloudTrail captures API calls related to Amazon SQS queues as events.

- CloudWatch metrics for your Amazon SQS queues are automatically collected and pushed to CloudWatch at one-minute intervals. These metrics are gathered on all queues that meet the CloudWatch guidelines for being active. CloudWatch considers a queue to be active for up to six hours if it contains any messages or if any action accesses it.

### Best Practices ###

- The producer should provide message deduplication ID values for each message send in the following scenarios:

  * Messages sent with identical message bodies that Amazon SQS must treat as unique.
  * Messages sent with identical content but different message attributes that Amazon SQS must treat as unique.
  * Messages sent with different content (for example, retry counts included in the message body) that Amazon SQS must treat as duplicates

- For optimal performance, set the visibility timeout to be larger than the AWS SDK read timeout.

- To avoid processing duplicate messages in a system with multiple producers and consumers where throughput and latency are more important than ordering, the producer should generate a unique message group ID for each message.

__Designing for outage recovery scenarios__

The deduplication process in FIFO queues is time-sensitive. When designing your
application, ensure that both the producer and the consumer can recover in case
of a client or network outage.

  >The producer must be aware of the deduplication interval of the queue. Amazon SQS has a minimum deduplication interval of 5 minutes. Retrying SendMessage requests after the deduplication interval expires can introduce duplicate messages into the queue. For example, a mobile device in a car sends messages whose order is important. If the car loses cellular connectivity for a period of time before receiving an acknowledgement, retrying the request after regaining cellular connectivity can create a duplicate.

  >The consumer must have a visibility timeout that minimizes the risk of being unable to process messages before the visibility timeout expires. You can extend the visibility timeout while the messages are being processed by calling the ChangeMessageVisibility action. However, if the visibility timeout expires, another consumer can immediately begin to process the messages, causing a message to be processed multiple times. To avoid this scenario, configure a dead-letter queue.

### Takeaways ###

- `4 days` - Default message retention period. (Possible values 60 secs - 14 days)

- `256kb` - max size of SQS messages. (Including attributes but excluding message system attributes)

Queue Property      | Standard                | FIFO
--------------------|-------------------------|----------------------------------
Sequential delivery | NO                      | YES
Transactions/sec    | Unlimited               | 3000 with batching, 300 Without
Message delivery    | At least once           | Exactly once
Delays              | Per message & per queue | Only per queues                      
Message group ID    | Not required            | Required

- `SNS not compatible with FIFO queues.`

- If a message with a particular `message deduplication ID` is sent
successfully, any messages sent with the same message deduplication ID are
accepted successfully but aren't delivered during the 5-minute `deduplication interval`.

- `Message group Id` - Messages that belong to the same message group are always processed in order.

- `Receive request attempt ID` - The token used for deduplication of ReceiveMessage calls.

- `Sequence number` - The large, non-consecutive number that Amazon SQS assigns to each message.

- If you receive a message more than once, each time you receive it, you get a different receipt handle. You must provide the most recently received receipt handle when you request to delete the message (otherwise, the message might not be deleted).

- `10` - Max attributes per message.

- `AWSTraceHeader is the only supported message system attribute`, as at 25 June 2020.

- When the wait time for the ReceiveMessage API action is greater than 0,
long polling is in effect.

- `20 seconds` - The maximum long polling wait time.

- `Reduce cost` with long polling as it eliminates the number of empty responses

- The dead-letter queue of a FIFO queue must also be a FIFO queue. Similarly,
the dead-letter queue of a standard queue must also be a standard queue.

- `30 seconds` - The default visibility timeout for a message. The minimum is
0 seconds. The maximum is 12 hours.

- For standard queues, the visibility timeout isn't a guarantee against receiving a message twice.

- Delay queues let you postpone the delivery of new messages to a queue for a number of seconds.

- The default (minimum) delay for a queue is 0 seconds. The maximum is 15 minutes.

- Temporary queues help you save development time and deployment costs when using common message patterns such as request-response. Temporary queues are automatically mapped onto a single Amazon SQS queue.

- For example you create a temporary queue for a login request and after receiving the response, delete the temporary queue.

- Message timers let you specify an initial invisibility period for a message added to a queue.

- To store and consume messages up to 2GB in size - You can use the `Amazon SQS Extended Client Library for Java` and S3.

- SSE protects the contents of messages in queues using keys managed in AWS KMS.

- CloudTrail captures API calls related to Amazon SQS queues as events.

- CloudWatch metrics for your Amazon SQS queues are automatically collected and pushed to CloudWatch at one-minute intervals.

- The producer should provide message deduplication ID values for each message send in the following scenarios:

  * Messages sent with identical message bodies that Amazon SQS must treat as unique.
  * Messages sent with identical content but different message attributes that Amazon SQS must treat as unique.
  * Messages sent with different content (for example, retry counts included in the message body) that Amazon SQS must treat as duplicates

- For optimal performance, set the visibility timeout to be larger than the AWS SDK read timeout.

- Special case to `generate a unique message group ID for each message` - to
avoid processing duplicate messages in a system with multiple producers and
consumers where throughput and latency are more important than ordering.

### References ###

- [AWS SQS Developer Guide](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)

- [AWS Certified Solutions Architect - Quick Reference](/2020/05/20/AWS-Certified-Solutions-Architect-Quick-Reference)

- [AWS Certified Solutions Architect Associate - Part 8 - Application Deployment](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-8_Application-deployment)
