---
path: "./2020/04/19/AWS-Achritect-4_Architecting-for_Performance-Efficiency.md"
date: "2020-04-19T20:37:49"
title: "AWS Achritect 4 - Architecting for Performance Efficiency"
description: "Game changing tutorial on AWS - Architecting for Performance Efficiency"
tags: ["AWS", "tutorial", "architect", "performance", "efficiency", "compute", "storage", "database", "network", "performance review", "bench marking", "load testing", "performance monitoring", "monitoring", "active and passive monitoring", "monitoring phases", "performance tradeoffs", "caching", "partitioning or sharding", "compression", "buffering"]
lang: "en-us"
---

### Before we set off ###

__About this Article__

- Hi, this article contains game changing information for those who would like
to get AWS Certified Cloud Architect certified.

- It is one of a series of articles.

- _[Updated: 31 April 2020]_ This is the fourth (4th) article in the series and here
are links to all the articles:

  * [Part 1 - Architecting for Reliability](/2020/04/14/AWS-Architect-1_Architecting-for-Reliability)
  * [Part 2 - Architecting for Security](/2020/04/14/AWS-Architect-2_Architecting-for-Security)
  * [Part 3 - Architecting for Operational Excellence](/2020/04/14/AWS-Architect-1_Architecting-for-Reliability)
  * [Part 4 - Architecting for Performance Efficiency](/2020/04/19/AWS-Achritect-4_Architecting-for_Performance-Efficiency)
  * [Part 5 - Architecting for Cost Optimization](/2020/04/30/AWS-Achritect-5_Architecting-for_Cost-Optimization)
  * [Part 6 - Passing the Certificate Exam](/2020/04/14/AWS-Architect-6_Passing-the-Certification-Exam)

- This article is an estimated 40 minute read.

__This Article is not an Introduction to AWS__

This series of articles is not an introduction to AWS or any of the core
concepts of the AWS Cloud. You need to be already familiar with some core
concepts of AWS Cloud to fully benefit from this article. In order words,
if you are not familiar with the AWS cloud, you should read the series of
articles beginning at:

- [Notes on Amazon Web Services - 1](/2020/03/02/Notes-on-Amazon-Web-Services_1_Introduction)

- [AWS Certified Solutions Architect Associate - Part 1](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-1_Key-services-relating-to-the-Exam)

### What does it mean to architect for Performance Efficiency? ###

- To better grasp the concept of performance efficiency, we have to, first off,
define performance. `Performance`: in this context means a task or operation
seen in terms of how successfully it is performed. And then there's `Efficiency`
which means the state or quality of achieving maximum productivity with minimum
wasted effort or expense. Simply put performance efficiency means:

  >Successfully performing tasks or operations with maximum productivity and
  minimum wasted effort or expense.

- It is no surprise that `Performance Efficiency` is one of Amazon's
[5 pillars of a well architected system](https://aws.amazon.com/blogs/apn/the-5-pillars-of-the-aws-well-architected-framework/)
and it involves five (5) design principles:

  * `Democratize advanced technologies`. Rather than having your IT team learn
  how to host and run a new technology, they can simply consume it as a service
  managed by AWS, for example.

  * `Go global in minutes`. Easily deploy your system in multiple AWS Regions
  around the world with just a few clicks. This allows you to provide lower
  latency and a better experience for your customers at minimal cost.

  * `Use serverless architectures`. In the cloud, serverless architectures
  remove the operational burden of managing servers and can also lower
  transactional costs because these managed services operate at cloud scale

  * `Experiment more often`. With virtual and automatable resources, you can
  quickly carry out comparative testing using different types of instances,
  storage, or configurations.

  * `Mechanical sympathy`. Use the technology approach that aligns best to
  what you are trying to achieve. For example, consider data access patterns
  when you select database or storage approaches

- Best Practices

  * `Data-driven`. Take a data-driven approach to selecting a high-performance
  architecture. Gather data on all aspects of the architecture, from the
  high-level design to the selection and configuration of resource types.

  * `Continuous Review`. By reviewing your choices on a cyclical basis, you
  will ensure you are taking advantage of the continually evolving AWS cloud.
  Monitoring will ensure you are aware of any deviance from expected performance
  and can take action on it.

  * `Make tradeoffs, use multiple approaches`. Finally, your architecture can
  make tradeoffs to improve performance, such as using compression or caching,
  or relaxing consistency requirements. The optimal solution for a particular
  system will vary based on the kind of workload you have, often with multiple
  approaches combined. Well-architected systems use multiple solutions and
  enable different features to improve performance.

### Selection ###

- Use multiple approaches

- Some architectural approaches:

  * Request-response
  * Event driven
  * Extract, transform, load (ETL)
  * Pipeline

__Compute__

- Compute solutions vary based on: application design, usage patterns, and configuration settings.

- Take advantage of elasticity mechanisms

- Three (3) forms of compute in AWS:
  * `instances` - default option
  * `containers` - improves utilization
  * `functions` - suited to event driven/highly parallelized tasks.

- __Instances__ - Each instance type offers different `compute`, `memory`, and
`storage` capabilities.

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)| GPU      | GPU Mem (GiB)    	
-----|------------------------------------------|-----------------------|---------------|----------|-------------|----------|--------------
A1   | Save cost. For scale out arm workloads.	| EBS only 		          | Up to 10    	| 1 - 16   | 2 - 32      
T    | Burstable CPU usage			                | EBS only		          | Up to 5 	    | 1 - 8    | 0.5 - 32  
M    | General purpose (M5n = network optimized)| EBS, m5?d? = NVMe SSD	| Up to 100	    | 1 - 96   | 4 - 384
C    | Compute optimized (C5n=network optimized)| EBS, C5d.* = NVMe SSD	| Up to 100	    | 2 - 96   | 3.75 - 192
R    | Memory intensive workloads              	| EBS, R?d.* = NVMe SSD | Up to 100    	| 2 - 96   | 15.25 - 768
X    | High performance in-mem applications   	| SSD, EBS optimized    | Up to 25     	| 4 -128   | 122 - 3,904
High Memory | For large in-mem db e.g SAP HANA 	|                       | 100          	|          | 6144 - 24,576
z1d  | Compute + Memory + High frequency       	| NVMe SSD 		          | Up to 25     	| 2 - 48   | 16 - 384
P    | General Purpose GPU                      | EBS, p?d.* = NVMe SSD | Up to 100    	| 4 - 96   | 61 - 768    | 1 - 16   | 12 - 256
Inf1 | For machine learning inference           | EBS                   | Up to 100     | 4 - 96   | 8 - 192     |          |
G    | Graphics intensive and machine learning  |                       | Up to 100    	| 4 - 96   | 16 - 488    | 1 - 8    | 8 - 128
F    | Customizable hardware acceleration with FPGAs| SSD up to 4x950GiB| Up to 25      | 8 - 64   | 122 - 976   | 1 - 8 FPGAs |
I    | Low latency, high random I/O and sequential disk throughput| NVMe SSD | Up to 25 | 2 - 72   | 15.25 - 512
D    | MPP data warehouse, distributed computing| HDD up to 24 x 2000   | Up to 10     	| 4 - 36   | 30.5 - 244
H    | high disk throughput, balance of compute & memory| HDD up to 8 x 2000 | Up to 25	| 8 - 64   | 32 - 256

_Source: [EC2 instance types - curated](/2020/02/07/AWS_EC2-Instance-Types_curated)_

- __Containers__ - You can host multiple containers serving the same service on
a single Amazon EC2 instance.
  * Amazon ECS allows automated execution and management of containers on a
  cluster of EC2 instances.
  * Amazon ECS leverages Auto Scaling groups, which enable you to scale the
  Amazon ECS cluster by adding EC2 instances.  
  * Amazon ECS is integrated with Elastic Load Balancing (ELB)

An Amazon ECS container instance is an Amazon EC2 instance that is running the
Amazon ECS container agent and has been registered into a cluster. The container
agent is pre-installed on ECS-optimized AMIs.

  - The container agent is able to register the instance into one of your clusters.
  - You must launch container instances with an IAM role that authenticates to
  your account and provides the required resource permissions, because the Amazon
  ECS container agent makes calls to Amazon ECS on your behalf.
  - The Amazon ECS instance role is automatically created for you in the console
  first-run experience, in most cases.
  - Beginning with `Linux Amazon ECS-optimized AMI version 20200430` and later,
  the Amazon EC2 Instance Metadata Service Version 2 (IMDSv2) is supported on
  your container instances.
  - Container instances need access to communicate with the Amazon ECS service
  endpoint. This can be through: an `interface VPC endpoint`,
  `public IP addresses` for the instance, or a `network address translation (NAT)`
  - Each container instance has `unique state information` stored locally on
  the container instance and within Amazon ECS, therefore:
    * Do not de-register from one cluster and re-register with another.
    * Do not stop a container to change its instance type.
    Rather than the above, terminate the instance and launch a new instance with
    latest ECS-optimized AMI (in the other cluster, where applicable).
  - A registered instance, instance status = `ACTIVE`, terminated = `INACTIVE`
  - A running instance, connection status = `TRUE`, stopped instance = `FALSE` (connection to ECS)
  - You can still describe the container instance for one hour following termination

  Older versions of the ECS container agent, was known to list duplicate
  container instance ID for the same EC2 instance ID. In this case, you can
  safely deregister the duplicates that are listed as `ACTIVE` and having an
  agent connection status of `FALSE`.

- __Functions__ - Functions abstract the execution environment from the code
you want to execute. Functions could be:
  * Automatically trigger
  * Called directly
  * Called via Amazon API Gateway.

  `Amazon API Gateway` is a fully managed service that makes it easy for
  developers to create, publish, maintain, monitor, and secure APIs at any scale.
  API Gateway handles all the tasks involved in accepting and processing up to
  hundreds of thousands of concurrent API calls, including traffic management,
  authorization and access control, monitoring, and API version management.

- __Elasticity__ - Elasticity allows you to match the supply of resources you
have against demand for them. Optimally matching supply to demand delivers the
lowest cost for a system.

  `Auto Scaling` is the key AWS service for elastic compute solutions.
  Instances, containers, and functions all provide mechanisms for elasticity
  either in combination with Auto Scaling or as a feature of the service itself.

- __Good to know__

>Amazon EC2 dedicates some resources of the host computer, such as CPU, memory, and instance storage, to a particular instance. Amazon EC2 shares other resources of the host computer, such as the network and the disk subsystem, among instances. If each instance on a host computer tries to use as much of one of these shared resources as possible, each receives an equal share of that resource. However, when a resource is underused, an instance can consume a higher share of that resource while it's available.

- __Performance Tips__

  * For __best performance__ Amazon recommends:
    - You upgrade from these `Previous generation instances`: C1, C3, G2, I2, M1, M2, M3, R3, T1
    - Use an `HVM AMI`. In addition, HVM AMIs are required to take advantage of enhanced networking.

  The `Nitro System` is a collection of AWS-built hardware and software
  components that:
    - Enable high `performance`, `availability` and `security`.
    - Provides bare metal capabilities that eliminate virtualization overhead
    and support workloads that require full access to host hardware.  

  * __Maximize network and bandwidth performance__:

    - `Use cluster placement group` - Launch supported instance types into a
    cluster placement group to benefit from high-bandwidth and low-latency networking.
    - `Enable enhanced networking` for supported current generation instance types
    to get significantly higher packet per second (PPS) performance, lower
    network jitter, and lower latencies.

  * To __obtain additional, dedicated capacity for Amazon EBS I/O__, you can launch
  some instance types as EBS–optimized instances. Some instance types are
  EBS–optimized by default.

__Storage__

The optimal storage solution for a particular system varies based on the kind
of `access method` (block, file, or object) you use, `patterns of access`
(random or sequential), `throughput` required, `frequency of access`
(online, offline, archival), `frequency of update` (WORM, dynamic), and
`availability` and `durability` constraints.

- __Storage Characteristics__ - file size, cache size, latency, throughput and
persistence data.

- __Storage Services__- Amazon S3 (the key service), Amazon Glacier, Amazon
Elastic Block Store (Amazon EBS),  Amazon Elastic File System (Amazon EFS)
and Amazon EC2 instance store.

- __Storage Performance__ - Performance can be measured by looking at
`throughput`, input/output operations per second (`IOPS`),  and `latency`.
Understanding the relationship between those measurements will help you
select the most appropriate storage solution.

Storage     | Services               | Latency          | Throughput| Shareable
------------|------------------------|------------------|-----------|----------
Block       | EBS,EC2 instance store | Lowest consistent| Single    | Mounted on single instance, copies via snapshots
File system | EFS                    | Low, consistent  | Multiple  | Many clients
Object      | S3                     | Low-latency      | Web scale | Many clients
Archival    | Glacier                | Minutes to hours | High      | No

- For improved `latency`, when data is accessed:
  * By only one instance - use EBS with provisioned IOPs
  * From different geographical regions - S3 with cross-region replication (CRR).
  * From multiple threads and EC2 instances - EFS

- __Optimizing Amazon S3 Performance__

  * Amazon S3 automatically scales to high request rates up to `3,500`
  `PUT/COPY/POST/DELETE` or `5,500` `GET/HEAD` requests _per second per prefix_
  in a bucket.

  * You could scale read x 10 by creating 10 prefixes to parallelize reads.

  * `To get multiple terabits per second` (e.g for data lakes), exploit the
  full network capacity of each EC2 instance (which could be up to 100GB/s),
  then aggregate this throughput across multiple instances.

  * `To achieve 100-200 millis latency` - S3 capable of such low latencies for
  small objects.

  * Use [Amazon CloudFront](https://docs.aws.amazon.com/cloudfront/index.html),
  [Amazon ElastiCache](https://docs.aws.amazon.com/elasticache/index.html) or
  [AWS Elemental MediaStore](https://docs.aws.amazon.com/mediastore/index.html)
  for `higher transfer rates` over a single HTTP connection or
  `single-digit millisecond latencies`. Use caches to optimized performance when
  a workload is sending repeated GET requests for a common set of objects.

  * Use __Amazon S3 Transfer Acceleration__ for `fast data transport over long
  distances between a client and an S3 bucket`. Transfer Acceleration uses the
  globally distributed edge locations in CloudFront to accelerate data transport over
  geographical distances.

  * Use __byte-range fetches__ for `higher aggregate throughput`. Using the Range
  HTTP header in a GET Object request, you can fetch a byte-range from an object,
  transferring only the specified portion. You can use concurrent connections to
  Amazon S3 to fetch different byte ranges from within the same object.  

  * Use __aggressive timeouts and retries__ to achieve `consistent latency`.
  Given the large scale of Amazon S3, if the first request is slow, a retried
  request is likely to take a different path and quickly succeed. For example
  retries are required when http 503 slow down responses occurs.

  * __Access S3 buckets from EC2 instances in the same AWS Region__ when possible.
  This helps reduce network latency and data transfer costs.

  * Use the Latest Version of the AWS SDKs for taking advantage of Amazon S3
  from within an application. SDKs are regularly updated to follow the latest
  best practices. For example when http 503 slow down responses occur AWS SDK
  implements automatic retry logic with exponential backoff.

__Good to Know__

>Previously Amazon S3 performance guidelines recommended randomizing prefix naming with hashed characters to optimize performance for frequent data retrievals. You no longer have to randomize prefix naming for performance, and can use sequential date-based naming for your prefixes.  

>S3 Glacier provides a console, which you can use to create and delete vaults. However, all other interactions with S3 Glacier require that you use the AWS Command Line Interface (AWS CLI) or write code. For example, to upload data, such as photos, videos, and other documents, you must either use the AWS CLI or write code to make requests, by using either the REST API directly or by using the AWS SDKs.

- __Optimizing EFS__

  * __Performance__
    - You select `general purpose` (lower latency) or `Max I/O` (higher IO)
    performance mode when you create EFS
    - Can't be change and no additional cost for selecting either modes.
    - `Max I/O` for highly parallelized applications, otherwise use `general purpose`
    - For both __higher IO and lower latency__ spread your workload across
    multiple general purpose EFS with each mounted as a sub-directory.

  * __Throughput__ `bursting` and `provisioned` modes
    - Provisioned could be decreased but only in 24 hour intervals.
    - Change between provisioned and default bursting only in 24 hour intervals.
    - Amazon recommends running your application in the Bursting Throughput
    mode, by default.
    - For `migrating large amounts of data into EFS`, consider switching to
    `Provisioned Throughput` mode.
    - Ratio of baseline throughput to storage capacity for Bursting Throughput
    mode is 50 MiB/s per TiB of data stored.
    - If calculated average throughput during normal operations are:
      * At or below the baseline ratio, consider switching to Bursting Throughput mode.
      * Above the baseline ratio, consider lowering the provisioned throughput
      to a point between your current provisioned throughput and the calculated
      average throughput during normal operations.

  * __EFS Storage Classes__ `Infrequent Access (IA)` and `Standard`
    - To use the IA storage class, enable the EFS lifecycle management feature.
    When enabled, lifecycle management automates moving files from Standard
    storage to IA storage.
    - Use `IA` to automatically save on storage costs for files that are less
    frequently accessed.

- __Optimizing EBS__

  * Random or sequential I/O operations - SSD backed EBS,
  * Large and sequential I/O operations - HDD backed EBS.
  * Transaction-intensive applications are sensitive to increased I/O latency
  and are well-suited for SSD-backed `io1` and `gp2` volumes. (i.e provisioned and general purpose volumes)
  * Throughput-intensive applications are less sensitive to increased I/O latency,
  and are well-suited for HDD-backed `st1` and `sc1` volumes. (i.e through put optimized and cold volumes)
  * You can use the `EBSIOBalance%` and `EBSByteBalance%` metrics to help you
  determine whether your instances are sized correctly. You can view these
  metrics in the CloudWatch console. Instances with a consistently low balance
  percentage are candidates to size up.
  * RAID configuration
    - You should avoid booting from a RAID volume
    - `RAID 0` when I/O performance is more important than fault tolerance.  
    For example, you could use it with a heavily used database where data replication is already set up separately.
    - `RAID 1` when fault tolerance is more important than I/O performance; for example, as in a critical application.
    - `RAID 5` and `RAID 6` are not recommended for Amazon EBS

__Database__

Optimal database solution is based on: availability, consistency, partition
tolerance, latency, durability, scalability,  and query capability. Moreover,
there are four factors to keep in mind:

- Access patterns.
- Characteristics.
- Configuration options.
- Operational effort.

- __Database Technologies__

Common database technologies include:

  * __Relational Online Transaction Processing (OLTP)__ e.g Oracle, Microsoft
  SQL Server, MySQL, PostgreSQL, Amazon RDS or Aurora. Optimization requires:
    - Optimizing the underlying instance (compute, memory, storage, network)
    - Optimizing the operating system settings such as volume management, RAID,
    block sizes, and settings
    - Optimizing the database engine configuration and some database-specific
    features, such as partitioning
    - Optimizing the databases themselves by managing the schemas, indexes,
    views and database-related options
    - __RDS__ - Backup, patching, and point-in-time recovery are automated.
    Also provides automated read replicas (not available for Oracle or SQL Server).
    - __Aurora__ - SSD-based storage layer that scales automatically, and
    supports a large number of low-latency read replicas for increased read performance.

  * __Non-relational databases (NoSQL)__ e.g MongoDb, DynamoDB
  Great for large-scale applications
    - __DynamoDB__ - fully managed NoSQL database that provides single-digit
    millisecond latency at any scale. DynamoDB automatically manages table
    partitioning for you. Selecting an appropriate partition key to ensure that
    your load is evenly distributed across partitions.
    - __Improve Performance__
      * `DynamoDB Accelerator (DAX)` provides a read-through/write-through
      distributed caching tier in front of the database, providing
      sub-millisecond latency for entities that are in the cache.
      * Throughput auto scaling based on limits.

  * __Data warehouse and Online Analytical Processing (OLAP)__
    - __Amazon Redshift__ is a managed petabyte-scale data warehouse that allows
    you to scale the number or type of nodes as performance or capacity need changes.
      * `Best performance` if you specify sort keys, distribution keys, and column encodings
      * Use __Redshift Spectrum__ for S3 data up to exabyte-scale.
      * Enable compression to reduce storage requirements, thereby reducing disk
      I/O, which improves query performance.
      * The best way to enable data compression on table columns is by allowing
      Amazon Redshift to apply optimal compression encodings when you load the
      table with data.
    - Use __Presto__ for weakly structured data. Presto can query information
      at large scale from existing storage solutions and data lakes, such as Amazon S3
    - __Amazon Athena__ is fully managed Presto service that can run queries on
    your data lakes and integrates with data cataloging features of __Amazon Glue__

  * __Data indexing and searching__ - You can deploy Elasticsearch on EC2
  instances. However, it is preferable to use __Amazon Elasticsearch Service (Amazon ES)__,  
  which is a managed service in the AWS Cloud.

- __Optimizing Amazon Aurora__

To optimize performance, allocate enough RAM so that your working set resides almost completely in memory.
To determine whether your working set is almost all in memory, examine the following metrics in Amazon CloudWatch:
  * `VolumeReadIOPS` - average read IOPS - should be `small and stable`.
  * `BufferCacheHitRatio` - how often data served from cache, as opposed to memory - should be `high`.

__Network__

Optimal network solution will vary based on `latency`, `throughput` requirements amongst others.

- Choose the appropriate Region or Regions for your deployment:
  * Where users are located.
  * Where data is located (for data-heavy) applications.
  * Other constraints like security and compliance.

- Use __Placement groups__ to enable applications participate in a low-latency
`20 GBps` network, within a `single AZ`, this is facilitated by
__Elastic Network Adapaters (ENA)__

- Use edge services like __CloudFront__, and __Route 53__ to reduce latency and
enable caching of content. To benefit from caching, ensure you configure cache
control correctly for both DNS and HTTP/HTTPS.

- Reduce network distance or jitter

  * __Latency-based routing (LBR)__ for Route 53, routes requests to the endpoint
  that provides the fastest experience based on actual performance measurements.
  * __AWS Direct Connect__ provides dedicated connectivity to the AWS environment,
  from 50 Mbps up to 10 Gbps
  * __Amazon VPC endpoints__ provide reliable connectivity to AWS services
  (for example,  Amazon S3) without requiring an internet gateway or a Network
  Address Translation (NAT) instance. _Data remains within the AWS network__
  * Load Balancers
    - __Application Load Balancer__ - HTTP/S, more `advanced request routing`.
    - __Network Load Balancer__ - TCP, `extreme performance`, can handle volatile traffic

### Review ###

To adopt a data-driven approach to architecture you should implement a
performance review process that considerers the following:

  * `Infrastructure as code`: CloudFormation templates
  * `Deployment pipeline`: Use a continuous integration/continuous deployment
  (CI/CD) pipeline
  * `Well-defined metrics`: Set up your metrics and monitoring to capture key
  performance indicators (KPIs).
  * `Performance test automatically`: Automatically trigger performance tests
  after the quicker running tests have passed successfully. Alternatively,
  you could execute performance tests overnight using Amazon EC2 Spot Instances.
  * `Load generation`: You should create a series of test scripts that replicate synthetic or
  prerecorded user journeys. Consider using spot instances to generate load.
  * `Performance visibility`: Key metrics should be visible to your team,
  especially metrics against each build version
  * `Visualization`: Use visualization techniques that make it clear where
  performance issues are occuring.

__Bench Marking__

Benchmarking uses synthetic tests to provide you with data on how components
perform. Benchmarking is generally quicker to set up than load testing and is
used when you want to evaluate the technology for a particular component.
Benchmarking is often used at the start of a new project, when you don’t yet
have a whole solution that you could load test. Since benchmarks are generally
faster to run than load tests, they can be used earlier in the deployment
pipeline to provide faster feedback on performance deviations to your team
Benchmarking should be used in conjunction with load testing because load
testing will tell you how your whole workload will perform in production.

__Load Testing__

Load testing uses your actual workload so you can see how your whole solution
performs in a production environment. Load tests should be done using synthetic
or sanitized versions of production data. As part of your delivery pipeline you
can automatically carry out load tests and compare against pre-defined KPIs.
When you write critical user stories for your architecture,  you should include
performance requirements such as specifying how quickly each critical story
should execute. For these critical stories, you should implement additional
scripted user journeys to ensure you have visibility into how these stories
perform against your requirement.

- __AWS Services for Load Testing__

Use CloudWatch to set alarms that indicate when thresholds are breached to
signal that a test is outside of expected performance. Using AWS clould you can
carry out full-scale testing at a fraction of the cost, since you only pay for
the test environment when it is needed. You can use Spot Instances to generate
loads at low cost and discover bottlenecks before they are experienced in production.
You can reduce time by parallelizing your load tests. You can also reduce
costs by using Regions that have lower costs.

- __Load Testing CloudFront__

>Traditional load testing methods don't work well with CloudFront because CloudFront uses DNS to balance loads across geographically dispersed edge locations and within each edge location. When a client requests content from CloudFront, the client receives a DNS response that includes a set of IP addresses. If you test by sending requests to just one of the IP addresses that DNS returns, you're testing only a small subset of the resources in one CloudFront edge location, which doesn't accurately represent actual traffic patterns. Depending on the volume of data requested, testing in this way may overload and degrade the performance of that small subset of CloudFront servers.

To perform load testing that accurately assesses CloudFront performance, Amazon
recommends that you do `all` of the following:

  * Send client requests from __multiple geographic regions__.

  * Configure your test so __each client makes an independent DNS request__;
  each client will then receive a different set of IP addresses from DNS.

  * For each client that is making requests, __spread your client requests across
  the set of IP addresses that are returned by DNS__, which ensures that the load
  is distributed across multiple servers in a CloudFront edge location.

### Monitoring ###

>CloudWatch provides the ability to monitor and send notification alarms.  
You can use automation to work around performance issues by triggering actions
through Amazon Kinesis, Amazon Simple Queue Service (Amazon SQS), and AWS Lambda.

__Active and Passive__

Active monitoring simulates user activity in scripted user journeys across
critical paths in your product. Active monitoring should be continually run
across all environments (especially pre-production environments) to identify
problems or performance issues before they affect end users.

Passive monitoring collects performance metrics from browser/clients etc.
Use passive monitoring to understand these issues:

- User experience performance:

- Geographic performance variability.

- The impact of API use.  

__Phases__

Monitoring at AWS consists of 5 distinct phases, explained in detail in the
[Reliability Pillar of the AWS Well-Architected Framework](https://d1.awsstatic.com/whitepapers/architecture/AWS-Reliability-Pillar.pdf)

1. Generation – scope of monitoring, metrics,  and thresholds.
2. Aggregation – creating a complete view from multiple source.
3. Real-time processing and alarming – recognizing and responding.
4. Storage – data management and retention policies.
5. Analytics – dashboards, reporting,  and insights

Plan for game days, where simulations are conducted in the production
environment, to test your alarm solution and ensure that it correctly
recognizes issues.

### Trade-offs ###

Technique | Applies To | Use | Gains
----------|------------|-----|------
Caching | Read-heavy | Space (Memory) | Time
Partitioning or Sharding | Write-heavy | Size & Complexity | Time
Compression | Large data | Time | Space
Buffering | Many requests |Space & Time | Efficiency

__Caching__

- __Application Level Caching__ - Platforms such as `Redis`, `Memcached`, or
`Varnish` can be deployed on Amazon EC2 to provide robust caching engines for
your applications.

  * __ElasticCache__ is a fully managed service that supports scaling the
  environment, automated failover, patching, and backup.
    - `ElastiCache with Memcached` supports sharding to scale in-memory cache
    with multiple nodes.
    - `ElastiCache for Redis` includes clustering, with multiple shards
    forming a single in-memory key-value store that is terabytes in size,
    plus read replicas per shard for increased data access performance.    

- __Database Level Caching__ - Database replicas enhance performance databases
by replicating all changes to the master databases to read replicas (not
available for Oracle or SQL Server).

  * Add additional indexes to the read replica,  where the database engine supports it.
  * For latency-sensitive workloads you should use the Multi-AZ feature to specify
  which Availability Zones the read replica should be in to reduce cross-Availability Zone traffic.

- __Geographic Level Caching__ - Done via Content Delivery Networks. Even
dynamic content can benefit through the use of network optimization methods.
  * Use CloudFront
  * CloudFront also works seamlessly with any non-AWS origin server, which
  stores the original, definitive versions of your files.

__Partitioning or Sharding__

>When using technologies,  such as relational databases, that require a single
instance due to consistency constraints,  you can only scale vertically
(by using higher specification instances and storage features). When you hit
the limits of vertical scaling,  you can use a different approach called data
partitioning or sharding. With this model, data is split across multiple
database schemas,  each running in its own autonomous primary DB instance.

NoSQL database engines will typically perform data partitioning and replication
to scale both the reads and the writes in a horizontal fashion. They do this
transparently without the need of having the data partitioning logic implemented
in the data access layer of your application. NoSQL databases trade consistency
for this.

- __Amazon DynamoDB__ in particular manages table partitioning for you
automatically, adding new partitions as your table grows in size or as
read-and write-provisioned capacity changes.

- __Amazon RDS__ removes the operational overhead of running multiple instances,
but sharding will still introduce complexity to the application.
  * The application’s data access layer will need to be modified to have
  awareness of how data is split so that it can direct queries to the right
  instance. (You can use a proxy or routing mechanism to remove caching code
  from the application, or implement it in a data access layer.)
  *  Any schema changes will have to be performed across multiple database
  schemas,  so it is worth investing some effort to automate this process.

__Compression__

> Compressing data trades computing time against space and can greatly reduce
storage and networking requirements. Compression can apply to file systems,
data files, and web resources such as stylesheets and images, but also to
dynamic responses such as APIs.

- __CloudFront__ supports compression at the edge.

- __Amazon Redshift__ uses compression with columnar data storage. Amazon Redshift
employs multiple compression techniques. When loading data into an empty table,
Amazon Redshift automatically samples your data and selects the most appropriate
compression scheme.

- Use non-network based solutions, like __AWS Snowball__ when transferring
large quantities of information into or out of the cloud. AWS Snowball is a
petabyte-scale data transport solution that uses secure appliances to transfer
large amounts of data into and out of the AWS Cloud.

__Buffering__

Buffering uses a queue to accept messages (units of work) from producers.  
For resiliency, the queue should use durable storage.

- Use a buffer when you have a workload that generates significant write
load that doesn’t need to be processed immediately.

- On AWS, you can choose from multiple services to implement a buffering approach.

- __Amazon SQS__ provides a queue that allows a single consumer to read individual
messages.

  * Use __long polling__ to reduce the cost of retrieving messages. Long polling
  lets you retrieve messages from your Amazon SQS queue as soon as they become available.

  * SQS `at-least-once` delivery means that you can receive a message more than once.

  * For `exactly-once` processing, use __SQS first in/first out (FIFO)__ queues.

  * For long-running tasks you can extend the `visibility time-out`.

  * Your application will need to delete messages after they have been processed.

- __Amazon Kinesis__ provides a stream that allows many consumers to read
the same messages. It differs from Amazon SQS in that it allows multiple
consumers to read the same message at any one time.

  * Use Spot Instances to optimize the speed with which work items are consumed
  by more consumers

### Takeaways ###

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)| GPU      | GPU Mem (GiB)    	
-----|------------------------------------------|-----------------------|---------------|----------|-------------|----------|--------------
A1   | Save cost. For scale out arm workloads.	| EBS only 		          | Up to 10    	| 1 - 16   | 2 - 32      
T    | Burstable CPU usage			                | EBS only		          | Up to 5 	    | 1 - 8    | 0.5 - 32  
M    | General purpose (M5n = network optimized)| EBS, m5?d? = NVMe SSD	| Up to 100	    | 1 - 96   | 4 - 384
C    | Compute optimized (C5n=network optimized)| EBS, C5d.* = NVMe SSD	| Up to 100	    | 2 - 96   | 3.75 - 192
R    | Memory intensive workloads              	| EBS, R?d.* = NVMe SSD | Up to 100    	| 2 - 96   | 15.25 - 768
X    | High performance in-mem applications   	| SSD, EBS optimized    | Up to 25     	| 4 -128   | 122 - 3,904
High Memory | For large in-mem db e.g SAP HANA 	|                       | 100          	|          | 6144 - 24,576
z1d  | Compute + Memory + High frequency       	| NVMe SSD 		          | Up to 25     	| 2 - 48   | 16 - 384
P    | General Purpose GPU                      | EBS, p?d.* = NVMe SSD | Up to 100    	| 4 - 96   | 61 - 768    | 1 - 16   | 12 - 256
Inf1 | For machine learning inference           | EBS                   | Up to 100     | 4 - 96   | 8 - 192     |          |
G    | Graphics intensive and machine learning  |                       | Up to 100    	| 4 - 96   | 16 - 488    | 1 - 8    | 8 - 128
F    | Customizable hardware acceleration with FPGAs| SSD up to 4x950GiB| Up to 25      | 8 - 64   | 122 - 976   | 1 - 8 FPGAs |
I    | Low latency, high random I/O and sequential disk throughput| NVMe SSD | Up to 25 | 2 - 72   | 15.25 - 512
D    | MPP data warehouse, distributed computing| HDD up to 24 x 2000   | Up to 10     	| 4 - 36   | 30.5 - 244
H    | high disk throughput, balance of compute & memory| HDD up to 8 x 2000 | Up to 25	| 8 - 64   | 32 - 256

- ECS leverages Auto Scaling Groups and integrates with ELB

- An Amazon ECS container instance is an Amazon EC2 instance that is running the
Amazon ECS container agent and has been registered into a cluster

- ECS container agent is able to register the instance into one of your clusters.

- You must launch container instances with appropriate IAM role for the ECS
container agent to make calls to ECS. This role auto created in console, in most cases.

- Container instances communicate with the Amazon ECS through: `interface VPC endpoint`,
`public IP addresses` or `network address translation (NAT)`

- For container instance:
  * Do not de-register from one cluster and re-register with another.
  * Do not stop a container to change its instance type.
  Rather than the above, terminate the instance and launch a new instance with
  latest ECS-optimized AMI (in the other cluster, where applicable).

- You can still describe the container instance for one hour following termination

- In older versions of the ECS container agent, you can safely deregister
duplicates listed as `ACTIVE` and having an agent connection status of `FALSE`.

- __Functions__ - Functions could be:
  * Automatically trigger
  * Called directly
  * Called via Amazon API Gateway.

- For __best performance__ Amazon recommends:
  * You upgrade from these `Previous generation instances`: C1, C3, G2, I2, M1, M2, M3, R3, T1
  * Use an `HVM AMI`. In addition, HVM AMIs are required to take advantage of enhanced networking.

- For __maximized network and bandwidth performance__:
  * `Use cluster placement group` - Launch supported instance types into a
  cluster placement group to benefit from high-bandwidth and low-latency networking.
  * `Enable enhanced networking` for supported current generation instance types
  to get significantly higher packet per second (PPS) performance, lower
  network jitter, and lower latencies.

* To __obtain additional, dedicated capacity for Amazon EBS I/O__, you can launch
some instance types as EBS–optimized instances. Some instance EBS–optimized by default.

- __Storage Services__- Amazon S3 (the key service), Amazon Glacier, Amazon
Elastic Block Store (Amazon EBS),  Amazon Elastic File System (Amazon EFS)
and Amazon EC2 instance store.

- __Storage Performance__ - Performance can be measured by looking at
`throughput`, input/output operations per second (`IOPS`),  and `latency`.

Storage     | Services               | Latency          | Throughput| Shareable
------------|------------------------|------------------|-----------|----------
Block       | EBS,EC2 instance store | Lowest consistent| Single    | Mounted on single instance, copies via snapshots
File system | EFS                    | Low, consistent  | Multiple  | Many clients
Object      | S3                     | Low-latency      | Web scale | Many clients
Archival    | Glacier                | Minutes to hours | High      | No

- For __improved latency__, when data is accessed:
  * By only one instance - use EBS with provisioned IOPs
  * From different geographical regions - S3 with cross-region replication (CRR).
  * From multiple threads and EC2 instances - EFS

- __Optimizing S3__

  * You could scale read x 10 by creating 10 prefixes to parallelize reads.

  * S3 capable of 100 - 200 milliseconds latencies for small objects.

  * Use caches e.g Amazon CloudFront, Amazon ElastiCache or AWS Elemental
  MediaStore:
    - `Higher transfer rates` over a single HTTP connection.
    - `Single-digit millisecond latencies`.
    - `Optimized performance`, for repeated GET requests of a common set of objects.

  * Use __Amazon S3 Transfer Acceleration__ for `fast data transport over long
  distances between a client and an S3 bucket`. Transfer Acceleration uses the
  globally distributed edge locations in CloudFront to accelerate data transport over
  geographical distances.

  * Use __byte-range fetches__ for `higher aggregate throughput`. Byte-range
  fetches allow you to use many concurrent connections to fetch a single object.

  * Use __aggressive timeouts and retries__ to achieve `consistent latency`.
  Given the large scale of Amazon S3, if the first request is slow, a retried
  request is likely to take a different path and quickly succeed.

  * __Access S3 buckets from EC2 instances in the same AWS Region__ when possible.
  This helps reduce network latency and data transfer costs.

  * Use the __Latest Version of the AWS SDKs__ as they follow the latest best practices.

  * __Using glacier require that you use AWS CLI or SDK__, except to create and
  delete vaults which could be done via AWS console.

  * __YOU NO LONGER NEED TO__ randomize prefix naming with hashed characters to
  optimize performance as previously advised.

- __Optimizing EFS__

  * Performance modes: `Max I/O` for highly parallelized applications, otherwise use `general purpose`
  * For both __higher IO and lower latency__ spread your workload across
  multiple general purpose EFS with each mounted as a sub-directory.
  * Throughput modes: `bursting` and `provisioned`
  * `Start with Bursting Throughput mode`, by default.
  * `Migrating large amounts of data into EFS`, switch Provisioned Throughput mode.
  * Ratio of baseline throughput to storage capacity for Bursting Throughput
  mode is 50 MiB/s per TiB of data stored.
  * `Switch to bursting` if average throughput below baseline of 50 MiB/s per TiB.
  * `Lower provisioned throughput` if average throughput above baseline of 50 MiB/s per TiB
  * EFS Storage Classes are `Infrequent Access (IA)` and `Standard`
  * Use `IA` to automatically save on storage costs for files that are less frequently accessed.

- __Optimizing EBS__
  * SSD backed EBS volumes
    - Random or sequential I/O ops
    - Transaction-intensive ops
  * HDD backed EBS volumes   
    - Large and sequential I/O ops
    - Throughput-intensive ops
  * `RAID 0` when I/O performance is more important than fault tolerance.  
  * `RAID 1` when fault tolerance is more important than I/O performance.
  * `RAID 5` and `RAID 6` are not recommended for Amazon EBS

- Prefer managed database services to non managed services.

- For DynamoDB, select an appropriate partition key to ensure that load is
evenly distributed across partitions.

- To improve DynamoDB preformance, use `DynamoDB Accelerator (DAX)`, which uses
a cache and provides sub-millisecond latency for entities that are in the cache.

- For __Redshift__ `best performance`
  * Specify sort keys, distribution keys, and column encodings
  * Enable compression to reduce storage requirements, thereby reducing disk
  I/O, which improves query performance.

- Use __Redshift Spectrum__ for S3 data up to exabyte-scale.

- Use __Presto__ for weakly structured data. Presto can query information
at large scale from existing storage solutions and data lakes, such as Amazon S3

- __Amazon Athena__ is fully managed Presto service that can run queries on
your data lakes and integrates with data cataloging features of __Amazon Glue__

To optimize __Aurora__ performance, allocate enough RAM so that your working
set resides almost completely in memory.

- Use __Placement groups__ to enable applications participate in a low-latency
`20 GBps` network, within a `single AZ`, this is facilitated by
__Elastic Network Adapaters (ENA)__

- Use edge services like __CloudFront__, and __Route 53__ to reduce latency and
enable caching of content.

- To benefit from caching, ensure you configure cache control correctly for
both DNS and HTTP/HTTPS.

- Reduce network distance or jitter

  * __Latency-based routing (LBR)__ for Route 53, routes requests to the endpoint
  that provides the fastest experience based on actual performance measurements.
  * Use __AWS Direct Connect__  and __Amazon VPC endpoints__ (_data remains within the AWS network__)
  * Load Balancers
    - __Application Load Balancer__ - HTTP/S, more `advanced request routing`.
    - __Network Load Balancer__ - TCP, `extreme performance`, can handle volatile traffic

- For __Load testing__, you can
  * Reduce cost by using Spot Instances.
  * Reduce cost by using Regions that have lower costs.
  * Reduce time by parallelizing your load tests.

- Traditional load testing methods don't work well with CloudFront because it
distributes loads across geographically dispersed locations and within each edge
location. To perform load testing that accurately assesses CloudFront performance,
Amazon recommends that you do `all` of the following:

      * Send client requests from __multiple geographic regions__.

      * Configure your test so __each client makes an independent DNS request__;
      each client will then receive a different set of IP addresses from DNS.

      * For each client that is making requests, __spread your client requests across
      the set of IP addresses that are returned by DNS__, which ensures that the load
      is distributed across multiple servers in a CloudFront edge location.

Technique | Applies To | Use | Gains
----------|------------|-----|------
Caching | Read-heavy | Space (Memory) | Time
Partitioning or Sharding | Write-heavy | Size & Complexity | Time
Compression | Large data | Time | Space
Buffering | Many requests |Space & Time | Efficiency

- Platforms such as `Redis`, `Memcached`, or `Varnish` can be deployed on
Amazon EC2 to provide robust caching engines for your applications.

- Use __read replicas__ to replicate all changes to the master databases (not
available for Oracle or SQL Server).

  * Add additional indexes to the read replica,  where the database engine supports it.

  * For latency-sensitive workloads you should use the Multi-AZ feature to specify
  which Availability Zones the read replica should be in to reduce
  cross-Availability Zone traffic.

- Use __CloudFront__ for georgraphic level caching.

- CloudFront also works seamlessly with any non-AWS origin server, which
stores the original, definitive versions of your files.

- __Amazon RDS__ removes the operational overhead of running multiple instances,
but sharding will still introduce complexity to the application.
  * The application’s data access layer will need to be modified to have
  awareness of how data is split so that it can direct queries to the right
  instance. (You can use a proxy or routing mechanism to remove caching code
  from the application, or implement it in a data access layer.)
  *  Any schema changes will have to be performed across multiple database
  schemas,  so it is worth investing some effort to automate this process.

- __CloudFront__ supports compression at the edge.

- __Amazon Redshift__ uses compression with columnar data storage.

- Use non-network based solutions, like __AWS Snowball__ when transferring
large quantities of information into or out of the cloud.

- Use a buffer when you have a workload that generates significant write
load that doesn’t need to be processed immediately.

- __Amazon SQS__ provides a queue that allows a single consumer to read individual
messages.

  * Use __long polling__ to reduce the cost of retrieving messages. Long polling
  lets you retrieve messages from your Amazon SQS queue as soon as they become available.

  * SQS `at-least-once` delivery means that you can receive a message more than once.

  * For `exactly-once` processing, use __SQS first in/first out (FIFO)__ queues.

  * For long-running tasks you can extend the `visibility time-out`.

- __Amazon Kinesis__ provides a stream that allows many consumers to read
the same messages. It differs from Amazon SQS in that it allows multiple
consumers to read the same message at any one time.

  * Use Spot Instances to optimize the speed with which work items are consumed
  by more consumers

### References ###

- [Lexico.com - Definition of Performance](https://www.lexico.com/definition/performance)

- [Lexico.com - Definition of Efficiency](https://www.lexico.com/en/definition/efficiency)

- [Lexico.com - Definition of Efficient](https://www.lexico.com/en/definition/efficient)

- [AWS - 5 Pillars of Well Architected Framework]([pillar](https://aws.amazon.com/blogs/apn/the-5-pillars-of-the-aws-well-architected-framework/))

- [AWS - Performance Efficiency Pillar](https://wa.aws.amazon.com/wat.pillar.performance.en.html)

- [AWS Architecture - Performance Efficiency Pillar](https://d1.awsstatic.com/whitepapers/architecture/AWS-Performance-Efficiency-Pillar.pdf)

- [EC2 Instance Types - curated](/2020/02/07/AWS_EC2-Instance-Types_curated)

- [AWS EC2 User Guide - Instance Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html)

- [Amazon S3 - Optimizing Performance](https://docs.aws.amazon.com/AmazonS3/latest/dev/optimizing-performance.html)
