---
path: "./2020/05/29/AWS-Services-List.md"
date: "2020-05-29T20:31:08"
title: "Summary of AWS Services"
description: "Summary of each AWS Service to help you get acquainted"
tags: ["AWS"]
lang: "en-us"
---

- ETL - Extract Transform Load
- EC2 - Elastic Cloud Compute
- EMR - Elastic MapReduce
- IAM - Identity and Access Management
- KMS - Key Management Service
- ML - Machine Learning
- RDS - Relational Database Service
- RI - Reserved Instance
- S3 - Simple Storage Service
- SQL - Structured Query Language
- VPC - Virtual Private Cloud

### Analytics ###

__Amazon Athena__ - `serverless`, `query S3`
<br/>Interactive query service to analyze data in Amazon S3 using standard SQL.

- No need for complex ETL jobs to prepare your data for analysis
- Integrates with AWS GlueData Catalog, allowing you to create a unified
metadata repository across various services

__Amazon EMR__ `managed service`, `hadoop framework`, `big data`
<br/>Provides a managed Hadoop framework to process vast amounts of data across
dynamically scalable Amazon EC2 instances. Supports: Apache Spark, HBase, Presto, and Flink.

_Use cases: log analysis, web indexing, ETL, machine learning, financial analysis,
scientific simulation, and bioinformatics_.

__Amazon CloudSearch__ `managed service`, `search`
<br/>Managed service to set up, manage, and scale a search solution for your website or application.
Supported: 34 languages, highlighting, autocomplete and geospatial search.

__Amazon Elasticsearch Service__ `elasticsearch`
<br/>Deploy, secure, operate, and scale Elasticsearch to search, analyze, and visualize data in real-time.

- Offers integrations with open-source tools like Kibana and Logstash
- Integrates with VPC, KMS, Firehose, Lamda, IAM, Cognito, CloudWatch etc

_Use cases: log analytics, full-text search, application monitoring, and clickstream analytics_  

__Amazon Kinesis__ `real-time streaming data analysis`
<br/>Collect, process, and analyze real-time streaming data.

_Use cases: Ingest real-time data such as video, audio, application logs, website
clickstreams, and IoT telemetry data for machine learning, analytics, and other applications_.

Kinesis Data Firehose, Kinesis Data Analytics, Kinesis Data Streams, and Kinesis Video Streams

- __Amazon Kinesis Data Firehose__ `managed service`, `ETL service`
<br/>Reliably load streaming data into data stores and analytics tools.

  * Capture, transform, and load streaming data into Amazon S3, Amazon Redshift, Amazon Elasticsearch Service, and Splunk
  * Transformations: Batch, compress, transform, encrypt or convert to columnar formats like Apache Parquet and Apache ORC

- __Amazon Kinesis Data Analytics__ `managed service`, `streaming data analysis`

  * Analyze streaming data
  * SQL queries on streaming data

- __Amazon Kinesis Data Streams (KDS)__ `managed service`, `real-time streaming data analysis`
<br/>Continuously capture data GB/s from hundreds of thousands of sources.

  _Use cases: real-time dashboards, real-time anomaly detection, dynamic pricing, and more_.

- __Amazon Kinesis Video Streams__ `managed service`, `video streaming`
  Securely stream video from millions of connected devices to AWS for analytics, machine learning (ML), playback, and other processing.

  * Stores, encrypts, and indexes video data in your streams
  * Playback for live and on-demand viewing
  * Integrates with Amazon Recognition Video, libraries for ML frameworks such
  as Apache MxNet, TensorFlow, and OpenCV

  _Use cases: applications that take advantage of video streaming, computer vision, video analytics_

__Amazon Redshift__ `data warehouse`
<br/>Data warehouse to analyze all your data across your data warehouse and data lake.

- Run queries across petabytes of data in Redshift data warehouse, and exabytes of data in Amazon S3 data lake.

__Amazon QuickSight__ `managed service`, `business intelligence`, `interactive dashboard`
<br/>Business intelligence (BI) service  to create and publish interactive
dashboards accessible from browsers and mobile devices.

- Embed dashboards into your applications.

__AWS Data Pipeline__ `managed service`, `data processing`
<br/>Reliably process and move data between different AWS compute and storage
services, as well as on-premises data sources, at specified intervals.

- Create complex data processing workloads
- Supported services include: S3, RDS, DynamoDB, EMR
- Move and process data that was previously locked up in on-premises data silos.

__AWS Glue__ `fully managed service`, `extract, transform, load`
<br/>ETL service to prepare and load their data for analytics.

- Point Glue to your data stored on AWS, Glue discovers your data and stores
associated metadata (e.g. table definition and schema) in the AWS Glue Data Catalog which is immediately searchable, queryable, and available for ETL.

__AWS Lake Formation__ `managed service`, `data lake`
<br/>Set up a secure data lake in days.

- Collects and catalogs data from databases and object storage, moves the data
into your new Amazon S3 data lake, cleans and classifies data using machine
learning algorithms, and secures access to your sensitive data.
- A data lake is a centralized, curated, and secured repository that stores
all your data, both in its original form and prepared for analysis.

__Amazon Managed Streaming for Kafka (MSK)__ `fully managed service`, `apache kafka`
<br/>Build and run applications that use Apache Kafka to process streaming data.

- Automatically provisions and runs your Apache Kafka clusters
- Secures your Apache Kafka cluster by encrypting data at rest
- Apache Kafka is an open-source platform for building real-time streaming data
pipelines and applications.

_Use cases: Use Apache Kafka APIs to populate data lakes, stream changes to
and from databases, and power machine learning and analytics applications_.

### Application Integration ###

__AWS Step Functions__ `serverless`, `workflow`
<br/>Coordinate multiple AWS services into serverless workflows so you can build
and update apps quickly.

  - Design and run workflows that stitch together services such as AWS Lambda
  and Amazon ECS into feature-rich applications.

__Amazon MQ__ `manages service`, `message broker`, `apache activemq`
<br/>For Apache ActiveMQ. Makes it easy to set up and operate message brokers in the cloud.

  - Uses industry-standard APIs and protocols for messaging, including JMS, NMS,
  AMQP, STOMP, MQTT, and WebSocket.

  - Message brokers allow different software systems–often using different
  programming languages, and on different platforms–to communicate and exchange
  information.

__Amazon Amazon Simple Queue Service (Amazon SQS)__ `fully managed`, `message queue`
<br/>Message queuing service that enables you to decouple and scale microservices,
distributed systems, and serverless applications.

- __Standard queue__ - Maximum throughput, best-effort ordering, and at-least-once delivery.
- __SQS FIFO queue__ - designed for exactly once delivery, in the exact order messages are sent.

__Amazon Simple Notification Service (Amazon SNS)__ `fully managed`, `pub/sub messaging`
<br/>Pub/sub messaging service that enables you to decouple microservices,
distributed systems, and serverless applications.

  - high-throughput, push-based, many-to-many messaging
  - Supported subscriber endpoints: Amazon SQS queues, AWS Lambda functions, and HTTP/S webhooks.
  - Supported message types: mobile push, SMS, and email.

__Amazon Simple Workflow (Amazon SWF)__ `fully managed`, `workflow`, `state tracker`
<br/>Build, run, and scale background jobs that have parallel or sequential steps.

If your application’s steps take more than 500 milliseconds to complete, you
need to track the state of processing. If you need to recover or retry if a
task fails, Amazon SWF can help you.

### AR and VR ###

__Amazon Sumerian__ `virtual reality`, `augmented reality`, `3D`
<br/>Create and run virtual reality (VR), augmented reality (AR), and 3D applications.

- Build highly immersive and interactive scenes.
- Supported hardware include: Oculus Go, Oculus Rift, HTC Vive, HTC Vive Pro,
Google Daydream, and Lenovo Mirage as well as Android and iOS mobile devices.

_Use cases: virtual classroom, virtual tours, interactive 3D applications, designing, animating__

### AWS Cost Management ###

__AWS Cost Explorer__ `cost report`
<br/>Visualize, understand, and manage your AWS costs and usage over time.

_Use cases: Create custom reports (including charts and tabular data) to analyze cost and
usage data, both at a high level (e.g., total costs and usage across all accounts)
and for highly-specific requests (e.g., m2.2xlarge costs within account Y that are tagged “project: secretProject”)_.

__AWS Budgets__ `budget alert`
<br/>Set custom budgets that alert you when your costs or usage exceed (or are forecasted to exceed) your budgeted amount.

- Track budgets monthly, quarterly, or yearly as well as customized the start and end dates.
- Alerts via email and/or Amazon Simple Notification Service (SNS) topic
- Set RI utilization or coverage targets for EC2, RDS, Redshift, and ElastiCache reservations

__AWS Cost & Usage Report__ `cost report`
<br/>Single location for accessing comprehensive information about your AWS costs and usage.

_Use case: List AWS usage for each service category used by an account and its IAM users in hourly or daily line items_.

__Reserved Instance (RI) Reporting__

- AWS Cost Explorer, RI utilization report - visualize aggregate or particular RI data.
- AWS Cost & Usage Report - Most detailed RI info available.
- AWS Budgets - Set custom RI utilization target, receive alerts when utilization drops below

### Blockchain ###

__Amazon Managed Blockchain__ `fully managed`
<br/>Create and manage scalable blockchain networks using the popular open source frameworks Hyperledger Fabric and Ethereum.

Blockchain makes it possible to build applications where multiple parties can execute transactions without the need for a trusted, central authority. Today, building a scalable blockchain network with existing technologies is complex to set up and hard to manage. To create a blockchain network, each network member needs to manually provision hardware, install software, create and manage certificates for access control, and configure networking components. Once the blockchain network is running, you need to continuously monitor the infrastructure and adapt to changes, such as an increase in transaction requests, or new members joining or leaving the network.AmazonManaged Blockchain is a fully managed service that allows you to set up and manage a scalable blockchain network with just a few clicks. Amazon Managed Blockchain eliminates the overhead required to create the network, and automatically scales to meet thedemands of thousands of applications running millions of transactions. Once your network is up and running, Managed Blockchain makes it easy to manage and maintain your blockchain network. It manages your certificates, lets you easily invite new members to join the network, and tracks operational metrics such as usage of compute, memory, and storage resources. In addition, Managed Blockchain can replicate an immutable copy of your blockchain network activity into Amazon Quantum Ledger Database (QLDB), a fully managed ledger database. This allows you to easily analyze the network activity outside the network and gain insights into trends.

### References ###

- [AWS Overview Whitepaper](https://d1.awsstatic.com/whitepapers/aws-overview.pdf)

- [Parkmycloud.com - AWS Services List](https://www.parkmycloud.com/aws-services-list/)

- [](https://www.techradar.com/news/aws)
