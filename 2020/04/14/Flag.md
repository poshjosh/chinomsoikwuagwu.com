@TODO try qwiklabs.com

A plan to master AWS and pass the certification exam.

Hands on experience with AWS products is indispensable

Initial pass rate is less than 25 percent

Compute
Storage
Databases
Network & Content Delivery
Application Integration
Desktop & App Streaming
Management Tools
Analytics
Migration
Security, Identity & Compliance

Cloud
Distributed Systems
Decoupled architectures

Comparisons between various services

- EBS vs EFS vs S3

- Systems Manager vs CloudWatchEvents + AWSConfig

System Manager enables you do a lot. However it is schedule based. This means
that we can set actions to take place at specific times. What happens when
we want an action to take place when, for example, a new EC2 instance is
launched? This is where `CloudWatch Events` and `AWS Config` come in.

Service Limitations

- Lamda limitations

Service Limits

- ip addresses per region

Design architectures

- Sample architectures

- Sample templates

Study Official Documentation

- Service documentations - Final word
- FAQs
- AWS Whitepapers.

  * Start by reading the following:

    - Overview of Amazon Web Services
    - Architecting for the Cloud: AWS Best Practices
    - AWS Security Best Practices

  * Also read the following

    - AWS Storage Services Overview
    - AWS Well Architected Framework
    - Overview of Security Processes

- AWS Event Videos

  * https://www.youtube.com/user/AmazonWebServices
  * Level 300 (intermediate) and 400 (advanced) vides
  * Good video: Another Day, Another Billion Packets

- AWS Architecture Centre

  * https://aws.amazon.com/architecture
  * CloudFormation templates

- AWS Answers

  * https://aws.amazon.com/answers

- qiklabs.com

- Personal projects

  * Build a WordPress site using EC2/RDS
  * Create a custom VPC with a NAT Gateway
  * Deploy a website using Amazon S3 and CloudFront
  * Create a Lambda function to backup EBS volumes
  * Use Elastic Beanstalk to deploy a PHP website
  * Create a CloudFormation template to automate one or more of the above
  projects

Exam Blue Print

### Design Resilient Architecture ###

__Storage Types__

- EC2 instance store is only supported by a limited EC2 instance types.
  It has a limited capacity
  It is extremely fast
  It is temporary (aka ephemeral) i.e only exists for the life of the instance

- Elastic Block Store
  It is network attach storage

- Elastic File System

  * EFS is a managed service
  * Elastic, so you don't have to define storage allocation at creation
  * Can be attached to multiple EC2 instances
  * Supports both NFS 4.0 and 4.1
  * As of 1 May 2020. [Using Amazon EFS with Microsoft Windows–based Amazon EC2 instances is not supported](https://docs.aws.amazon.com/efs/latest/ug/whatisefs.html).

- Amazon S3

__Decoupling Applications using AWS__

- Decouple for health/resilience using queues

- Decouple for scalability using queues. Use CloudWatch combined with SQL to
monitor the queue and make auto scaling changes

- Decouple for scalability using Elastic Load Balancers.

__CloudFormation__

__Auto Scaling__

__Lamda__

Example questions:

- A solutions arch is designing a highly scalable system to track patient records
Records must remain available for imm dowland

  * Store files in EBS, create lifecycle policy to move them to Glacier Glacier after 6 months

  * Store files in Glacier, create lifecycle policy to move them to Glacier S3 after 6 months

  * `Store files in S3, create lifecycle policy to move them to Glacier Glacier after 6 months`

  * Store files in EFS, create lifecycle policy to move them to Glacier after 6 months

Note: Lifecycle policies are for S3

- Requirement to host a dabase on an EC2 instance. The storage option chosen
must support 28,000 IOPs

  * `EBS Provisioned IOPS SSD`

  * EBS Throughpout Optimized HDD

  * EBS General Purpose SSD

  * EBS Max IOPS SSD

### Defining Performant Architectures ###

Choose performant storage and databases.

SSD dominates for random reads

Multiple users download different files = random e.g web apps

HDD provides much better performance for sequential reads

Single user accessing large content = sequential e.g big data

You pay for what you use in GB per month
You pay for transferring data out of the region where the data resides
You pay for `PUT`, `copy`, `POST`, `list` and `GET` request. `GET` the
most expensive.

- RDS - managed relational database

  * Know all 6 supported database engines.
  * Understand multi-AZ deployments with RDS
  * Understand how read replicas are used with RDS
  * Replication from master to standby is done syncronously.

DynamoDB - managed NoSQL database

  * Strongly consistent read  - 1 read per second
  * Eventually consistent read  - 2 reads per second
  * Writes - 1 read per second

Redshit - managed big data (for e.g data warehouse)

Caching

CloudFront

Cache dynamic and static content at the edge

Use SSL and Origin Access Identity (OAI) to protect CloudFront content.

Application layer caching

- Redis - better for NoSQL databases
  * Vertical scaling
  * Atomic counters
  * Supports read replicas - If you loose a node, you don't loose all your
  cached data unlike Memcached
  * Leaderboards/Counters

- Elasticache (Memcached) - better for relational db
  * Horizontal scaling
  * Low maintenace
  * Storing session state

DAX - Dynamo Db Accelerator is a better choice when working with DynamoDB

__Design Solutions for Elasticity and Scalability__

Horizontal scaling - Auto scaling

Use Elastic Load Balancer (ELB)

3 components of auto scaling

- `Launch configuration` can only be copied or replaced but not modified.

- `Auto Scaling Groups`. these reference the launch config, specify the min
max and desired size of the auto scaling group. You can reference the elastic
load balancer from the auto scaling group. Health checks can be set up
for auto scaling groups.

- `Auto Scaling Policy`. Specify how much we should scale in and out. Multiple
policies can be attached to an auto scaling group.

CloudWatch Metrics

- Hypervisor level. E.g CPU utilization and network bandwidth

- Those that require a CloudWatch agent to be installed on the EC2 instance. E.g disk
space utilization.

- Default CloudWatch monitoring at 5 minute intervals.

- Detailed CloudWatch monitoring at 1 minute interval.

Questions

- An RDS MySQL database is getting lots of read and has become the bottleneck
for the application. What action can be peformed to ensure that the
database does not remain a bottleneck.

  a. Setup CloudFront distribution in front of the database.
  CloudFront in front of a database is not a typical architecture.

  b. Setup an Elastic Load Balancer in front of the database.
  Load Balancers sit in front of application and web servers not database.

  c. `Setup an ElastiCache cluster in front of the database`

  d. Setup SNS in front of the database
  Why send notifications, to what end?

- A company has an application hosted in AWS. The application is deployed on a
set of Ec2 instances across two AZs for high availability. The infrastructure
is deployed behind a application load balancer.

The following are requirements from and administrative perspective.

  1. Ensure notifications are sent when the read requests exceed 100 per minute.

  2. Ensure latency exceeds 15 seconds

  3. Any API activity which calls sensitive data must be monitored.

  Which of the following meets the requirements? Choose 2.

  a. Use CloudTrail to monitor API activity.

  b. Use CloudWatch to monitor API activity.
  Not used to monitor API activity.

  c. `Use CloudWatch metrics to create custom metrics and setup an alarm
  to send out notifications when the threshold is reached.`

  d. Use custom log software to monitor latency and read requests to the
  application load balancer.

An application is being designed for deployment into AWS. The application will
use Amazon S3 buckets for storing as well as reading data. The write traffic
is expected to be 6,500 requests per second and the read traffic will be
around 8,000 requests per second.

What is the best way to architect the solution for maximum Amazon s3
performance.

a.  Use as many s3 prefixes as you need in parallel to achieve the required
throughput.

b. `Prefix each object name with a hex hash key along with the current date.`
Make the keys distinctive.

c. Enable versioning on the S3 bucket.

d. Setup cross region replication on the bucket and preform reads from the
secondary bucket.

- A company has a workflow that sends video files from their datacenter into
the cloud for transcoding. They are using EC2 instances to pull transcoding
jobs from SQL.

Why is SQL the best choice for creating a decoupled architecture.

a. SQL guarantees the order of messages.

b. SQL checks the health of the worker instances.

c. `SQL makes it easier to carry out horizontal scaling of the encoding tasks.`

d. SQL synchronously provides transcoding output.

### Specify Secure Applications and Infrastructure ###

- Shared Responsibility Model.

Understand the difference between security in the cloud and security of the cloud.

- Principle of least privilege.

- Identity and Access Management (IAM)

- Prefer assigning roles to resources over user account with access keys.

- You need to know how to create a VPC from scratch, rather than using the wizard.

- Difference between security groups and NACLs

- Know difference between public and private subnet and when to use them.
For a subnet to be public, it must contain a route table route to the
internet gateway.

- VPC Peering, NAT Gateways, Internet Gateways, Virtual Private Gateways,
Direct Connect etc

__Securing Data__

- In transit - SSL certificates for web traffic. IPSec for VPN traffic or
Direct Connect (put an IPSec tunnel inside Direct Connect)

- At rest
  * Four ways that we can encrypt data in amazon S3
    - Amazon S3 managed keys - SSE - S3  - Uses AES 256
    - SSE - KMS - Key management service
    - SSE - C - Customer Managed Keys
    - Client side encryption - Upload data you already encrypted.
  * Amazon EBS support encryption of data with KMS
  * KMS can integrate with many other AWS services.
  * KMS FIPS 140-2 level 2 compliance
  * For FIPS Level 3 you use an AWS CloudHSM - a hardware device.
  AWS takes care of the backups and replication between nodes if in a cluster.
  You should have a cluster because if you loose these keys -- too bad!

Questions.

An EC2 instances hosts a voting application that accesses DynamoDB table.
The instance needs to be able to access the table in the most secure way
possible.

Which of the following is the most secure way for the EC2 instance to
access the DynamoDB table.

a. Use KMS keys with permissions to interact with DynamoDb and assign those
keys to the applications.

b. Use an IAM user account that is designated as a service account to ensure
minimum required credentials and assing to the instance.

c. `Use an IAM role with permissions to interact with DynamoDB and assign it
to the EC2 instance.`

d. Configure a VPC gateway endpoint to allow the resources to access
DynamoDB

Always choose a role over a user account.

S3 encryption method to be used for data assuming you do not want to
manage the encryption keys.

a. `SSE-S3`
Doesn't require keys .. all managed by S3.
b. SSE-C
c. SSE-KMS
d. SSE-KMS with CloudHSM

### Design Cost Optimized Architectures ###

Pay as you go
Pay less when you reserve Resources
Pay even less when you use much resources

You typically pay for: capacity, storage and data transfer

You can use DynamoDB to hold meta data for S3 objects.

Optimizing S3 costs.
Storage Class
Storage consumption
Requests
Data transfer

Optimizing EBS volume costs
Volume Type
IOPS
Snapshots
Data Transfer

Serverless is more cost effective in most cases. Look for every opportunity
to incorporate serverless options.

AWS Lamda
S3
API Gateway
Fargate

Guideance for Compute cost optimization.

- Shutdown a server when you don't need.
- Replace with serverless if possible.
- Instance configuration e.g t3 is less expensive than C5 of similar size.
- Type of instance you purchase. E.g a reserved instance saves money than an
on demand instance. Spot instance can be very cost effective.
- Number of instances
- CloudWatch monitoring (detailed) as well custom Cloud metrics costs money
- Auto Scaling.
- OS and Software. e.g Licences software like Oracle.
- Tenancy e.g shared tenancy vs dedicated servers
Some compliance requirements require dedicated servers.

Questions.

Custom application with 200GB MySQL db runs on an EC2 instance.
The app only bein used for short periods of time in the morining
and sometimes in the eveingin.

What is the most cost effectie storage type.

a. Amazon EBS provisioned IOPS SSD.

b. Amazon EBS Throughput Optimized HDD
We are dealing with database (random reads)

c. `Amazon EBS General Purpose SSD`

d. Amazon EFS

Solution arch designin a s system which nees a min of 8 m5.large instances
to serve traffic. The sys will be deployed in us-eas-1 and needs to be
able to handle the failure of an entire availability zone.

Assume all instances properly linked and you can use AZs a - f

How should you distribute the servers to save as much cost
as possible while maintaining high availability.

a. `3 servers in each AZ (a - d)` ???
b. 8 servers in each AZ (a and b)
c. 2 servers in each AZ (a - e)
d. 4 servers in each AZ (a - c)

Consider what happens when one AZ is lost. The question requires a minimum
of 8 left when an AZ is lost.

### Define Operationally Excellent Architecture  ###

- Peform operations with code e.g via CloudFormation
- Evolve
  Continously
  Learn from failures

AWS CloudTrail - Tracks all API calls
AWS Config - Monitor resources and changes to those resources
AWS CloudFormation - Create and Deploy
AWS Inspector - Automated security assessment tool (has an agent) scans
EC2 instances for
AWS Trusted Advisor
VPC Flow logs - Allows you to capture information about ip traffic.
VPC flow logs do not capture packet level info. It only captures meta data
e.g source ip, source port, dest ip and port, tcp protocol, successful or failed.

Db app running on EC 2 instace needs to get updats from the internet.
Which solution bests meet the requirement. A solutions ach nees to
design a solution to get the updates without exposing the instance to
the internet.

Which solution best meets these requirements.

a. Attach a VPC endpoint and add routees for 0.0.0.0./0

b. `Launch a NAT gateway and add routes for 0.0.0.0./0`
Best answer over c below because NAT gateway is a managed service.

c. Deploy a NAT instance in a public subnet and add routes for 0.0.0.0./0

d. Attach an intenet Gateway and add routes for 0.0.0.0./0

A consltant desings large scale architectures using serveral AWS services
that include IAm, EC2, RDS, Dynamo DB and VPC. The consultant would like
to take his designs and make them deasier to deploy to AWS in a more
automate dmanner.

Which service would best meet the requirement.

a. Elastic Beanstalk.

b. CodeDeploy

c. `CloudFormation`

d. OpsWorks

### The Exam ###

The exam has 65 questions
No penalty for guesing
Each question worth the same point
130 minutes
You can skip and come back later
Multiple choice with single answer as well as 2 answers.





### Takeaways ###

- Design for infrastructure failure scenarios

- Understand the difference between fault tolerance and high - availability.

- Managed services are preferred

- For High - availability a single AZ is always incorrect.

- S3 is a good storage storage for unstructured data.

- Look for caching options to improve performance.
