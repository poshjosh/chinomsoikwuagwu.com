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

////////////////////////////////////////////////////////////////////////////////

- __You are deploying a critical monolith application that must be deployed on
a single web server, as it hasn't been created to work in distributed mode. Still,
you want to make sure your setup can automatically recover from the failure of an
AZ. Which of the following solutions is the MOST cost-efficient? (select three)__

  - `Assign an EC2 instance Role to perform the necessary API calls.`
  - Create a Spot Fleet request.
  - Create an Application Load Balancer and a target group with the instance(s)
  of the Auto Scaling Group.
  - `Create an Elastic IP and use the EC2 user-data script to attach it.`
  - Create an Auto Scaling Group that spans across 2 AZ, with minimum, maximum
  and desired of 1, 2 and 2 respectively.
  - `Create an Auto Scaling Group that spans across 2 AZ, with minimum, maximum
  and desired of 1, 1 and 1 respectively.`

  Spot Fleets requests would not fit our purpose as we are looking at a critical application. Spot instances can be terminated.

  An ASG with desired=2 would create two instances, and this won't work for us as our monolith application is not made to work with two instances as per the questions.

  So we have an ASG with desired=1, across two AZ, so that if an instance goes down, it is automatically recreated in another AZ.

  Now, between the ALB and the Elastic IP. If we use an ALB, things will still work, but we will have to pay for the provisioned ALB which sends traffic to only one EC2 instance. Instead, to minimize costs, we must use an Elastic IP.

  For that Elastic IP to be attached to our EC2 instance, we must use an EC2 user data script, and our EC2 instance must have the correct IAM permissions to perform the API call, so we need an EC2 instance role.

  References: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html

- __You have a team of developers in your company, and you would like to ensure they can quickly experiment with AWS Managed Policies by attaching them to their accounts, but you would like to prevent them from doing an escalation of privileges, by granting themselves the AdministratorAccess managed policy. How should you proceed?__

  - Create a Service Control Policy on your AWS account that restricts Developers
  from attaching themselves the AdministratorAccess policy.
  - Put the developers into an IAM group and define an IAM permission boundary
  that will restrict the managed policies they can attach to.
  - `For each developer, define an IAM permission boundary that will restrict the
  managed policies they can attach to themselves.`
  - Attach an IAM policy to your developers, that prevents them from attaching
  the AdministratorAccess policy.

  _AWS Organization is not mentioned in this question, so we can't apply an SCP._

  _Here we have to use a permission boundary. A permissions boundary is an advanced feature for using a managed policy to set the maximum permissions that an identity-based policy can grant to an IAM entity. An entity's permissions boundary allows it to perform only the actions that are allowed by both its identity-based policies and its permissions boundaries. A permission boundary can only be applied to IAM roles or users not groups_  

- __Your company is deploying a website running on Elastic Beanstalk. That website takes over 45 minutes to install and contains both static and dynamic files that must be generated during the installation process. As a Solutions Architect, you would like to bring the time to create a new Instance in your Elastic Beanstalk deployment to being less than 2 minutes. What do you recommend? (select two)__

  - Use EC2 instance data to install application at booth time

- __Your company runs a website for evaluating coding skills. As a Solutions Architect, you've designed the architecture of the website to follow a serverless pattern on the API side, with API Gateway and AWS Lambda. The backend is leveraging an RDS PostgreSQL database and you have chosen to implement caching using a Redis ElastiCache cluster. You would like to increase the security of your authentication to Redis from the Lambda function, leveraging a username and password combination. As a solutions architect, which of the following options would you recommend?__

  - Enable KMS Encryption
  - `Use Redis Auth`
  - Create an inbound rule to restrict access to Redis auth only from the lambda security group.
  - Use an IAM Auth and attach an IAM Role to Lambda.

- __A Solutions Architect is designing a Lambda function that calls an API to
list all running Amazon RDS instances. How should the request be authorized?__

  A. Create an IAM access and secret key, and store it in the Lambda function.
  `B. Create an IAM role to the Lambda function with permissions to list all Amazon RDS instances.`
  `C. Create an IAM role to Amazon RDS with permissions to list all Amazon RDS instances.`
  D. Create an IAM access and secret key, and store it in an encrypted RDS database.

  I thought B, site says C - Hmmm
  https://aws.amazon.com/premiumsupport/knowledge-center/users-connect-rds-iam/
  https://dzone.com/articles/create-an-aws-lambda-function-to-stop-and-start-an

- __A company plans to use an Amazon VPC to deploy a web application consisting of
an elastic load balancer, a fleet of web and application servers, and an Amazon
RDS MySQL database that should not be accessible from the Internet. The proposed
design must be highly available and distributed over two Availability Zones.__

__What would be the MOST appropriate VPC design for this specific use case?__

  A. Two public subnets for the elastic load balancer, two public subnets for the web servers, and two public subnets for Amazon RDS.
  `B. One public subnet for the elastic load balancer, two private subnets for the web servers, and two private subnets for Amazon RDS.`
  C. One public subnet for the elastic load balancer, one public subnet for the web servers, and one private subnet for the database.
  D. Two public subnets for the elastic load balancer, two private subnets for the web servers, and two private subnets for RDS.

  https://docs.aws.amazon.com/elasticloadbalancing/latest/network/network-load-balancers.html#cross-zone-load-balancing
  >By default, each load balancer node distributes traffic across the registered targets in its Availability Zone only. If you enable cross-zone load balancing, each load balancer node distributes traffic across the registered targets in all enabled Availability Zones.

  Further reading

  https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-manage-subnets.html
  >We recommend that you add one subnet per Availability Zone for at least two Availability Zones. This improves the availability of your load balancer.

  https://aws.amazon.com/articles/best-practices-in-evaluating-elastic-load-balancing/
  >You can build fault tolerant applications by placing your Amazon EC2 instances in multiple Availability Zones. To achieve even more fault tolerance with less manual intervention, you can use Elastic Load Balancing. When you place your compute instances behind an elastic load balancer, you improve fault tolerance because the load balancer can automatically balance traffic across multiple instances and multiple Availability Zones. This ensures that only healthy EC2 instances receive traffic.

- __A Solutions Architect is designing a web application that will be hosted on
Amazon EC2 instances in a public subnet. The web application uses a MySQL
database in a private subnet. The database should be accessible to database administrators.__

__Which of the following options should the Architect recommend? (Choose two.)__

  A. Create a bastion host in a public subnet, and use the bastion host to connect to the database.
  `B. Log in to the web servers in the public subnet to connect to the database.`
  C. Perform DB maintenance after using SSH to connect to the NAT Gateway in a public subnet.
  `D. Create an IPSec VPN tunnel between the customer site and the VPC, and use the VPN tunnel to connect to the database.`
  E. Attach an Elastic IP address to the database.

  _Since the EC2 instances are already in a public subnet, you do not need a
  bastion host. That would be additional administration._

- __A company has a popular multi-player mobile game hosted in its on-premises
datacenter. The current infrastructure can no longer keep up with demand and the
company is considering a move to the cloud.__

__Which solution should a Solutions Architect recommend as the MOST scalable and
cost-effective solution to meet these needs?__

  A. Amazon EC2 and an Application Load Balancer
  B. Amazon S3 and Amazon CloudFront
  _Compute missing__
  C. Amazon EC2 and Amazon Elastic Transcoder
  _Plain wrong_
  D. AWS Lambda and Amazon API Gateway
  _Storage missing_

  Meanwhile, the most scalable and cost efficient is Amazon S3.

  https://aws.amazon.com/blogs/gametech/game-developers-guide-to-the-aws-sdk/
  https://d0.awsstatic.com/whitepapers/aws-scalable-gaming-patterns.pdf

- __An organization regularly backs up their application data. The application backups are required to be stored on Amazon S3 for a certain amount of time. The backups should be accessed instantly in the event of a disaster recovery.__

__Which of the following Amazon S3 storage classes would be the MOST cost-effective option to meet the needs of this scenario?__

  A. Glacier Storage Class
  B. Standard Storage Class
  `C . Standard Infrequent Access (IA)`
  D. Reduced Redundancy Class (RRS)

  RRS is cheaper but; Is it deprecated?

- __An organization runs an online voting system for a television program. During broadcasts, hundreds of thousands of votes are submitted within minutes and sent to a front-end fleet of auto-scaled Amazon EC2 instances. The EC2 instances push the votes to an RDBMS database. The database is unable to keep up with the front-end connection requests.
What is the MOST efficient and cost-effective way of ensuring that votes are processed in a timely manner?__

  A. Each front-end node should send votes to an Amazon SQS queue. Provision worker instances to read the SQS queue and process the message information into RDBMS database.
  B. As the load on the database increases, horizontally-scale the RDBMS database with additional memory-optimized instances. When voting has ended, scale down the additional instances.
  C. Re-provision the RDBMS database with larger, memory-optimized instances. When voting ends, re-provision the back-end database with smaller instances.
  D. Send votes from each front-end node to Amazon DynamoDB. Provision worker instances to process the votes in DynamoDB into the RDBMS database.

  I say C; Site says A - Hmmm

- __An application publishes Amazon SNS messages in response to several events. An AWS Lambda function subscribes to these messages. Occasionally the function will fail while processing a message, so the original event message must be preserved for root cause analysis.
What architecture will meet these requirements without changing the workflow?__

  A. Subscribe an Amazon SQS queue to the Amazon SNS topic and trigger the Lambda function from the queue.
  B. Configure Lambda to write failures to an SQS Dead Letter Queue.
  C. Configure a Dead Letter Queue for the Amazon SNS topic.
  D. Configure the Amazon SNS topic to invoke the Lambda function synchronously.

  A dead-letter queue is attached to an Amazon SNS subscription (rather than a topic)
  A dead-letter queue associated with an Amazon SNS subscription is an ordinary Amazon SQS queue.
  https://docs.aws.amazon.com/sns/latest/dg/sns-dead-letter-queues.html

- __A CRM web application was written as a monolith in PHP and is facing growth issues because of performance bottlenecks. The CTO wants to re-engineer towards a microservices based approach for their website and expose their website from the same load balancer, linked to different target groups with different URLs: checkout.mycorp.com, www.mycorp.com, mycorp.com/profile and mycorp.com/search. It would like to expose all these URLs as HTTPS endpoints for security purposes. As a solutions architect, which of the following would you recommend as a solution for the given use-case?__

  - Wild card SSL certificate
  - HTTP to HTTPs redirect
  - Use SSL certificates with SNI
  - Change the ELB SSL security policy.

- __A Solutions Architect is building an application that stores object data.
Compliance requirements state that the data stored is immutable. Which service
meets these requirements?__

  A. Amazon S3
  `B. Amazon Glacier`
  C. Amazon EFS
  D. AWS Storage Gateway

  _Glacier provides immutability, whereas S3 provides object lock (effectively
  write protection). Write protection differs from immutability in that write
  protection can be removed (e.g by mistake). Remember this is a compliance
  requirement - Auditors could easily shoot down your object lock argument_

- __A Solutions Architect needs to allow developers to have SSH connectivity to
web servers. The requirements are as follows:__

  - Limit access to users origination from the corporate network.
  - Web servers cannot have SSH access directly from the Internet.
  - Web servers reside in a private subnet.

__Which combination of steps must the Architect complete to meet these requirements? (Choose two.)__

  - Create a bastion host that authenticates users against the corporate directory.
  - Create a bastion host with security group rules that only allow traffic from the corporate network.
  - Attach an IAM role to the bastion host with relevant permissions.
  - Configure the web servers' security group to allow SSH traffic from a bastion host.
  - Deny all SSH traffic from the corporate network in the inbound network ACL.

  I chose B and D, Site says A and C - Hmmm

  B& D
  Why it is not:
  A - Limit access based on corporate 'network' not directory(developers can still use their credentials and login from anywhere on the internet)
  C - IAM role not required for this scenario
  E - Inbound traffic from corporate network should be allowed, just not directly (hence we are using bastion host)

  At first I agreed with B & D but I changed my mind after paying very close
  attention to the part of the requirements that says "Limit access to users
  origination from the corporate network" and "Web servers reside in a private
  subnet", which I interprete as developers acccessing from anywhere to first
  get access to the corporate network and from there they can then connect to
  the web servers via SSH. So create a bastion host with IAM role with relevant
  permissions to allow the developers (Option C) and then configure the bastion
  host to authenticate the users against corporate directory (Option A).
  The web servers' security group should not be allowing SSH traffic from a
  bastion host but instead from the corporate network (D is wrong). The bastion
  host should not be configured to only allow traffic from the corporate
  network but instead from the developers (B is wrong). B and D could have
  been right if we are assuming the developers are working on premise from
  the corporate network in which case there would be no need for the bastion
  host as they might as well just connect directly to the web servers.

- __Your company is building a video streaming service accessible to users who have paid an ongoing subscription. The users who have paid their subscription have their data in DynamoDB. You would like to expose the users to a serverless architecture allowing them to request the video files that sit on S3 and are distributed by CloudFront, protected by an origin access identity (OAI).__

__What do you recommend? (select two)__

  - `Generate a CloudFront signed URL`
  - Use AWS Lambda to generate the URL
  - Use API Gateway to generate the URL
  - Generate an S3 pre-signed URL

  _Generating S3 pre-signed URLs would bypass CloudFront, therefore we should use
  CloudFront signed URLs. To generate that URL we must code, and Lambda is the
  perfect tool for running that code on the fly._

- __You are looking to build an index of your files in S3, using Amazon RDS PostgreSQL. To build this index, it is necessary to read the first 250 bytes of each object in S3, which contains some metadata about the content of the file itself. There is over 100,000 files in your S3 bucket, amounting to 50TB of data. how can you build this index efficiently?__

  - Use the RDS import feature to load the data from S3 to PostgreSQL, and run
  an SQL query to build the index.
  - Create an application that will traverse the S3 bucket. Use S3 select to get
  first 250 bytes, and store that information in RDS.
  - Create an application that will traverse the S3 bucket, read all the files
  one by one, extract the first 250 bytes, and store that information in RDS.
  - `Create an application that will traverse the S3 bucket, issue a Byte Range
  Fetch for the first 250 bytes, and store that information in RDS.`

  You cannot import data from S3 into RDS

  If you build an application that loads all the files from S3, that would work, but you would read 50TB of data and that may be very expensive and slow.

  S3 Select is a new Amazon S3 capability designed to pull out only the data you need from an object, which can dramatically improve the performance and reduce the cost of applications that need to access data in S3.

  S3 select cannot be used to get the first bytes of a file, unfortunately.

  Using the Range HTTP header in a GET Object request, you can fetch a byte-range from an object, transferring only the specified portion. You can use concurrent connections to Amazon S3 to fetch different byte ranges from within the same object. This helps you achieve higher aggregate throughput versus a single whole-object request. Fetching smaller ranges of a large object also allows your application to improve retry times when requests are interrupted.

  A byte-range request is a perfect way to get the beginning of a file and ensuring we remain efficient during our scan of our S3 bucket.

  Reference: https://docs.aws.amazon.com/AmazonS3/latest/dev/optimizing-performance-guidelines.html#optimizing-performance-guidelines-get-range

- __As part of securing an API layer built on Amazon API gateway, a Solutions Architect has to authorize users who are currently authenticated by an existing identity provider. The users must be denied access for a period of one hour after three unsuccessful attempts.__

__How can the Solutions Architect meet these requirements?__

  - Use AWS IAM authorization and add least-privileged permissions to each respective IAM role.
  - `Use an API Gateway custom authorizer to invoke an AWS Lambda function to validate each user's identity.`
  - Use Amazon Cognito user pools to provide built-in user management.
  - Use Amazon Cognito user pools to integrate with external identity providers.

  _The users are already authenticated_
  _Locking users out for a period of one hour after 3 unsuccessful attempts cannot
  be achieved using Cognito__

  Cognito has fixed lockout policy
  https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html

  Lambda - custom authoriser can set specific lockout rules.

  https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-use-lambda-authorizer.html
  >A Lambda authorizer (formerly known as a custom authorizer) is an API Gateway feature that uses a Lambda function to control access to your API.

  >A Lambda authorizer is useful if you want to implement a custom authorization scheme that uses a bearer token authentication strategy such as OAuth or SAML, or that uses request parameters to determine the caller's identity.

  >When a client makes a request to one of your API's methods, API Gateway calls your Lambda authorizer, which takes the caller's identity as input and returns an IAM policy as output

- __A Solutions Architect is about to deploy an API on multiple EC2 instances
in an Auto Scaling group behind an ELB. The support team has the following
operational requirements:__

  1. They get an alert when the requests per second go over 50,000
  2. They get an alert when latency goes over 5 seconds
  3. They can validate how many times a day users call the API requesting highly-sensitive data

__Which combination of steps does the Architect need to take to satisfy these
operational requirements? (Select two.)__

  - Ensure that CloudTrail is enabled.
  - Create a custom CloudWatch metric to monitor the API for data access.
  - `Configure CloudWatch alarms for any metrics the support team requires.`
  - `Ensure that detailed monitoring for the EC2 instances is enabled.`
  - Create an application to export and save CloudWatch metrics for longer term trending analysis.

  We don't need cloud trail at all... The API mentioned in the question is different, cloud trail does monitor the API calls for the Aws services.

  The need for detailed monitoring is not obvious. There is no mention of how frequently the metrics should be logged. Detailed monitoring will give you 1-min logs instead of 5. As AWS documentation says: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch-new.html

- __You have multiple AWS accounts managed by AWS Organization and you would like to ensure all EC2 instances in all these accounts can communicate privately. Which of the following solutions provides the capability at the CHEAPEST cost?__

  - Create a VPC peering connection between all VPCs
  - Create a PrivateLink between all the EC2 instances.
  - Create a Transit Gateway and link all the VPCs in all the accounts together.
  - `Create a VPC in an account and share it with the other accounts using
  Resource Access Manager.`

  _AWS Transit Gateway is a service that enables customers to connect their Amazon Virtual Private Clouds (VPCs) and their on-premises networks to a single gateway. A Transit Gateway will work, but will be an expensive solution. Here we want to minimize cost._

  _AWS Resource Access Manager (RAM) is a service that enables you to easily and securely share AWS resources with any AWS account or within your AWS Organization. You can share AWS Transit Gateways, Subnets, AWS License Manager configurations, and Amazon Route 53 Resolver rules resources with RAM. RAM eliminates the need to create duplicate resources in multiple accounts, reducing the operational overhead of managing those resources in every single account you own. You can create resources centrally in a multi-account environment, and use RAM to share those resources across accounts in three simple steps: create a Resource Share, specify resources, and specify accounts. RAM is available to you at no additional charge._

  _The correct solution is to share a VPC using RAM. This will allow all EC2 instances to be deployed in the same VPC (although from different accounts) and easily communicate with one another._

- __You are establishing a monitoring solution for desktop systems, that will be sending telemetry data into AWS every 1 minute. Data for each system must be processed in order, independently, and you would like to scale the number of consumers to be possibly equal to the number of desktop systems that are being monitored. What do you recommend?__

  - Use an SQS FIFO queue, and send the telemetry data as is.
  - `Use an SQS FIFO queue and make sure the telemetry data is sent with a
  Group ID attribute representing the value of the Desktop ID.`
  - Use a Kinesis Data Stream, and send the telemetry data with a Partition ID
  that uses the value of the Desktop ID.
  - Use an SQS queue, and send the telemetry data as is.

  _The following requirement rules out Kinesis: "would like to scale the number of consumers to be possibly equal to the number of desktop systems that are being monitored"_

  _We can only have as many consumers as shards in Kinesis_

  _The default shard quota is 500 shards per data stream for the following AWS regions: US East (N. Virginia), US West (Oregon), and Europe (Ireland). For all other regions, the default shard quota is 200 shards per data stream._


Questions 81 and 89 -> Unresolved ?
https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate/view/9/

### References ###

- <a name="elb-connection-draining">24a</a> - [AWS - ELB connection draining](https://aws.amazon.com/blogs/aws/elb-connection-draining-remove-instances-from-service-with-care/)

- <a name="target-group-deregistration-delay">24b</a> - [AWS - Target Groups - De-registration delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay)

- <a name="sns-not-exacly-once">26a</a> - [AWS FAQs - SNS](https://aws.amazon.com/sns/faqs/)

- <a name="sqs-fifo-exactly-once">26b</a> - [AWS FAQs - SQS](https://aws.amazon.com/sqs/faqs/)

- <a name="monitoring-vpn-cloudwatch">34</a> - [Monitoring VPN - CloudWatch](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/monitoring-cloudwatch-vpn.html)

- <a name="s3-optimizing-performance">35</a> - [S3 - Optimizing Performance](https://docs.aws.amazon.com/AmazonS3/latest/dev/optimizing-performance.html)

- <a name="ecs-bootstrap-container-instance">36</a> - [Amazon ECS - bootstrap container instance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/bootstrap_container_instance.html)

- <a name="ebs-features">37</a> - [Amazon EBS - Features](https://aws.amazon.com/ebs/features/)
