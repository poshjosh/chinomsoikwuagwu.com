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

### Business Applications ###

__Alexa for Business__
<br/>Enables organizations and employees to use Alexa to get more work done.

__Amazon WorkDocs__ `fully managed`, `documents`, `comments`
<br/>Secure enterprise storage and sharing service with strong administrative
controls and feedback capabilities that improve user productivity.

__Amazon WorkMail__ `managed`, `email & calender`
<br/>Secure, managed business email and calendar service with support for existing
desktop and mobile email client applications.

__Amazon Chime__ `video conferencing`, `chat`
<br/>Communications service you can use for online meetings, video conferencing,
calls, chat, and to share content, both inside and outside your organization.

### Compute ###

__Amazon Elastic Compute Cloud (Amazon EC2)__
<br/>Web service that provides secure, resizable compute capacity in the cloud.
It is designed to make webscale computing easier for developers.

__Amazon EC2 Auto Scaling__
<br/>Automatically add or remove EC2 instances according to conditions you
define.

__Amazon Elastic Container Registry (Amazon ECR)__ `fully-managed`, `docker registry`
<br/>Makes it easy for developers to store, manage, and deploy Docker container images.

Amazon Elastic Container Service (Amazon ECS) is a highly scalable, highperformance container orchestration service that supports Docker containers
and allows you to easily run and scale containerized applications on AWS.

Amazon Elastic Container Service for Kubernetes (Amazon EKS) makes it easy
to deploy, manage, and scale containerized applications using Kubernetes on
AWS.

__Amazon Lightsail__ `easily launch virtual private servers`
<br/>Designed to be the easiest way to launch and manage a
virtual private server with AWS. Lightsail plans include everything you need to
jumpstart your project – a virtual machine, SSD- based storage, data transfer,
DNS management, and a static IP address – for a low, predictable price.

__AWS Batch__ `batch computing jobs`
<br/>Enables developers, scientists, and engineers to easily and
efficiently run hundreds of thousands of batch computing jobs on AWS. AWS
Batch dynamically provisions the optimal quantity and type of compute
resources (e.g., CPU or memory-optimized instances) based on the volume and
specific resource requirements of the batch jobs submitted.

AWS Elastic Beanstalk is an easy-to-use service for deploying and scaling web
applications and services developed with Java, .NET, PHP, Node.js, Python,
Ruby, Go, and Docker on familiar servers such as Apache, Nginx, Passenger,
and Internet Information Services (IIS).

AWS Fargate is a compute engine for Amazon ECS that allows you to
run containers without having to manage servers or clusters.

AWS Lambda lets you run code without provisioning or managing servers. You
pay only for the compute time you consume—there is no charge when your
code is not running.

__The AWS Serverless Application Repository__
<br/>Quickly deploy code
samples, components, and complete applications for common use cases such
as web and mobile back-ends, event and data processing, logging, monitoring,
IoT, and more. Each application is packaged with an AWS Serverless
Application Model (SAM) template that defines the AWS resources used.

__AWS Outposts__
<br/>Bring native AWS services, infrastructure, and operating models
to virtually any data center, co-location space, or on-premises facility. You can
use the same APIs, the same tools, the same hardware, and the same
functionality across on-premises and the cloud to deliver a truly consistent
hybrid experience. Outposts can be used to support workloads that need to
remain on-premises due to low latency or local data processing needs.





__Amazon Timestream__ is a fast, scalable, fully managed time series database
service for IoT and operational applications that makes it easy to store and
analyze trillions of events per day at 1/10th the cost of relational databases.

__Amazon DocumentDB__ (with MongoDB compatibility) `fully managed`
<br/>Fast, scalable, highly available, and fully managed document database
service that supports MongoDB workloads.

### Desktop and App Streaming ###

__Amazon WorkSpaces__ `fully managed`, `desktop`
<br/>Cloud desktop service. You can use Amazon WorkSpaces to provision either Windows or Linux desktops in
just a few minutes and quickly scale to provide thousands of desktops to
workers across the globe.

__Amazon AppStream 2.0__ `fully managed`, `application streaming`
<br/>Application streaming service. You centrally manage your desktop applications on AppStream 2.0 and securely
deliver them to any computer.

### Developer Tools ###

__AWS CodeCommit__ `fully managed`, `git`
<br/>Fully-managed source control service that hosts secure
Git-based repositories.

CodeBuild

CodeDeploy

CodePipeline

__AWS CodeStar__
<br/>Enables you to quickly develop, build, and deploy applications
on AWS. AWS CodeStar provides a unified user interface, enabling you to
easily manage your software development activities in one place. With AWS
CodeStar, you can set up your entire continuous delivery toolchain in minutes,
allowing you to start releasing code faster.

__Amazon Corretto__ `Java Development Kit`
<br/>No-cost, multiplatform, production-ready distribution of the
Open Java Development Kit (OpenJDK). Corretto comes with long-term support
that will include performance enhancements and security fixes.

__AWS Cloud9__ `IDE`
<br/>Cloud-based integrated development environment (IDE)

__AWS X-Ray__ `monitor`, `distributed applications`
<br/>Helps developers analyze and debug distributed applications in
production or under development, such as those built using a microservices
architecture.

### Game Tech ###

__Amazon GameLift__ `managed`, `deploy game servers`
<br/>Managed service for deploying, operating, and scaling
dedicated game servers for session-based multiplayer games.

__Amazon Lumberyard__ `3D game engine`
<br/>Free, cross-platform, 3D game engine for you to
create the highest-quality games, connect your games to the vast compute and
storage of the AWS Cloud, and engage fans on Twitch.

### Internet of Things (IoT) ###

__AWS IoT Core__ `managed`
<br/>Cloud service that lets connected devices easily
and securely interact with cloud applications and other devices.

__Amazon FreeRTOS (a:FreeRTOS)__ `OS for microcontrollers`
<br/>Operating system for microcontrollers
that makes small, low-power edge devices easy to program, deploy, secure,
connect, and manage.

__AWS IoT Greengrass__
<br/>Seamlessly extends AWS to devices so they can act
locally on the data they generate, while still using the cloud for management,
analytics, and durable storage. With AWS IoT Greengrass, connected devices
can run AWS Lambda functions, execute predictions based on machine
learning models, keep device data in sync, and communicate with other devices
securely – even when not connected to the Internet.

__AWS IoT 1-Click__ `IoT`, `trigger Lambda`
<br/>ervice that enables simple devices to trigger AWS
Lambda functions that can execute an action.

__AWS IoT Analytics__ `fully-managed`
<br/?Service that makes it easy to run and
operationalize sophisticated analytics on massive volumes of IoT data

The AWS IoT Button is a programmable button based on the Amazon Dash
Button hardware. This simple Wi-Fi device is easy to configure, and it’s
designed for developers to get started with AWS IoT Core, AWS Lambda,
Amazon DynamoDB, Amazon SNS, and many other Amazon Web Services
without writing device-specific code.

AWS IoT Device Defender is a fully managed service that helps you secure
your fleet of IoT devices. AWS IoT Device Defender continuously audits your
IoT configurations to make sure that they aren’t deviating from security best
practices.


### Machine Learning###

__Amazon SageMaker__ `fully-managed`, `machine learning`
<br/>Machine learning platform that enables developers and
data scientists to quickly and easily build, train, and deploy machine learning
models at any scale.

__Amazon Comprehend__ `natural language processing (NLP)`
<br/>Natural language processing (NLP) service that uses
machine learning to find insights and relationships in text. No machine learning
experience required.

__Amazon Lex__ `speech to text`
<br/>Service for building conversational interfaces into any
application using voice and text. Lex provides the advanced deep learning
functionalities of automatic speech recognition (ASR) for converting speech to
text, and natural language understanding (NLU) to recognize the intent of the
text.

__Amazon Polly__ `text to speech`
<br/>Service that turns text into lifelike speech. Polly lets you
create applications that talk

__Amazon Rekognition__ `image analysis`
<br/>A service that makes it easy to add image analysis to
your applications. With Rekognition, you can detect objects, scenes, and faces
in images.

__Amazon Translate__ `language text translation`
<br/>Neural machine translation service that delivers fast,
high-quality, and affordable language translation.

__Amazon Transcribe__ `speech to text`, `development`
<br/>Automatic speech recognition (ASR) service that
makes it easy for developers to add speech-to-text capability to their
applications.

Amazon Elastic Inference allows you to attach low-cost GPU-powered
acceleration to Amazon EC2 and Amazon SageMaker instances to reduce the
cost of running deep learning inference by up to 75%. Amazon Elastic Inference
supports TensorFlow, Apache MXNet, and ONNX models, with more
frameworks coming soon.

__Amazon Forecast__ `fully managed`, `prediction`
<br/>Fully managed service that uses machine learning to
deliver highly accurate forecasts.

__Amazon Textract__ `optical character recognition`
<br/>Service that automatically extracts text and data from
scanned documents. Amazon Textract goes beyond simple optical character
recognition (OCR) to also identify the contents of fields in forms and information
stored in tables

Amazon Personalize is a machine learning service that makes it easy for
developers to create individualized `recommendations` for customers using their
applications.

### References ###

- [AWS Overview Whitepaper](https://d1.awsstatic.com/whitepapers/aws-overview.pdf)

- [Parkmycloud.com - AWS Services List](https://www.parkmycloud.com/aws-services-list/)

- [](https://www.techradar.com/news/aws)
