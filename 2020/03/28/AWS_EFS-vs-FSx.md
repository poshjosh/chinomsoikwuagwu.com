---
path: "./2020/03/28/AWS_EFS-vs-FSx.md"
date: "2020-03-28T23:32:39"
title: "AWS EFS vs FSx"
description: "Differences between Amazon EFS vs FSx + when and why to use"
tags: ["AWS", "Elastic File System (EFS)", "Amazon FSx", "lustre", "windows file server", "Server Message Block (SMB)", "New Technology File System (NTFS)"]
lang: "en-us"
---

### Introduction ###

Both Amazon EFS and FSx are well suited to support a broad spectrum of use
cases from home directories to business-critical applications. Customers can
also use both file systems to lift-and-shift existing enterprise applications
to the AWS Cloud. Other use cases include: big data analytics, web serving and
content management as well as media workflows.

Notwithstanding these similarities, there are subtle differences between both
services. However, before exorcising the differences, lets invoke each
file system.

### Amazon Elastic File System (EFS) ###

__Amazon Elastic File System (Amazon EFS)__ provides a simple, scalable, fully
managed elastic NFS file system for use with AWS Cloud services and on-premises
resources.

- Auto scales on demand, even to petabytes.
- provide massively parallel shared access to thousands of Amazon EC2 instances.
- Data is stored within and across multiple Availability Zones (AZs) for high
availability and durability
- Offers two storage classes:
  * `Standard (EFS Standard)`.
  * `Infrequent Access (EFS IA)`.
- Amazon EFS transparently serves files from both storage classes in a common
file system namespace.

>EFS IA provides price/performance that's cost-optimized for files not accessed
every day. By simply enabling EFS Lifecycle Management on your file system,
files not accessed according to the lifecycle policy you choose will be
automatically and transparently moved into EFS IA. The EFS IA storage class
costs only $0.025/GB-month*.

_*pricing in US East (N. Virginia) region, assumes 80% of your storage in EFS IA_

### EFS Use Cases ###

- __Move to managed file systems__  - Move your business critical, Linux-based
applications to managed file systems with Amazon EFS.

- __Analytics & machine learning__ - For example Data scientists can use EFS to
create personalized environments, with home directories storing notebook files,
training data, and model artifacts. Amazon SageMaker integrates with EFS for
training jobs.

- __Web serving & content management__ - Since Amazon EFS adheres to the expected
file system directory structure, file naming conventions, and permissions that
web developers are accustomed to, it can easily integrate with web applications.

- __Application testing & development__ - For example, you can provision,
duplicate, scale, or archive your test, development, and production
environments with a few clicks.

- __Media & entertainment__ - Media workflows like video editing, studio production,
broadcast processing, sound design, and rendering often depend on shared storage
to manipulate large files.

- __Database backups__ - Amazon EFS presents a standard file system that can be
easily mounted with NFSv4 from database servers. This provides an ideal platform
to create portable database backups using native application tools or enterprise
backup applications.

- __Container storage__ - Amazon EFS is ideal for container storage providing
persistent shared access to a common file repository.

### Amazon FXs ###

>Amazon FSx makes it easy and cost effective to launch and run popular file systems. With Amazon FSx, you can leverage the rich feature sets and fast performance of widely-used open source and commercially-licensed file systems, while avoiding time-consuming administrative tasks like hardware provisioning, software configuration, patching, and backups. It provides cost-efficient capacity and high levels of reliability, and it integrates with other AWS services so that you can manage and use the file systems in cloud-native ways.

Two variants:

1. [Amazon FSx for Windows File Server](https://aws.amazon.com/fsx/windows/) for business applications

__Amazon FSx for Windows File Server__ is a fully managed file storage that is
accessible over the industry-standard Server Message Block (SMB) protocol. It
is built on Windows Server, delivering a wide range of administrative features
such as user quotas, end-user file restore, and Microsoft Active Directory (AD)
integration. It offers single-AZ and multi-AZ deployment options, fully managed
backups, and encryption of data at rest and in transit. Amazon FSx file storage
is accessible from Windows, Linux, and MacOS compute instances and devices
running on AWS or on premises. You can optimize cost and performance for your
workload needs with SSD and HDD storage options. Amazon FSx helps you lower TCO
with data deduplication.

2. [Amazon FSx for Lustre](https://aws.amazon.com/fsx/lustre/) for high-performance workloads.

__Amazon FSx Lustre__ is a fully managed service designed for workloads where
speed matters, such as machine learning, high performance computing (HPC),
video processing, and financial modeling.

The open source Lustre file system is designed for applications that require
fast storage – where you want your storage to keep up with your compute.
Lustre was built to quickly and cost effectively process the fastest-growing
data sets in the world, and it’s the most widely used file system for the 500
fastest computers in the world. It provides sub-millisecond latencies, up to
hundreds of gigabytes per second of throughput, and millions of IOPS.

### FSx Use Cases ###

1. [Amazon FSx for Windows File Server](https://aws.amazon.com/fsx/windows/) for business applications

   - __Home directories__. Use FSx to create file system shared between hundreds or
   thousands of users.

   - __Applications which require shared file storage provided by Windows-based
   file systems (NTFS) and use the SMB protocol__.

   - __Highly available Microsoft SQL Server deployments__.
   >SQL Server Failover Cluster Instances have been traditionally difficult to deploy and manage. With the multi-AZ file system option, Amazon FSx provides fully managed file storage that enables the high availability and durability that is required to run business-critical Microsoft SQL Server database workloads _without the need for Enterprise licenses_. Amazon FSx automatically handles the data replication and failover, simplifying shared storage to host your database deployments while reducing cost.

   - __Applications which require shared file systems__.

     * Media workflows like media transcoding, processing, and streaming
     * Content management and web serving applications, like Microsoft Internet
     Information Services (IIS) and WordPress.
     * Data analytics applications.

2. [Amazon FSx for Lustre](https://aws.amazon.com/fsx/lustre/) for high-performance workloads.

   - __Machine Learning__

   - __High Performance Computing__

   - __Media Processing and Transcoding__

   - __Autonomous Vehicles__

   - __Big data and financial analytics__

   - __Electronic Design Automation__

### Differences between EFS and FSx ###

__Generally__

Property   |      EFS           | FSx
-----------|--------------------|------------------------------------
File Sys   | NFSv4              | SMB server with NTFS based storage
Latency    | Low latency        | Sub-millisecond latencies
Throughput | 10 GB/sec          | Up to hundreds GB/sec
IOPs       | greater than 500k  | Millions

When AWS rolled out FSx in late 2018, some industry observers thought it was
positioned to eventually replace EFS in the AWS portfolio. That may not be the
case.

It is also noteworthy that FSx was rolled out in response  to AWS customers
who didn't want to do all the heavy lifting required for windows file system
and windows file servers on their own. [1](#siliconangle-q-and-a)

__EFS uses NFS__, one of the first network file sharing protocols native to Unix and Linux. Windows has long provided an NFS client and server. Some Windows applications might not work on EFS or be feature-complete without access to a native Windows SMB file share. Indeed, the 2012 Windows Server update and later implementations of SMB include end-to-end data encryption, remote direct memory access support, VSS snapshot backups, support for Windows New Technology File System (NTFS) metadata and Active Directory (AD) security policies. These features might not be available on most NFS implementations, including EFS.

__FSx for windows runs the integrated SMB server__ built into the OS with storage built on NTFS and supports AD users, access control lists, groups and security policies, along with Distributed File System (DFS) namespaces and replication. These features enable FSx to support multi-AZ deployments using Microsoft's DFS, along with the ability to synchronize file shares in different AZs and configure automatic failovers. FSx supports other Windows security features, such as data encryption at rest and in transit, along with Amazon security services, such as network traffic control using Amazon Virtual Private Cloud security groups and user access policies with Identity and Access Management. FSx for Windows can log system events and API calls to CloudTrail for later auditing and analysis.

__In conclusion__, You can use EFS and FSx interchangeably for most applications
that support network file shares. But EFS is better for applications designed for
heterogeneous environments and those that run on Linux systems. On the other
hand, FSx for windows is particularly suited to applications that require file
storage provided by Windows-based file systems (NTFS) and use the SMB protocol.
Finally, if you need either of the improved latency, throughput or IOPs provided
by FSx over EFS, then you know what to do.

### References ###

- [Amazon EFS](https://aws.amazon.com/efs/)
- [Amazon FSx](https://aws.amazon.com/fsx/)
- [Amazon FSx for Windows File Server](https://aws.amazon.com/fsx/windows/)
- [Amazon FSx for Lustre](https://aws.amazon.com/fsx/lustre/)
- <a name="siliconangle-q-and-a">1</a>. [Siliconangle.com - Q and A on FSx Windows](https://siliconangle.com/2019/12/02/qa-new-fsx-windows-features-simplify-windows-file-server-management-aws-cloud-awsstorageday/)
