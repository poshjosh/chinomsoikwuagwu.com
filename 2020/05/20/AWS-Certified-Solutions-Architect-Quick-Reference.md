---
path: "./2020/05/20/AWS-Certified-Solutions-Architect-Quick-Reference.md"
date: "2020-05-20T22:07:42"
title: "AWS Certified Solutions Architect - Quick Reference"
description: "Quick Reference, Cheat sheet - AWS Certified Solutions Architect Certification"
tags: ["AWS", "FAQ", "EC2", "VPC", "hibernate", "stop", "VPC traffic", "peering"]
lang: "en-us"
---

__Resource Access Manager (RAM)__ Securely share AWS resources with any AWS
account or within your AWS Organization. You can share:

- AWS App Mesh
- Amazon Aurora - DB Clusters
- AWS CodeBuild
- Amazon EC2 - Capacity reservations, Customer owned IPv4 addresses, dedicated
hosts, prefix lists, traffic mirror targets, transit gateway.
- Amazon EC2 Image Builder
- AWS License Manager
- AWS Resource Groups
- Amazon Route 53

- Resources are shared at no additional cost.
- You can specify IAM policies to control access to resources shared with you.
- All calls to RAM APIs are logged in AWS CloudTrail.
- CloudWatch Events are triggered whenever there are changes to Resource Shares.

__AWS SFTP__

Fully managed service enabling transfers over SFTP, while the data is stored
in Amazon S3.

SFTP - SSH File Transfer Protocol

Support for VPC Security Groups and Elastic IP addresses.

- Using security groups, customers can apply rules to limit SFTP access to
specific public IPv4 addresses or IPv4 address ranges.

- Elastic IP addresses with their server endpoint. This enables end users
behind firewalls to whitelist access to the SFTP server via a static IP, or
a pair of IPs for failover.

__SageMaker__

__CloudWatch__

CloudWatch alarms trigger actions only when the alarm state changes and is
maintained for a specified number of periods.

There is an exception to this behavior for CloudWatch alarms that are associated
with Amazon EC2 Auto Scaling actions. A CloudWatch alarm keeps triggering
Auto Scaling actions when that alarm is in a specified state, even if there are
no state changes and the alarm remains in that state.

__AWS ParallelCluster__

Cluster-management tool for AWS that makes it easy for scientists, researchers,
and IT administrators to deploy and manage HPC clusters in the AWS Cloud.
AWS ParallelCluster supports FSx for Lustre.

__Databases__

- Easily make schema changes - DynamoDB

- Replicate across regions - Aurora (Redshift can only create snapshots in the different region)

- Automated cross-region snapshot - Redshift.

- No VPC endpoint for RDS, but for RDS Data Api for Aurora.
[See this](https://aws.amazon.com/about-aws/whats-new/2020/02/amazon-rds-data-api-now-supports-aws-privatelink/) (6 Feb 2020),
[and this](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html)

- An `interface endpoint` is an elastic network interface with a private IP
address from the IP address range of your subnet that serves as an entry point
for traffic destined to a supported service.

- A `gateway endpoint` is a gateway that you specify as a target for a route in
your route table for traffic destined to a supported AWS service. Supported:

  * Amazon S3
  * DynamoDB

- [Scenarios for Accessing an RDS DB Instance in a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.Scenarios.html)

  `Private IP`
  * EC2 and DB in same VPC - Use custom rule in DB security group to allow connection for EC2 security group.
  * EC2 in different VPC - Use VPC peering.
  * EC2 not in a VPC, DB in a VPC - Use ClassicLink

  `Internet bound`
  * Client in internet, DB in a VPC

    - Configure VPC with a public subnet, and an internet gateway to enable communication over the internet.
    - Ensure DB security group allow client application access.

  * EC2 in VPC, DB not in a VPC

    - Configure VPC with a public subnet, and an internet gateway to enable communication over the internet.
    - Ensure DB is marked as publicly accessible.

  * EC2 and DB not in a VPC

    - Use DB endpoint and port.
    - Ensure DB security permits access from the port specified when creating the DB.

  * Client in internet, DB not in a VPC

    - Ensure DB security group includes the necessary ingress rules for your client application to connect.

__High Availability__

- Given 2-tier applications, having EC2 instances running web layer in public
and database layer in private subnets, how do you provide high availability.

__AWS Single Sign On (SSO)__

- Permission sets can control time duration for user login to the AWS Console
by setting the session duration. Default session duration is `1 hour`, while
the maximum that could be set is `12 hours`.

__Elastic Beanstalk__

- Run production RDS database outside the Elastic Beanstalk environment.
- You configure your application to connect to the database outside of
functionality provided by Elastic Beanstalk.
- The database instance remains up and running when the Elastic Beanstalk
environment is terminated.

__Athena__

- eliminate s3 errors while querying data
- reduce cost associated with queries
To achieve the above:
1. Partition data based upon date & location.
2. Create separate Workgroups based upon user groups.

__AWS Glue__

- To decrease scanning time while scanning data in S3 buckets (_by ensuring
ensuring only changes in datasets are scanned_):
  `Enable Job Bookmark in AWS Glue`

__AWS XRay__

- To ensure cost is minimized.
  `Use sampling at low rate`
  > Sampling rate can be lower to collect significant number of requests statistically,
  to get optimum traces, and have a cost-effective solution.

__Key Management Service (KMS)__

- `Region Specific keys` - Keys generated by AWS KMS are only stored and used
in the region in which they were created. They cannot be transferred to another region

- You can only import 256 bit symmetric keys

- CMKs are used by AWS services to encrypt data on your behalf.

  * __Customer Managed CMK__ - You can define usage policy, access control,
  permissions, key rotation period.

    - __asymmetric customer managed CMKs__

      * Key material can only be generated within AWS KMS HSMs
      * There is no option for automatic key rotation.

  * __AWS Managed CMK__ - Can be tracked, all usage logged in CloudTrail

- Access to AWS KMS CMK is a combination of both Key policy and IAM policy.
IAM Policy is used to grant access to a user for AWS KMS while Key policy
is used to control access to CMK in AWS KMS.

__Cloud Hardware Security Module (HSM)__


- KSM only uses symmetric keys, while Cloud HSM allows symmetric and asymmetric keys.

- CloudHSM must be provisioned inside an Amazon VPC. However, your application
must not be in the same VPC as the CloudHSM

If an HSM fails or loses network connectivity, the HSM will be automatically replaced.

CloudHSM publishes multiple CloudWatch metrics for CloudHSM Clusters and for individual HSMs. You can use the AWS CloudWatch Console, API or SDK to obtain or alarm on these metrics.

AWS services integrate with AWS Key Management Service, which in turn is integrated with AWS CloudHSM through the KMS custom key store feature. If you want to use the server-side encryption offered by many AWS services (such as EBS, S3, or Amazon RDS), you can do so by configuring a custom key store in AWS KMS.

If your CloudHSM cluster only has a single HSM, it is possible to lose keys that were created since the most recent daily backup. CloudHSM clusters with two or more HSMs, ideally in separate Availability Zones, will not lose keys if a single HSM fails.

__Serverless__

- __Lamda__ - Central to many serverless designs. automatically runs your code
on highly available, fault-tolerant infrastructure spread across multiple
Availability Zones in a single region without requiring you to provision or
manage servers.

- AWS Fargate — a serverless compute engine for containers.

- Amazon DynamoDB — a fast and flexible NoSQL database.

- Amazon Aurora Serverless — a MySQL compatible relational database.

- Amazon API Gateway — a service to create, publish, monitor and secure APIs.

- Amazon S3 — a secure, durable and highly scalable object storage.

- Amazon Elastic File System — a simple, scalable, elastic file storage.

- Amazon SNS — a fully managed pub/sub messaging service.

- Amazon SQS — a fully managed message queuing service

- [Read more on AWS - Serverless](https://aws.amazon.com/serverless/)

__API Gateway__

Amazon API Gateway resource policies are JSON policy documents that you attach
to an API to control whether you API can be invoked by:

-    Users from a specified AWS account.

-    Specified source IP address ranges or CIDR blocks.

-    Specified virtual private clouds (VPCs) or VPC endpoints (in any account).

__Identity and Access Management (IAM)__

- An __instance profile__ is a container for an IAM role that you can use to
pass role information to an EC2 instance when the instance starts.

  * If you use the AWS Management Console to create a role for Amazon EC2, an   
instance profile with same name as the role is automatically created.

  * An instance profile can contain only one IAM role.

- Web identity federation supports the following identity providers:
  `Amazon`, `Facebook`, `Google`

- __IAM Roles for ECS tasks__ functions similar to how EC2 instance profiles
provide credentials for EC2 instances.

__Relational Database Service (RDS)__

- Engines: `Aurora`, `PostgreSQL`, `MySQL`, `MariaDB`, `Oracle`, `SQL Server`

- Encryption at rest when enabled applies to `underlying storage` for DB
instances, its `automated backups`, `read replicas`, and `snapshots`.  

- For encrypted and unencrypted DB instances, `data in transit between the source
and the read replicas is encrypted,` even when replicating across AWS Regions.

- When you provision a __Multi-AZ DB Instance__, Amazon RDS automatically
creates a primary DB Instance and synchronously replicates the data to a
standby instance (or to a read replica in the case of Amazon Aurora) in a
different AZ. In case of an infrastructure failure, Amazon RDS performs an
`automatic failover to the standby`.

- Multi-AZ replication - `synchronous`; - Read replica - `asynchronous`.

- The type of storage for a read replica is independent of that on the master DB instance.

- You cannot use a standby replica to serve read traffic. Multi-AZ maintains a
standby replica for HA/failover. It is available for use only when RDS promotes
the standby instance as the primary. 

- __Allocate enough RAM__ - To optimize performance, allocate enough RAM so that your working set resides almost completely in memory.

- __Set TTL value of less than 30 seconds__ - If your client application is caching the Domain Name Service (DNS) data of your DB instances, set a time-to-live (TTL) value of less than 30 seconds.

- Ways to improve performance of RDS:

  * Increase RDS DB `instance size`
  * Storage upgrade to `SSD/IOPs` (not Aurora)
  * `Read Replicas`
  * `ElastiCache`

- If a DB instance is in a VPC, the option group associated with the instance is linked to that VPC. This means that you can't use the option group assigned to a DB instance if you try to restore the instance to a different VPC or a different platform.

- If you stop your RDS instance, RDS automatically starts your instance after seven days so that it doesn't
fall behind any required maintenance updates.

- You can't stop a DB instance that has a read replica, or that is a read replica.

- Metrics and events associated with the name of a DB instance are maintained if you `reuse` a DB instance name.

- `Tags are not copied by default`.

- You can restore a DB instance and use a different storage type than the source DB snapshot.

- When you restore a DB instance:

  * Parameter group - you can specify. (It is recommended to retain the source parameter group)
  * Option group - Same as from the source instance.
  * Security group - The default is applied.

- Option groups are linked to VPC or EC2-Classic (non-VPC). This means that you can't use the option group assigned to a DB instance if you attempt to restore the instance into a different VPC or onto a different platform.

- You can copy a snapshot within the same AWS Region, you can copy a snapshot across AWS Regions, and you can copy shared snapshots.

- The copy of an encrypted snapshot must also be encrypted.

- You can't restore a DB instance from a DB snapshot that is both shared and encrypted. Instead, you can make a copy of the DB snapshot and restore the DB instance from the copy.

- You can't share encrypted snapshots as public.

- You can't share a snapshot that has been encrypted using the default AWS KMS encryption key of the AWS account that shared the snapshot.

- Amazon RDS doesn't guarantee the order of events sent in an event stream. The event order is subject to change.

- `24 hours` - The AWS __Management Console__, shows events from the past 24 hours.

- `14 days` - The __AWS CLI__ or the __RDS API__ can retrieve events for up to the past 14 days.

- You can only enable encryption for an Amazon RDS DB instance when you create it, not after the DB instance is created.

- DB instances that are encrypted can't be modified to disable encryption.

- Use `customer-managed key`, if you want full control over a key.

- __Aurora Serverless__ allows you create a database endpoint without specifying the
DB instance class size. You set the minimum and maximum capacity. Aurora
Serverless auto scales.

- Storage and processing are scaled separately for Aurora Serverless.  

- You can choose to pause your Aurora Serverless DB cluster after a given
amount of time with no activity. `5 minutes` is the default.

- Cool down period for scaling down Aurora Serverless:

  * `15 minutes` - after scaling up.

  * `5 minutes` - after scaling down. (310 seconds)

- No cool down period for scaling up Aurora Serverless.  

- When a Aurora Serverless capacity change times out, you can specify one of the following:

  * Force the capacity change – Set the capacity to the specified value as soon as possible.

  * Roll back the capacity change – Cancel the capacity change.

- Maintenance windows don't apply to Aurora Serverless .

- Cluster volume for an Aurora Serverless cluster is always encrypted. You can
choose the encryption key.

- To copy or share a snapshot of an Aurora Serverless cluster,
you encrypt the snapshot using your own KMS key.

- If Aurora Serverless DB cluster becomes unavailable or the AZ it is in fails,
Aurora recreates the DB instance in a different AZ. Amazon refers to this
as `Automatic multi-AZ failover`. _It takes longer than provisioned cluster_

__DataSync__

- __AWS DataSync__ - move large amounts of data online between on-premises
storage and `S3`, `EFS`, or `FSx for Windows`.

- `DataSync does not currently support FSx for Lustre`

- `Task Scheduling` – Schedule data transfer tasks with hourly, daily, and weekly options.
- `EFS-to-EFS Transfer` – Transfer between a pair of Amazon EFS file systems.
- `Filtering for Data Transfers` – Use file path and object key filters to control which data.
- `SMB File Share Support` – Transfer between a pair of SMB file shares.
- `S3 Storage Class Support` – Choose the S3 Storage Class when transferring data to an S3 bucket.

- You need not create IAM roles when transferring to S3 or ENI when transferring
to EFS as data sync manages these for you.

- Configuration options:

  * Enabling verification (for incremental transfer initially disable this,
  then re-enable during the final cut-over, this is not necessary for one-time
  transfer where data is unchanging)
  * Copying different types of metadata
  * Handling files that were deleted at the source
  * Setting a bandwidth limit
  * Configuring Amazon CloudWatch logging

__AWS Organizations__

- __Consolidated Billing__ combines usage of all Accounts within an organization
& shares Reserved Instances (RIs) between multiple accounts. This discount is valid:

  * The account which purchased the RIs is not using all the RIs.
  * Other accounts have launched instances in same AZ.
  * Note that RI scope is either `regional` or `zonal`

- Move member account to another AWS Organization:

  * Remove the member account from the old organization.
  * Send an invite from the new organization.
  * Accept the invite to the new organization from the member account.

- Move master account to another AWS Organization:

  * Remove the member accounts from the organization using the preceding process.
  * Delete the old organization.
  * Repeat the preceding process to invite the old master account to the new organization as a member account.

- The `master account` cannot be `removed` from an AWS Organization.

- __Moving accounts between AWS Organizations__ Make sure you have:

  __Considerations:__

  * The permissions you need to move both the master and member accounts in the organization.
  You require root or IAM access to both the member and master accounts.
  * Backed up any reports or billing history that you need to keep.
  * A plan to update the tax information for any accounts that are changing organizations.
  * By default, organizations support consolidated billing features. To access
  additional features such as service control policies (SCPs), enable all features.
  * When a member account leaves an organization, all charges incurred by the
  account are charged directly to the standalone account.
  * You may need to update payment method and/contact information per member account.

  __Steps to move member accounts to another AWS Organization:__

  * Remove from old organization -&gt; delete old organization -&gt; accept invite into new organization.

  __Steps to move master accounts to another AWS Organization:__

  * Remove all member accounts, -&gt; delete old organization -&gt; accept invite into new organization.

- [AWS Organizations - Move accounts](https://aws.amazon.com/premiumsupport/knowledge-center/organizations-move-accounts/)

__Infrastructure as Code__

To increase reliability, consistency and predictability, an immutable environment
(where servers are not modified once deployed) can be achieved by creating the
infrastructure using AWS CloudFormation or AWS Cloud Development Kit (CDK).

__Cloud Formation__

Drift Detection can be used to detect changes made to AWS resources outside
CloudFormation templates. Drift detection `cannot determine drift for properties
having default values` for resource properties. In this case you have to
explicitly set property values, which could also be the same as default value.

__Redshift__

- When Enhanced VPC Routing is enabled, Redshift forces all COPY and UNLOAD
traffic between your cluster and your data repositories (e.g S3 bucket)
to be restricted to your VPC. However you have to properly configure your VPC,
for example you can configure the following pathways:

  * VPC endpoints - S3 bucket in same region.
  * NAT gateway.
    - S3 bucket in another region.
    - Another service in AWS network
    - Host outside AWS network
  * Internet gateway (attach to your subnet) - AWS services outside VPC

- `Spot instance` not an option for Redshift.
- Automated snapshots - `1 - 35 days` retention period.   
- Manual snapshots - `365 days` default retention period.

__Elastic Container Service (ECS)__

- __ECS Auto Scaling__ Amazon ECS can be configured to use Service Auto Scaling
to adjust it desired count up or down in response to CloudWatch alarms. Service
Auto Scaling leverages the Application Auto Scaling service to provide this functionality.

- Amazon ECS publishes CloudWatch metrics with your service's average CPU and
memory usage. Use these service utilization metrics to scale your service.

- __IAM Roles for ECS tasks__ functions similar to how EC2 instance profiles
provide credentials for EC2 instances.

- Docker containers are particularly suited for batch job workloads. Batch
jobs are often short-lived and parallel. Package batch processing application
into a Docker image and deploy it in an ECS task.

__Elastic Block Store (EBS)__

Property                      | IOPs   | General | Throughput | Cold
------------------------------|--------|---------|------------|---------
Volume Size  (TB)             | 4 - 16 | 1 - 16  | 0.5 - 16   | 0.5 - 16
Max IOPS/Volume               | 64,000 | 16,000  | 500        |	250
Max Throughput/Volume (MB/s)  | 1,000  | 250     | 500        | 250

- __Provisioned IOPs__ for more than `16,000 IOPs` or `250 MiB/s`

- S3 objects have eventual consistency while Elastic Block Store (EBS) objects are consistent.

- EBS volumes are automatically replicated within an Availability Zone

- To mitigate the possibility of a failure:

  * __Create snapshots__ (i.e backups) daily or more frequently.
  * Set a retention period for snapshots.
  * Create a recovery plan.

- __EBS snapshots__ are stored in S3 by AWS. You cannot view the snapshots in S3.
  Snapshots are incremental backups. What does this mean?
  * Only changes after your most recent snapshot are saved.
  * This minimizes time required to create the snapshot
  * This saves on storage costs by not duplicating data.
  * When you delete a snapshot, only data unique to that snapshot is removed.
  * Each snapshot contains all the info needed to restore your data (from the
  moment when the snapshot was taken) to a new EBS volume.

__Simple Queue Service (SQS)__

- `30 seconds` - Default visibility time out for a message. A period of time during which Amazon SQS prevents other consumers from receiving and processing the message.

- Messages sent to a queue are retained for up to `14 days`.

- __Visibility timeout__ for a SQS should be set to the max time it takes to
process and delete the message from the queue. If set below this time, the
message will be again visible to other consumers while the original consumer
is already working on it, leading to duplicates.

- `Prevent duplicates` - set visibility timeout to max time it takes to process messages.
- `Ensure exactly-once delivery of messages` - Use FIFO Queue.
- `Reduce number of empty responses` - Long polling.
- `Isolate message failures` - Configure dead-letter queue.
- `Avoid large backlog of messages with the same message group ID ` - Configure dead-letter queue.
- `Reduce cost` - Send messages in batches, long polling.

__NAT Gateway/instances__

- To create a __NAT Gateway__ you must specify the `public subnet`, an
`elastic IP address` to associate with the gateway.
- For high availability you should launch NAT instances in multiple AZs and
make them part of an Auto Scaling Group.

__Dynamo DB__

- Single-digit millisecond performance at any scale.

- Point-in-time recovery (PITR)

- Dynamo DB is the most efficient storage mechanism for metadata.

- You can configure a global table to DynamoDB as a multi-region, multi-master database.

- No read replica (no need)

- A __DynamoDB Stream__ - is an ordered flow of info about changes to items in
an Amzaon DynamoDB table. You can associate the stream ARN with a `Lambda function`
This way, AWS Lambda polls the stream and invokes your Lambda function
synchronously when it detects that new stream records.

- __DynamoDB auto scaling__ leverages Application Auto Scaling service to `dynamically
adjust provisioned throughput capacity` on your behalf.

  * Handle sudden increase in traffic without throttling.
  * Even if DynamoDB auto scaling is managing our table's throughput, you still
  must provide initial settings for read and write capacity.
  * You may need to manually adjust throughput capacity to bulk-load data.

- __Strategy for high read and write__: Use partition keys with a
large number of distinct values for the underlying DynamoDB table.

__Auto Scaling Group__

- Change launch configuration of auto scaling group - you can't modify after
creating. Rather use existing as basis for new launch configuration then update
the ASG to use the new launch configuration.

- __Scheduled scaling__ works better when you can predict the load changes and
also know how long you need to run.

- Use an ASG per AZ for more precise control of the distribution of EC2
capacity deployments. An example is an application with two instances:
production and fail-over, that needs to be deployed in separate AZ.

- Adding __lifecycle hooks__ to ASGs puts the instance into wait state before
termination. During the wait state, you can perform custom activities e.g
retrieve data from a stateful instance. Default wait period is 1 hour.

__Elastic Load Balancing (ELB)__

- ELB can only balance traffic within a region.

- To route domain traffic to an ELB, use Amazon Route 53 to create an alias record
that points to your load balancer.

- Monitoring both Application & Network Load Balancers:
Cloudwatch metrics, Access logs, CloudTrail logs

- `Request Tracing` can only be use for monitoring Application Load Balancer -

- `VPC flow logs` can only be used for monitoring Network Load Balancers:

Property                  | Network                | Application
--------------------------|------------------------|------------              
Layer of OSI model        | 4                      | 7
IP                        | Static                 | Flexible
Supported protocols       | TCP, TLS, UDP, TCP_UDP | HTTP, HTTPS
Support for lamda targets | No                     | Yes
SSL server certificate    | Exactly One            | At least one
Web access via            | fixed IP               | DNS (URL)

__Elasticbeanstalk__

- ElasticBeanstalk is an orchestration service. It orchestrates various AWS
services like EC2, S3, SNS, CloudWatch, AutoScaling and ELB.

- Elasticbeanstalk not suitable for single long running process.

__Simple Storage Service (S3)__

- You no longer have to randomize prefix naming for performance, as previously
recommended, and can use sequential date-based naming for your prefixes.

- Cross region replication requires versioning to be enabled on both source
and destination buckets.

- When you delete an object in a versioning-enabled bucket, all the versions
remain in the bucket and Amazon S3 creates a delete marker for the object.

  * To delete the object - specify the `versionId` in the `DELETE Object` api call.
  * To undelete the object - delete the delete marker.

- A __presigned URL__ gives you access to the object identified in the URL,
provided that the creator of the presigned URL has permissions to perform the
operation that the URL is based upon. (REST API, CLI, SDK)

  * Enabled users upload a specific object to your bucket without having AWS
  credentials or permissions.
  * Time based access (e.g 1 week etc)

- You can use __S3 lifecycle rule__ to abort all multipart uploads which are
failing to complete in a specific time period. Multipart upload can be used
for files from 5MB to 5GB.

- __S3 Encryption__

  * SSE - S3  - Amazon S3 manages data and master encryption keys.
  * SSE - C   - Customer manages encryption key.
  * SSE - KMS - AWS manages data key but customer manages the master key in AWS KMS.

SSE-KMS - similar to SSE-S3 with additional benefits (additional charges too)
SSE-KMS Integration with CloudWatch -> audit trail

- __S3 select__ can be used to query subset of data in S3 using simple SQL.
Objects need to be stored in CSV,JSON or Apache Parquet format. GZIP and
BZIP2 compression supported with CSV/JSON.

- __S3 Glacier Select__ can be used to query specific data in glacier directly
from glacier and restoration of the data is not required before querying.

- __Transfer Acceleration__ over long distances between your client and an S3
bucket. Takes advantage of Amazon CloudFront's globally distributed edge locations.

  * Upload from all over the world.
  * Upload gigabytes to terabytes of data on a regular basis across continents.
  * You `are unable to utilize all of your available bandwidth` over the Internet
  when uploading to Amazon S3

- __S3 Events__ - notifications designed to be delivered at least once.

  * `To ensure write event is NOT missed, enable versioning.` If two writes are
  made to a single non-versioned object at the same time, it is possible that
  only a single event notification will be sent.

  * `Possible destinations for notifications are`:

    - SNS topic
    - SQS Standard Queue - `FIFO queue not supported`
    - Lamda Function

If your notification ends up writing to the bucket that triggers the notification,
this could cause an execution loop. To prevent this, use 2 different buckets.

```
Write Event 1 -> Notification to Lambda 1 -> Write Event 2 -> Notification 2 ...
```

__Amazon Glacier__

- Bulk retrievals is the cheapest option but has 5 - 12 hours retrieval time.

- Expedited retrievals allow you to access data in 1 - 5 minutes at a flat rate of
USD 0.03/GB retrieved.

- You can't move data directly from Snowball into Glacier, you need to go through
S3 first, and use a lifecycle policy.

- __Glacier Vault Lock__ allows you to easily deploy and enforce compliance
controls for individual S3 Glacier vaults with a __vault lock policy__. You can
specify controls such as “write once read many” (WORM) in a vault lock policy
and lock the policy from future edits. `Once locked, the policy can no longer be changed`.

- __Vault lock vs Vault access policy__ Both policies govern access controls.

  * __Vault lock policy__ - `can be locked to prevent future changes`, providing
  strong enforcement for your compliance controls. You can use the vault lock
  policy to deploy regulatory and compliance controls, which typically require
  tight controls on data access.
  * __Vault access policy__ used to implement access controls that are not
  compliance related, temporary, and subject to frequent modification.
  * Both policy types can be used together. For example, `vault lock policy`
  (deny deletes), and `vault access policy` (grant read access) to designated
  third parties or your business partners (allow reads).

__Route 53__

- __Routing Policy__ - Used to decide how to route traffic to:

  * `Simple` - Single resource that performs given function for your domain, e.g
  a web server that serves content for the example.com website.
  * `Failover` routing policy – Use when you want to configure active-passive failover.
  * `Geolocation` routing policy – Use when you want to route traffic based on the location of your users.
  * `Geoproximity` routing policy – Use when you want to route traffic based on
  the location of your resources and, optionally, shift traffic from resources
  in one location to resources in another.  
  * `Latency` - Resources in multiple locations and you want to route to resource
  that provides best latency.
  * `Weighted` - Multiple resources in proportions you specify.
  * `Multivalue answer` - When you want Route53 to respond to DNS queries with up
  to 8 healthy records selected at random.

DNS Based Routing (Route 53)        | Elastic Load Balancer (ELB)
------------------------------------|-----------------------------
Balances load "Across" regions      | Balances load "in one" region
Changes resolving address           | Reroutes actual traffic
No Auto-Scaling                     | Auto-Scaling available
Unhealthy targets are cached in DNS | Immediate rerouting to healthy targets

- `Active-active` failover configuration (`any routing policy other than failover`) -
When you want all of your resources to be available the majority of the time.

- `Active-passive` failover configuration (`failover routing policy`) - When you
want primary resource(s) to be available the majority of the time and secondary
resource(s) to be on standby in case all the primary resources become unavailable.

- __Alias Record__ - Route53 specific extension to DNS functionality. Instead
of IP address or domain name, alias record contains a pointer to: `CloudFront`,
`ElasticBeanstalk`, `load balancer`, `S3 configured for static website` or
`another Route53 record in same hosted zone`.
You can create alias record for both root domain and subdomain unlike CNAME
record which can only be created for subdomain.
[Read this](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-choosing-alias-non-alias.html)

When you use an alias record to route traffic to an AWS resource, Route 53 automatically recognizes changes in the resource. For example, suppose an alias record for example.com points to an ELB load balancer at lb1-1234.us-east-2.elb.amazonaws.com. If the IP address of the load balancer changes, Route 53 automatically starts to respond to DNS queries using the new IP address.

- An alias record can only redirect queries to:

  * Amazon S3 buckets
  * CloudFront distributions
  * Another record in the same Route 53 hosted zone

- A CNAME record can redirect DNS queries to any DNS record even records of
other DNS service.

- Route 53 doesn't charge for alias queries to AWS resources.

- Route 53 charges for CNAME queries.  

- Route traffic to S3 configured for static website hosting, to be served
through custom domain name: `A record - IPv4 address with alias`

- Route traffic to ELB: `A record - IPv4 address with alias`

- Configure route 53 so you can use your domain name to open connection to an
RDS instance: `CNAME record - without alias`

- Types of Route 53 health checks:

  * `monitor an endpoint`
  * `monitor other health checks (calculated health checks)`
  * `monitor cloudwatch alarms`

__Storage Gateway__

- __Cached volumes__ - Data stored in S3 and retain frequently accessed data
subsets locally. `low latency to frequently accessed data`

- __Stored volumes__ - All data stored locally and asynchronously back up
point-in-time snapshots to S3. `low latency access to entire data set`    

__AWS DataSync__

- While transferring a constantly changing database from on-premises to EFS
using AWS DataSync, data verification can be disabled during data transfer
and can be enabled post data transfer for data integrity checks and ensure
that all data is properly copied between on-premises and EFS.

### Elastic Cloud Compute (EC2) ###

- To move EC2 instance to a new region:
  * Copy AMI of EC2 and specify a different region as destination.
  * Copy EBS volume from S3 and launch EC2 instance in destination region using that EBS volume.

- If you are using an Amazon EBS volume as a root partition, you will need to
set the Delete On Terminate flag to "N" if you want your Amazon EBS volume to
persist outside the life of the instance.

- A recovered instance is identical to the original instance, including the
instance ID, private IP addresses, Elastic IP addresses, and all instance
metadata. If the impaired instance is in a placement group, the recovered
instance runs in the placement group.

- T2 instance credit balance does not persist after stop.

- __Hibernate__ vs __Stop__

  * `Hibernate` - RAM data gets persisted. `Stop` - RAM is cleared.
  * In both Hibernate and Stop:
    - Data from your EBS root volume and any attached EBS data volumes is persisted.
    - Private IP address remains the same
    - Elastic IP address (if applicable) remains the same.
    - Public IP address does NOT remain the same.

- Multi-region EC2 Fleets are not supported.

- One Availability Zone name (for example, us-east-1a) in two AWS customer
accounts may relate to different physical Availability Zones.

- Regional Data Transfer rates apply if at least one of the following is true,
but is only charged once for a given instance even if both are true:

  * The other instance is in a different Availability Zone, regardless of which
  type of address is used.
  * Public or Elastic IP addresses are used, regardless of which Availability
  Zone the other instance is in.

- __Placement Group placement strategies__ Placement strategy spreads instances:

  * __Cluster__ – Within an AZ for low-latency. Within a partition (share hardware).
  Hardware failure -> entire cluster may fail. Use for `HPC`.
  * __Partition__ - Across logical partitions. (partitions do not share hardware)     
  Hardware failure -> only one partition may fail.
    - `large distributed workloads e.g Hadoop, Cassandra, Kafka`
  * __Spread__ – Across distinct underlying hardware. Each partition has one instance.
  Hardware failure -> Only one instance may be affected. `HA and mission critical` applications.

- __EFA__

  * For HPC, machine learning applications
  * Windows instance not supported. EFA functions as ENA without added capabilities.

- __EFA vs ENA__

  * ENA - Traditional networking capabilities
  * EFA - ENA + OS-bypass for lower latency and reliable transport

- __Scheduled Instance Limits__

  * `C3`, `C4`, `M4`, and `R3` - supported instance types.
  * `365 days (one year)` - required term.
  * `1200 hours per year` - the minimum required utilization.
  * You can purchase a Scheduled Instance up to three months in advance.
  * US East (N. Virginia), US West (Oregon), and Europe (Ireland) regions only.

### Security ###

An option in the answers could suggest using WAF against DDoS, or AWS Shield
mitigate SQL injection attacks - Wrong and wrong again.

- AWS Shield - Provides protection against DDoS. Standard version of Shield implemented automatically on all AWS accounts.

- Web Application Firewall - Sits in front of your website to provide additional protection against common attacks such as SQL injection and XSS.

- KMS master keys are region-specific

__Symmetric vs asymmetric encryption__

- `Symmetric encryption`, the message to be protected can be encrypted and
decrypted using the same key.

- `Asymmetric encryption`, requires the use of two separate keys: a public key
and private key. Data is encoded using the public key, and decoded using the private key.

- `Server Name Indication (SNI)` allows the server to safely host multiple TLS
Certificates for multiple sites, all under a single IP address. It adds the
hostname of the server (website) in the TLS handshake as an extension in the
CLIENT HELLO message. This way the server knows which website to present when
using shared IPs.

### Network ###

- __Internet gateway__

  * One per VPC

- __NAT Gateway__

  * Security groups cannot be associated with NAT Gateways.
  * One per AZ.

A placement group is within a __single Availability Zone__, enables applications
participate in low-latency 20 GBps network and has benefit of lowering jitter
in network communications. This is enabled by __Elastic Network Adapter (ENA)__

__Amazon VPC endpoints__ provide reliable connectivity to AWS services
(for example,  Amazon S3) without requiring an internet gateway or a Network
Address Translation (NAT) instance. __Data remains within the AWS network___

- Two types of VPC endpoints: `interface` and `gateway` endpoints.

- `Amazon S3`, `DynamoDB` - Only these two services use a VPC `gateway` endpoint.

__VPN connection__ can be used to establish communications across environments
(e.g between on-premises and AWS cloud) over the internet.  

__Virtual private gateway__ is the Amazon VPC side of A VPN connection.

### Virtual Private Cloud (VPC) ###

- __Difference between Security Groups and NACLs__

__TL;DR__: _Security group is the firewall of EC2 Instances whereas Network ACL is the firewall of the Subnet._

What  | Security Group | NACL
------|----------------|-----------------     
Scope | `EC2 instance`(s) or group of | `subnet`      
State | Stateful - state of incoming rule applied to outgoing | Stateless - must explicitly specify both in and out going
Rules | Deny by default. `You can only allow` |
Order | All rules processed | Rules applied in number order (all may not be processed)

- Each NACL has default deny rule one for inbound and one for outbound which
can't be removed. This rule ensures that if a packet doesn't match any of the
other numbered rules, it's denied.

- The default NACL has an allow all inbound and also allow all outbound rule.

- Traffic between two EC2 instances in:

  * The same AWS Region stays within the AWS network, even when it goes over
  public IP addresses.
  * Different AWS Regions stays within the AWS network, if there is an
  Inter-Region VPC Peering connection between the VPCs where the two instances reside.

- Amazon VPCs do not support EIPs for IPv6 at this time.

- For IP addresses you assign to a subnet, amazon reserves the first four (4) IP
addresses and the last one (1) IP address of every subnet for IP networking purposes.

- A subnet must reside within a `single Availability Zone`.

- In a VPC, you can only use AMIs registered within the same region as the VPC.

- In a VPC, you can only use EBS snapshots located in the same region as the VPC.

- An instance launched in a VPC using an Amazon EBS-backed AMI maintains the
same IP address when stopped and restarted. This is in contrast to similar
instances launched outside a VPC, which get a new IP address. The IP addresses
for any stopped instances in a subnet are considered unavailable.

- You can't specify the default VPC or subnet. However you can delete both the
default VPC and subnet.

- You can’t detach the primary (eth0) network interface, but you can attach
and detach secondary interfaces.

- Network interfaces can only be attached to instances residing in the same
VPC and Availability Zone as the interface.

- You can't create a peering connection between two VPCs with matching IP
address ranges?

- You cannot use AWS Direct Connect or hardware VPN connections to access VPCs
you are peered with. “Edge to Edge routing” isn’t supported in Amazon VPC.
Refer to the VPC Peering Guide for additional information.

- You can privately access services powered by AWS PrivateLink over AWS Direct
Connect. The application in your on-premises can connect to the service endpoints
in Amazon VPC over AWS Direct Connect. The service endpoints will automatically
direct the traffic to AWS services powered by AWS PrivateLink.

- For __Direct Connect__ to achieve high bandwidth link, `higher throughput`
for faster, secure data transfer:  `Enable LAG in active mode`

- Within a region, traffic within a VPC as well as between VPCs are private and
isolated but not encrypted.

- Between 2 regions, Traffic is encrypted using modern AEAD (Authenticated
Encryption with Associated Data) algorithms. Key agreement and key management
is handled by AWS.

- VPC peering is not transitive.

- Traffic from an EC2-Classic instance can only be routed to private IP addresses
within the VPC. They will not be routed to any destinations outside the VPC,
including Internet gateway, virtual private gateway, or peered VPC destinations.

- CloudWatch metrics are not currently available for the interface-based VPC endpoint.

- VPC Flow log data can be published to Amazon CloudWatch Logs or Amazon S3

- Using another VPC's NAT Gateway is not supported.

- NAT Gateway cannot be created without an Elastic IP

- Endpoint connections cannot be used/extended outside a VPC. For example, if
you have a VPN connection from on-premises network to a VPC with an endpoint
service to an S3 bucket, you cannot use the endpoint service via the VPN connection.

- To connect to S3 via connections external to VPC, setup an S3 proxy server on
an EC2 instance. Connections external to VPC include: VPN connections, VPC
peering connection, AWS Direct Connect connection and ClassicLink connection.

- Custom VPCs do not have DNS hostnames enabled by default.

- You can change the main route table of your VPC to another.

- You can peer a VPC with a specific subnet of another VPC instead of peering
with the entire VPC.

- VPC flog logs captures IP traffic to and from `network interfaces` in your VPC.

- You can create a flow log for a `VPC`, `subnet` or `network interface`

- Remember -> For IPv6 use egress - only internet gateway not NAT gateway/instance.

- To ensure EC2 instance has fixed MAC address, use a VPC with an elastic network
interface that has a fixed MAC address.

### CloudFront ###

- Amazon CloudFront works with non-AWS origin servers

- `Geo Restriction` feature lets you specify a whitelist or blacklist of
countries for accessing your content via CloudFront.

- To remove an item from CloudFront edge locations, simply delete the file from
your origin and as content in the edge locations reaches the expiration period
defined in each object’s HTTP header, it will be removed. In the event that
content needs to be removed before the specified expiration time, you can use
the `Invalidation API`.

- Amazon CloudFront is compliant with:

  * Payment Card Industry Data Security Standard (PCI DSS) Merchant Level 1
  * HIPAA
  * System & Organization Control (SOC) measures

- If you run `PCI or HIPAA compliant workloads`, you should log your CloudFront
usage data for the last 365 days for future auditing purposes.   

- Amazon CloudFront currently supports GET, HEAD, POST, PUT, PATCH, DELETE and
OPTIONS requests.

- Amazon CloudFront does not cache the responses to POST, PUT, DELETE, and PATCH
requests

- CloudFront supports HTTP/2 only over an encrypted connection.

- Amazon CloudFront has an optional private content feature. When this option
is enabled, Amazon CloudFront will only deliver files when you say it is okay
to do so by securely signing your requests.

- With CloudFront caching, you can:

  * Modify, add request headers forwarded to origin server

  * Specify whether you want Amazon CloudFront to forward some or all of your
  cookies to your custom origin server.

  * Specify which query parameters are used in the cache key

  * You can configure Amazon CloudFront to whitelist up to 10 query parameters.

  * Amazon CloudFront support video-on-demand (VOD) streaming protocols

- The maximum size of a single file that can be delivered through Amazon
CloudFront is __20 GB__.

- [Lambda@Edge](https://aws.amazon.com/lambda/edge/) allows you to run code at
global AWS edge locations without provisioning or managing servers, responding
to end users at the lowest network latency.

- Four (4) events can be triggered with Amazon CloudFront: Viewer request,
Viewer response, Origin request, Origin response.

  View   `- viewer request ->`   CloudFront   `- origin request ->`   Origin Server

  View   `<- viewer response -`   CloudFront   `<- origin response -`   Origin Server

- `Price Classes` enable you reduce your delivery prices by excluding Amazon CloudFront’s more expensive edge locations from your Amazon CloudFront distribution.

- __Restrict access to content served from S3 buckets__ so that users can only
access your files through CloudFront, not directly from the S3 bucket.

  * Using either __signed URLs__ or __signed cookies__.

     - Only `RSA-SHA1` supported for signing URLs or cookies.

  * Using __origin access identity__

    - Create a special CloudFront user called an origin access identity (OAI)
    and associate it with your distribution.
    - Configure your S3 bucket permissions so that CloudFront can use the OAI
    to access the files in your bucket and serve them to our users.
    - `Not applicable` to Amazon S3 bucket configured as a website endpoint

__CloudFront vs GlobalAccelerator__

TDLR CloudFront is caching based while GlobalAccelerator is routing based

What                  |    CloudFront           | Global Accelerator
----------------------|-------------------------|-------------------------------
Caching               | Yes                     | No
Lambda@Edge           | Yes                     | No
Configuration updates | 10s of minute           | Immediately
DNS                   | Requires using Route53 to use Alias record for domain | Does not require the use of Route53
Origin                | AWS and Non-AWS |

[Soruce](https://mxx.news/aws-global-accelerator-compared-to-cloudfront-and-route53/)

### Elastic File System (EFS) vs FSx ###

NFS - Network File System
SMB - Server Message Block - a protocol
NTFS - New Technology File System

Property   |      EFS           | FSx
-----------|--------------------|------------------------------------
File Sys   | NFSv4              | SMB server with NTFS based storage
Latency    | Low latency        | Sub-millisecond latencies
Throughput | 10 GB/sec          | Up to hundreds GB/sec
IOPs       | greater than 500k  | Millions

__Elastic File System (EFS)__

- You can mount EFS on instances in only one VPC at a time.
- Both the file system and the VPC must be in the same region.
- You can mount EFS over VPC peering connections within a single AWS Region
when using instance types T3, C5, C5d, I3.metal, M5, M5d, R5, R5d and z1d.
- You can access an EFS via a mount target created in another AZ from the EC2
instance. It is recommended not to, but rather `create one mount target per AZ`.
- Encryption at rest can only be set during EFS creation.
- To encrypt existing EFS:
  * Create encrypted EFS
  * Copy data from un encrypted to encrypted EFS
  * Delete un-encrypted EFS
- EFS uses NFS which is not encrypted.
- To encrypt traffic between EC2 and EFS:
  * Unmount unencrypted mount.
  * Remount using mount helper with encryption during transit enabled.  
- __General Purpose Performance Mode__. low latency - web serving, home directories etc
- __Max IO Performance Mode__. higher latency, higher aggregate throughput - big data etc
- __Bursting Throughput Mode__   
- __Provisioned Throughput Mode__

- You incur access charges when files are transitioned to EFS IA storage from EFS
Standard storage. [Click for details](https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html)
- EFS supports only symmetric CMKs.

__FSx__

You can reduce your data storage costs by [turning on data deduplication](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-data-dedup.html) for your file system.

__Visitor Prioritization on Websites__

CloudFront and Lambda@Edge could be used to [set up visitor prioritization for your website](https://aws.amazon.com/blogs/networking-and-content-delivery/visitor-prioritization-on-e-commerce-websites-with-cloudfront-and-lambdaedge/)

__Logs & Monitoring__

- __Amazon VPC flow logs__ - Information captured in flow logs includes
information about `allowed and denied traffic, source and destination IP
addresses, ports, protocol number, packet and byte counts, and an action
(accept or reject)`. Use this to troubleshoot connectivity and security issues.

- __Amazon VPC traffic mirroring__ - Replicate network traffic to and from an
Amazon EC2 instance and forward it to out-of-band security and monitoring
appliances. Use this to analyze `actual traffic content, including payload`.

- __CloudTrail__ - `Who did what?` - Log of all actions that have taken place
inside your AWS environment.

  * Logs stored in S3, encrypted by default using SSE-S3
  * Use SNS for notifications about log file delivery and validation.
  * __Log file integrity__ when enabled ensures all modifications to log files are recorded.

- __CloudWatch__ - `What happened` - Monitor of activity of AWS services and
resources, reporting on their health and performance.

  * Using __CloudWatch alarm actions__, you can create alarms that automatically
  stop, terminate, reboot or recover your EC2 instances.

    - Save money - stop/terminate when you no longer need an instance running
    - If system impairment occurs - reboot, recover

__Bulk Data Transfer__

- Online

  * AWS Direct Connect - Private network connections to AWS
  * Transfer Acceleration - For S3 enabled apps. Use edge locations to achieve high throughput.
  * Kinesis Data Firehose - Load streaming data into S3
  * DataSync - Transfer of actively used data
  * Transfer for SFTP - SFTP transfer into S3

- Offline
  * Snowball - Static data into and out of S3 (good for one-time transfer of large)

- Hybrid

  * Storage Gateway - Access AWS storage from on-premises real-time (complements DataSync)
    - File Gateway - Store and access S3 objects from file-based apps with local caching.
    - Volume Gateway - On-premises block storage backed by cloud storage with local caching. EBS snapshots and clones.
    - Tape Gateway - Drop-in replacement for physical tape infrastructure backed by cloud storage with local caching.
  Form factors -> Existing VMs, EC2 or hardware appliance.

  * Snowball Edge - Storage and compute in disconnected environments

- Snowmobile - exabyte scale storage

What              | AWS-Managed VPN       | AWS Direct Connect
-------------|-----------------------|------------------------------
Performance  | <4 GB per VPC         | <1 GB, 1 GB, or 10 GB ports Up to 40 GB with Link Aggregation Group (LAG)
Connectivity | 1VPN Connection to VPC | 2 port connection to multiple VPCs
Resiliency   | 1 VPN Connection = 2 VPN tunnels | 1 AWS router = redundant connectivity to 1 AWS region
Costs        | $0.05 per VPN Connection Hour $0.09 per GB data transfer out | $0.2 to $0.3 per GB data transfer out Port hour fees(varies based on port speed)

[Source](https://www.coresite.com/blog/vpn-or-direct-connect-aws-compared)

__CloudFront vs S3 Transfer Acceleration__

- __CloudFront__ - `Content delivery`.

  * `Caching` on Edge locations leads to improved speed and less load on origin server.

- __Transfer Acceleration__ - `Transfer acceleration`. You use `<bucket>.s3-accelerate.amazonaws.com`
instead of the default S3 endpoint.
  * Transfers are performed via the same `Edge locations` used by CloudFront
  * `Higher throughput` - Network path is optimized for long-distance large-object uploads.
  * `No caching` on Edge locations.

__Scope of Services__

- Services like IAM (user, role, group, SSL certificate), Route 53, STS are Global and available across regions

- __Region__ - VPC, ASG, ELB, S3, ECS, KMS keys, RDS Option Groups.
  * ELB within a single AZ or multiple AZs.

- __VPC__ - One Internet gateway per VPC

- __AZ__

  * Subnet - Each subnet must reside entirely within one AZ and cannot span zones.
  * NAT gateway
  * EBS volumes are automatically replicated within an Availability Zone

    All other AWS services are limited to Region or within Region and do not exclusively copy data across regions unless configured
    AMI are limited to region and need to be copied over to other region
    EBS volumes are limited to the Availability Zone, and can be migrated by creating snapshots and copying them to another region
    Reserved instances can be migrated to another AZ, can not be migrated to another region
    RDS instances are limited to the region and can be recreated in a different region by either using snapshots or promoting a Read Replica
    Cluster Placement groups are limited to single Availability Zones
    Spread Placement groups can span across multiple Availability Zones
    S3 data is replicated within the region and can be move to another region using cross region replication
    DynamoDB maintains data within the region can be replicated to another region using DynamoDB cross region replication (using DynamoDB streams) or Data Pipeline using EMR (old method)
    Redshift Cluster span within an Availability Zone only, and can be created in other AZ using snapshots
