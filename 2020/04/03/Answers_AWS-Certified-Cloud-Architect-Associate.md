---
path: "./2020/04/03/Answers_AWS-Certified-Cloud-Architect-Associate.md"
date: "2020-04-03T23:39:12"
title: "Questions and Answers - AWS Certified Cloud Architect Associate"
description: "Questions and Answers - AWS Certified Cloud Architect Associate"
tags: ["AWS", "Certification", "Certified Cloud Architect", "Questions", "Answers"]
lang: "en-us"
---

### Questions ###

- [Click here](/2020/04/03/Questions_AWS-Certified-Cloud-Architect-Associate)
for the questions which resulted to these answers.

### Answers ###

1. __What is the maximum number of vaults an AWS account can create in a region?__
`1000`

2. __A solutions arch is designing a highly scalable system to track patient records
Records must remain available for immediate download:__

  - Store files in EBS, create lifecycle policy to move them to Glacier Glacier after 6 months

  - Store files in Glacier, create lifecycle policy to move them to Glacier S3 after 6 months

  - `Store files in S3, create lifecycle policy to move them to Glacier Glacier after 6 months`

  - Store files in EFS, create lifecycle policy to move them to Glacier after 6 months

  __Note__: _Lifecycle policies are for S3_

3. __What is longest duration of an SWF workflow execution?__

  - 12 months
  - `30 days`
  - 364 days
  - 10 days

4. __Which services provide full administrative control of EC2 instances?__

   - `Elastic Beanstalk`
   - RDS
   - `MapReduce`
   - LightSail
   - DynamoDB
   - ElasticCache

5. __Standard retrieval of S3 Glacier data typically completes between.__

   - 1 - 24 hours
   - `3 - 5 hours`
   - 1 - 5 hours
   - 5 - 24 hours              

6. __Which of the following are true?__

   - `Transfer Acceleration is only supported on virtual-hosted style requests.`
   - Transfer Acceleration is only supported on path style requests.
   - Transfer Acceleration is supported for both virtual and path style requests.
   - The name of the bucket used for Transfer Acceleration must be DNS-compliant and must not contain periods (".").

7. __Which of the following 3 API actions in AWS STS return temporary security
credentials with a default expiration time of one hour?__

   - GetFederationToken
   - `AssumeRole`
   - `AssumeRolewithSAML`
   - `AssumeRoleWithWebIdentity`
   - GetSessionToken

8. __Which of the following are true?__

   - S3 One Zone Infrequent Access does not support SSL
   - `S3 Intelligent-Tiering accrues a small monthly monitoring and auto-tiering fee`
   - `S3 Glacier provides three retrieval options that range from a few minutes to hours`
   - `Data stored in S3 One Zone Infrequent Access will be lost in the event of
   Availability Zone destruction`

9. __Database requires occasional internet connection to download system and
database updates___

  - Db in private subnet
  - Db in public subnet
  - `NAT instance in public subnet and route internet bound traffic to NAT from
  private subnet`
  - NAT instance in private subnet and route internet bound traffic to NAT from
  private subnet

10. __Which is true?__

   __S3 supports__

   - Eventual consistency for overwrite PUTS and UPDATES
   - `Eventual consistency for overwrite PUTS and DELETES`
   - `Read after write consistency for PUTS of new objects in all regions`
   - Read after write consistency for PUTS of new objects in US regions

11. __Requirement to host a database on an EC2 instance. The storage option chosen
must support 28,000 IOPs__

 - `EBS Provisioned IOPS SSD`

 - EBS Throughput Optimized HDD

 - EBS General Purpose SSD

 - EBS Max IOPS SSD

12. __An application is being designed for deployment into AWS. The application will
use Amazon S3 buckets for storing as well as reading data. The write traffic
is expected to be 6,500 requests per second and the read traffic will be
around 8,000 requests per second.__

  __What is the best way to architect the solution for maximum Amazon s3
  performance?__

  -  Use as many s3 prefixes as you need in parallel to achieve the required
  throughput.

  - `Prefix each object name with a hex hash key along with the current date.`
  Make the keys distinctive.

  - Enable versioning on the S3 bucket.

  - Setup cross region replication on the bucket and preform reads from the
  secondary bucket.

13. __Which AWS network feature gives low latency and high packet per second network performance?__

  __Choose One__

  - Amazon Hypervisor
  - Security Group
  - Amazon HVM
  - `Placement Group`

14. __A company has an application hosted in AWS. The application is deployed on a
set of Ec2 instances across two AZs for high availability. The infrastructure
is deployed behind a application load balancer.__

  __The following are requirements from and administrative perspective.__

  - Ensure notifications are sent when the read requests exceed 100 per minute.

  - Ensure latency exceeds 15 seconds

  - Any API activity which calls sensitive data must be monitored.

  __Which of the following meets the requirements? Choose 2.__

  a. Use CloudTrail to monitor API activity.

  b. Use CloudWatch to monitor API activity.
  _Not used to monitor API activity._

  c. `Use CloudWatch metrics to create custom metrics and setup an alarm
  to send out notifications when the threshold is reached.`

  d. Use custom log software to monitor latency and read requests to the
  application load balancer.

15. __An EC2 instances hosts a voting application that accesses DynamoDB table.
The instance needs to be able to access the table in the most secure way
possible.__

  __Which of the following is the most secure way for the EC2 instance to
  access the DynamoDB table?__

  - Use KMS keys with permissions to interact with DynamoDb and assign those
  keys to the applications.

  - Use an IAM user account that is designated as a service account to ensure
  minimum required credentials and assing to the instance.

  - `Use an IAM role with permissions to interact with DynamoDB and assign it
  to the EC2 instance.`

  - Configure a VPC gateway endpoint to allow the resources to access
  DynamoDB

  __Note__: _Always choose a role over a user account_.

16. __Where to get info like timestamps, client ip, latencies, request paths from
load balancers.__

  __Choose One:__

  - Metrics from CloudWatch
  - Access Logs from the web servers
  - `Access Logs from the load balancers`
  - Metrics from CloudTrail

17. __A company has a workflow that sends video files from their datacenter into
the cloud for transcoding. They are using EC2 instances to pull transcoding
jobs from SQS.__

  __Why is SQS the best choice for creating a decoupled architecture?__

  - SQS guarantees the order of messages.

  - SQS checks the health of the worker instances.

  - `SQS makes it easier to carry out horizontal scaling of the encoding tasks.`

  - SQS synchronously provides transcoding output.

18. __Connecting to EC2 via putty receives 'Connection timed out' error. What
possible causes?__

  __Choose 3:__

  - Role attached to EC2 instance
  - `Security Group rules`
  - Private/public keys
  - `Route table for the subnet`
  - Username/password
  - `Network access control list`

19. __Which S3 encryption method could be used for data assuming you do not want
to manage the encryption keys yourself?__

  __Choose One__

  - `SSE-S3`
  _Doesn't require keys .. all managed by S3._
  - SSE-C
  - SSE-KMS
  - SSE-KMS with CloudHSM

20. __An RDS MySQL database is getting lots of read and has become the bottleneck
for the application. What action can be peformed to ensure that the
database does not remain a bottleneck.__

  - Setup CloudFront distribution in front of the database.
  CloudFront in front of a database is not a typical architecture.

  - Setup an Elastic Load Balancer in front of the database.
  Load Balancers sit in front of application and web servers not database.

  - `Setup an ElastiCache cluster in front of the database`

  - Setup SNS in front of the database
  _Why send notifications, to what end?_

21. __Default visibility time for a queue in SQS__

  - 12 hours
  - `30 secs`
  - 1 day
  - 1 hour

22. __Custom application with 200GB MySQL database runs on an EC2 instance.
The application is only being used for short periods of time in the morning
and sometimes in the evening.__

  __What is the most cost effectic storage type?__

  - Amazon EBS provisioned IOPS SSD.

  - Amazon EBS Throughput Optimized HDD
  _This won't do, as we are dealing with database (random reads)_

  - `Amazon EBS General Purpose SSD`

  - Amazon EFS

23. __Which of the following are true?__

  __Choose 2__

  - `Default max amount of s3 buckets is 100`

  - `Default max amount of objects in bucket is infinity (theoretically)`

  - AWS Inspector is an automated security assessment tool which needs no agent
  installed on target instances.

  - AWS Systems manager uses an event based architecture

24. __A reporting application runs on EC2 instances behind an application load
balancer. The EC2 instances are part of an auto scaling group with multi
Availability Zone deployment. Due to the complexity, the reports take up to
15 minutes. A solutions architect is concerned users will receive 500 errors
if a report is requested during scale-in.__

  __What is the best measure to mitigate this?__

  - Use sticky sessions

  - Use connection draining. [24a](#elb-connection-draining)

  - Increase the cool down period for the auto scaling group to greater than
  1500 seconds.

  - `Increase the de-registration delay timeout for the target group to greater
  than 1500 seconds`. [24b](#target-group-deregistration-delay)
  >If a deregistering target terminates the connection before the deregistration delay elapses, the client receives a 500-level error response. [24b](#target-group-deregistration-delay)

25. __A consultant designs large scale architectures using several AWS services
that include IAM, EC2, RDS, Dynamo DB and VPC. The consultant would like
to take his designs and make them easier to deploy to AWS, that is, in a more
automated manner.__

  __Which service would best meet the requirement?__

  - Elastic Beanstalk.

  - CodeDeploy

  - `CloudFormation`

  - OpsWorks

26. __An enterprise application has a queue from which tasks are received and
processed. However some tasks are processed more than once. How would a
solutions architect ensure tasks are only processed only once?__

   __A solutions architect would ensure tasks are processed only once by using:__

   - Kinesis Data Streams

   - Kinesis Data Firehose

   - SNS
   >Although most of the time each message will be delivered to your application exactly once, the distributed nature of Amazon SNS and transient network conditions could result in occasional, duplicate messages at the subscriber end. Developers should design their applications such that processing a message more than once does not create any errors or inconsistencies. [26a](#sns-not-exacly-once)

   - `FIFO SQS`
   >FIFO queues provide exactly-once processing, which means that each message is delivered once and remains available until a consumer processes it and deletes it. Duplicates are not introduced into the queue. [26b](#sqs-fifo-exactly-once)

27. __How do new instances of an Auto Scaling Group identify their public and
private IP addresses?__

   - Ipconfig for windows Ifconfig for linux
   - CloudTrail
   - `Using a Curl or Get command to get the latest meta-data from http://169.254.169.253/latest/meta-data/`
   - Using a Curl or Get command to get the latest user-data from http://169.254.169.253/latest/user-data/

28. __A database application running on an EC2 instance needs to get updates from
the internet. A solutions architect needs to design a solution to get the
updates without exposing the instance to the internet.__

  __Which solution best meets these requirements?__

  - Attach a VPC endpoint and add routes for 0.0.0.0./0

  - `Launch a NAT gateway and add routes for 0.0.0.0./0`
  _Best answer over NAT instance below because NAT gateway is a managed service._

  - Deploy a NAT instance in a public subnet and add routes for 0.0.0.0./0

  - Attach an internet Gateway and add routes for 0.0.0.0./0

29.  __Logs for an application, comprising multiple EC2 instances, are stored
in an S3 buckets with event setup to trigger a Lambda function. The Lambda
function submits a new AWS Batch job to Job queue. After a while you notice
that your job is stuck in runnable state.__

  __What would you do to ensure that your job is moved into starting state?__

  - Disable Events on the S3 bucket and re-enable after some time.

  - `Ensure that awslogs log driver is configured on compute resources which will send
  log information to CloudWatch logs.`

  - Disable S3 bucket events.

  - Ensure that awslogs log driver is configured on the Job queue which will send
  log information to CloudWatch logs.

30. __A solutions architect is designing a system which needs a minimum of 8
m5.large instances to serve traffic. The system will be deployed in us-eas-1
and needs to be able to handle the failure of an entire availability zone (AZ).__

  __Assume all instances properly linked and you can use AZs `a` through `f`__

  __How should you distribute the servers to save as much cost as possible
  while maintaining high availability?__

  - `3 servers in each AZ (a - d)`
  - 8 servers in each AZ (a and b)
  - 2 servers in each AZ (a - e)
  - 4 servers in each AZ (a - c)

  _Consider what happens when one AZ is lost. The question requires a minimum
  of 8 left when an AZ is lost._

31. __As the cloud administrator of a company, you notice that one of the EC2
instances is restarting frequently. There is need to trouble shoot and analyze
the system logs.__

  __What can be used in AWS to store and analyze the log files from the EC2 instances?__

  - AWS S3
  - AWS CloudTrail
  - AWS SQS
  - `AWS CloudWatch Logs.`

    * _You can use Amazon CloudWatch Logs to monitor, store, and access your log files
    from Amazon EC2 instances, AWS CloudTrail and other sources_.
    * _CloudTrail would be appropriate if we were auditing or tracking activity by
    monitoring API calls as it prvides info such as who, when, what relating to the
    request that was made._

32. __How would you increase the number of connections to an RDS instance?__

  - `Create a new parameter group, attach it to the DB instance and change the setting.`
  - Login to the RDS instance and modify database config file under /etc/mysql/my.cnf
  - Modify setting in default options group attached to DB instance.
  - Create a new option group, attach it to DB instance and change the setting.

33. __An e-commerce application is hosted in AWS. The last time a new product was
launched, the application experienced a performance issue due to an enormous
spike in traffic. Management decided that capacity must be doubled the week
after the product is launched.__

  __Which is the MOST efficient way for management to ensure that capacity requirements are met?__

  - Add a Step Scaling policy
  - Add a Dynamic Scaling policy
  - `Add a Scheduled Scaling action.`
  - Add Scheduled Reserved Instances.

  Step Scaling - If you know a specific metric value (e.g CPU Utilization) one
  week after launch, then this works. If you set step scaling, say based on
  CPU utilization, one week after launch, how are you able to ensure the CPU
  utilization reaches the threshold to trigger the step scaling action.

  Dynamic Scaling - This may not double the scale, it may triple it or leave it
  at 60%. Dynamic scaling is quite effective, but not specific enough. The _MUST
  be doubled_ ruins it for Dynamic scaling as it may not double if utilization
  does not require it.

  Scheduled Scaling - If you now launch date, then this works.

  Scheduled Reserved Instances - enable you to purchase capacity reservations that
  recur on a daily, weekly, or monthly basis, with a specified start time and
  duration, for a `one-year term`.

34. __A Solutions Architect is designing a solution that includes a managed VPN connection.
To monitor whether the VPN connection is up or down, the Architect should use:__

  - An external service to ping the VPN endpoint from outside the VPC.
  - AWS CloudTrail to monitor the endpoint.
  - `The CloudWatch TunnelState Metric.` [34](#monitoring-vpn-cloudwatch)
  - An AWS Lambda function triggered by CloudTrail activity event.

35. __A company's development team plans to create an Amazon S3 bucket that
contains millions of images. The team wants to maximize the read performance of
Amazon S3.__

    __Which naming scheme should the company use?__

    - Add a hexadecimal hash as the prefix.
    - `Add a date as the prefix.` [35](#s3-optimizing-performance)  
    - Add a sequential id as the suffix.
    - Add a hexadecimal hash as the suffix.

36. __You are launching an AWS ECS instance. You would like to set the ECS
container agent configuration during the ECS instance launch__

  __What should you do?__

  - Set configuration in the ECS metadata parameter during cluster creation.
  - `Set configuration in the user data parameters of ECS instance.` [36](#ecs-bootstrap-container-instance)
  - Define configuration in the task definition.
  - Define configuration in the service definition.

37. __A company has a legacy application using a proprietary file system and
plans to migrate the application to AWS.__

  __Which storage service should the company use?__

  - Amazon DynamoDB
  - Amazon S3
  - `Amazon EBS`
  Amazon EBS allows you to create storage volumes and attach them to Amazon EC2
  instances. Once attached, you can create a file system on top of these volumes,
  run a database, or use them in any other way you would use block storage.[37](#ebs-features)
  - Amazon EFS

### References ###

- <a name="elb-connection-draining">24a</a> - [AWS - ELB connection draining](https://aws.amazon.com/blogs/aws/elb-connection-draining-remove-instances-from-service-with-care/)

- <a name="target-group-deregistration-delay">24b</a> - [AWS - Target Groups - De-registration delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay)

- <a name="sns-not-exacly-once">26a</a> - [AWS FAQs - SNS](https://aws.amazon.com/sns/faqs/)

- <a name="sqs-fifo-exactly-once">26b</a> - [AWS FAQs - SQS](https://aws.amazon.com/sqs/faqs/)

- <a name="monitoring-vpn-cloudwatch">34</a> - [Monitoring VPN - CloudWatch](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/monitoring-cloudwatch-vpn.html)

- <a name="s3-optimizing-performance">35</a> - [S3 - Optimizing Performance](https://docs.aws.amazon.com/AmazonS3/latest/dev/optimizing-performance.html)

- <a name="ecs-bootstrap-container-instance">36</a> - [Amazon ECS - bootstrap container instance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/bootstrap_container_instance.html)

- <a name="ebs-features">37</a> - [Amazon EBS - Features](https://aws.amazon.com/ebs/features/)
