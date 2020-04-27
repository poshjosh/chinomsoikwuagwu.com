---
path: "./2020/04/03/Questions-and-Answers_AWS-Certified-Cloud-Architect-Associate.md"
date: "2020-04-03"
title: "Questions and Answers - AWS Certified Cloud Architect Associate"
description: "Questions and Answers - AWS Certified Cloud Architect Associate"
lang: "en-us"
---

Default max amount of bucket is 100
Default max amount of objects in bucket is infinity (theoritically)
GOOGLE THIS -> How to protect EBS data - Snapshots, Volume recovery etc

### Questions ###

1. What is the maximum number of vaults an AWS account can create in a region?

2. What is longest duration of an SWF workflow execution
  - 12 months
  - 30 days
  - 364 days
  - 10 days

3. Which services provide full administrative control of EC2 instances
   - Elastic Beanstalk
   - RDS
   - MapReduce
   - LightSail
   - DynamoDB
   - ElasticCache

4. What is the expected recovery window for a Glacier restore with standard access?

5. ADD QUESTION HERE

6. Which of the following 3 API actions in AWS STS return temporary security
credentials with a default expiration time of one hour
   - GetFederationToken
   - AssumeRole
   - AssumeRolewithSAML
   - AssumeRoleWithWebIdentity
   - GetSessionToken

7. ADD QUESTION HERE

8. Database requires occasional internet connection to download system and
database updates
  - Db in private subnet
  - Db in public subnet
  - NAT instance in public subnet and route internet bound traffic to NAT from
  private subnet
  - NAT instance in private subnet and route internet bound traffic to NAT from
  private subnet

9. Which is true. S3 supports
   - Eventual consistency for overwrite PUTS and UPDATES
   - Eventual consistency for overwrite PUTS and DELETES
   - Read after write consistency for PUTS of new objects in all regions
   - Read after write consistency for PUTS of new objects in US regions

10. ADD QUESTION HERE

11. ADD QUESTION HERE

12. Which AWS network feature gives low latency and high packet per second network performance
  - Amazon Hypervisor
  - Security Group
  - Amazon HVM
  - Placement Group

13. ADD QUESTION HERE

14. ADD QUESTION HERE

15. Where to get info like timestamps, client ip, latencies, request paths from
load balancers.
  - Metrics from CloudWatch
  - Acess Logs from the web servers
  - Acess Logs from the load balancers
  - Metrics from CloudTrail

16. Connecting to EC2 via putty receives 'Connection timed out' error. What
possible causes? Check the:
  - Role attached to EC2 instance
  - Security Group rules
  - Private/public keys
  - Route table for the subnet
  - Username/password
  - Network access control list

17. Default visibility time for a queue in SQS
  - 12 hours
  - 30 secs
  - 1 day
  - 1 hour

18. ADD QUESTIONS HERE on SNS and SQS limitations

### Answers ###

1. What is the maximum number of vaults an AWS account can create in a region?
1000 *

2. What is longest duration of an SWF workflow execution
  - 12 months
  - 30 days *
  - 364 days
  - 10 days

3. Which services provide full administrative control of EC2 instances
   - Elastic Beanstalk *
   - RDS
   - MapReduce *
   - LightSail
   - DynamoDB
   - ElasticCache

4. What is the expected recovery window for a Glacier restore with standard access?
3- 5hours *

5. ADD QUESTION HERE

6. Which of the following 3 API actions in AWS STS return temporary security
credentials with a default expiration time of one hour
   - GetFederationToken
   - AssumeRole *
   - AssumeRolewithSAML *
   - AssumeRoleWithWebIdentity *
   - GetSessionToken

7. ADD QUESTION HERE

8. Database requires occaissional internet connection to download system and
database updates
  - Db in private subnet
  - Db in public subnet
  - NAT instance in public subnet and route internet bound traffic to NAT from
  private subnet *
  - NAT instance in private subnet and route internet bound traffic to NAT from
  private subnet

9. Which is true. S3 supports
   - Eventual consistency for overwrite PUTS and UPDATES
   - Eventual consistency for overwrite PUTS and DELETES *
   - Read after write consistency for PUTS of new objects in all regions *
   - Read after write consistency for PUTS of new objects in US regions

10. ADD QUESTION HERE

11. ADD QUESTION HERE

12. Which AWS network feature gives low latency and high packet per second network performance
  - Amazon Hypervisor
  - Security Group
  - Amazon HVM
  - Placement Group *

13. ADD QUESTION HERE

14. ADD QUESTION HERE

15. Where to get info like timestamps, client ip, latencies, request paths from
load balancers.
  - Metrics from CloudWatch
  - Acess Logs from the web servers
  - Acess Logs from the load balancers *
  - Metrics from CloudTrail

16. Connecting to EC2 via putty receives 'Connection timed out' error. What
possible causes? Check the:
  - Role attached to EC2 instance
  - Security Group rules *
  - Private/public keys
  - Route table for the subnet *
  - Username/password
  - Network access control list *

17. Default visibility time for a queue in SQS
  - 12 hours
  - 30 secs *
  - 1 day
  - 1 hour

18. ADD QUESTIONS HERE on SNS and SQS limitations
