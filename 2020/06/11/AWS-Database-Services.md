---
path: "./2020/06/11/AWS-Database-Services.md"
date: "2020-06-11T18:43:00"
title: "AWS Database Services"
description: "AWS Database Services"
tags: ["AWS", "Database Services", "Amazon Aurora", "Amazon Relational Database Service (RDS)", "Amazon RDS on VMware", "Amazon DynamoDB", "Amazon ElastiCache", "ElastiCache for Redis", "ElastiCache for Memcached", "Amazon Neptune", "Amazon Quantum Ledger Database (QLDB)", "Amazon Timestream", "Amazon DocumentDB"]
lang: "en-us"
---

__Amazon Aurora__

Amazon Aurora is a MySQL and PostgreSQL compatible relational database engine

- Distributed, fault-tolerant, self-healing storage system
- Auto-scales up to 64TB per database instance.
- Up to 15 low-latency read replicas
- Point-in-time recovery
- Continuous backup to Amazon S3
- Replication across three Availability Zones (AZs).

__Amazon Relational Database Service (Amazon RDS)__

Amazon Relational Database Service (Amazon RDS) makes it easy to set up, operate,
and scale a relational database in the cloud.

- Provides cost-efficient and resizable capacity
- Automates time-consuming administration tasks such as: hardware provisioning,
database setup, patching and backups.
- Six engines: `Amazon Aurora`, `PostgreSQL`, `MySQL`, `MariaDB`,
`Oracle Database`, and `SQL Server`.

__Amazon RDS on VMware__

Amazon Relational Database Service (Amazon RDS)
on VMware lets you deploy managed databases in on-premises VMware environments using the Amazon RDS technology

Achieve __low cost hybrid__ by replicating RDS on VMware databases to RDS instances
in AWS. This could be used for `disaster recovery`, `read replica bursting`, and
optional `long-term backup` retention in Amazon S3.

__Amazon DynamoDB__

Amazon DynamoDB is a `fully managed` key-value and document database that can
handle more than 10 trillion requests per day and support peaks of more than
20 million requests per second. DynamoDB delivers:

- Single-digit millisecond performance at any scale.
- Multiregion, multimaster database  
- Built-in security, backup and restore
- In-memory caching for internet-scale applications.

_Use cases: mobile, web, gaming, ad tech, IoT, and other applications that
need low-latency data access at any scale_

__Amazon ElastiCache__

Amazon ElastiCache is a web service that makes it easy to deploy, operate,
and scale an in-memory cache in the cloud.

Supports two open-source in-memory caching engines:

- __Amazon ElastiCache for Redis__ is a `Redis`-compatible `fully managed` in-memory service

 - Both single-node and up to 15-shard clusters are available
 - Scalability to up to 3.55 TiB of in-memory data.
 - Scalable, and secure.

 _Use cases: high-performance use cases such as web, mobile apps, gaming, ad-tech, and IoT._

- __ElastiCache for Memcached__ is protocol compliant with `Memcached`, so
popular tools that you use today with existing Memcached environments will work
seamlessly with the service.

__Amazon Neptune__

Amazon Neptune is a fast, reliable, `fully managed` graph database service that
makes it easy to build and run applications that work with highly connected datasets.

- Read replicas, point-in-time recovery,
- Continuous backup to Amazon S3
- Replication across Availability Zones.
- Support for encryption at rest.
- Supports popular graph models `Property Graph` and W3C's `RDF`, and their
respective query languages `Apache TinkerPop Gremlin` and `SPARQL`

_Use cases: recommendation engines, fraud detection, knowledge graphs, drug
discovery, and network security._

__Amazon Quantum Ledger Database (QLDB)__

Amazon QLDB is a `fully managed` ledger database that provides a transparent,
immutable, and cryptographically verifiable transaction log ‎owned by a central
trusted authority. Amazon QLDB tracks each and every application data change
and maintains a complete and verifiable history of changes over time.

- Provides developers with a familiar SQL-like API
- Flexible document data model
- Full support for transactions.
- Automatically scales to support the demands of your application.

__Amazon Timestream__

Amazon Timestream is a fast, scalable, fully managed time series database
service for IoT and operational applications that makes it easy to store and
analyze trillions of events per day at 1/10th the cost of relational databases

Automates rollups, retention, tiering, and compression of data, so you can
manage your data at the lowest possible cost.

_Use cases: analyze log data for DevOps, sensor data for IoT applications,
and industrial telemetry data for equipment maintenance._

__Amazon DocumentDB__

Amazon DocumentDB (with MongoDB compatibility) is a fast, scalable, highly
available, and `fully managed` document database service that `supports MongoDB workloads`.

Use your existing MongoDB drivers and tools with Amazon DocumentDB.

_Use case: operating mission-critical MongoDB workloads at scale._
