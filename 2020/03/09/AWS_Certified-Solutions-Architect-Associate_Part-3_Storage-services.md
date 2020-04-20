---
path: "./2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-3_Storage-services.md"
date: "2020-03-09"
title: "AWS Certified Solutions Architect Associate - Part 3 - Storage services"
description: "Poshjoshs-Blog - AWS Certified Solutions Architect Associate - Part 3 - Storage services"
lang: "en-us"
---

### Storage Services ###

- Simple Storage Service (Object level access)

- Glacier - For archive data

- CloudFront - Data accessed frequently is cached at an edge location

- Elastic Block Store - Very fast access (block level access)

- Storage Gateway - An appliance you put on your local network that acts as a VPN connection into the amazon clould so you can access your storage as if its local storage.

- Snow Family - A collection of primary products used to migrate large amounts of data from local data stores into the cloud.

- Databases

### Characteristics of Storage ###

- Block Storage

  * Block Storage is used on local networks. Accessing the data in a similar way to local hard drives. e.g iSCSI, Fibre channel.

  * AWS can use block storage with virtual machines within the AWS cloud using EBS.

- File Storage.

  * Here we are dealing with objects, or chunks of information.

  * AWS uses similar called object storage in S3

  * Used in Network Attached Storage (NAS) devices locally.

### Selecting Storage ###

- Size. How big are the objects and how much total storage is needed

- Performance. Speed of access (EBS gives better performance for instances) but don't forget cost.. which becomes obvious for large amounts of data.

- Cost

### Simple Storage Service (S3) ###

- Object Storage. S3 is about object storage. The object could be a file or any chunk of data.

- High availability. Automatically distributed accross at least 3 availability zones (AZ) by default. (Class 1A = 1 AZ, least expensive)

- Encryption

- Automatic data classification

- Big data analytics could be done directly against the data stored in an S3 bucket. This means you don't have to put it in a database first.

#### Getting Data into S3 ####

- Use AWS APIs. API calls from your applications

- Amazon Direct Connect. A VPN from enterprise/business network to AWS

- Storage Gateway. With storage gateway, in addition to VPN connection, there could also be data stored locally and synchronized/replicated into the S3.

- Kinesis Firehose. A way to get a large amount of analytical data into the S3 bucket.

- Transfer Acceleration. Works based on CloudFront tech. Optimized route using edge location for uploading data to S3 bucket... Costs more.

- Snow Family. These are actual physical hardware.

  * Snowball. Petabyte scale.

  * Snowball Edge. 100 TB local storage. Bring the device into your facility and it has ability to run instances on itself. The device gets sent back to AWS for transfer to the cloud.

  * Snowmobile. Exabytes of data. A large trailer, each of which can store 100 petabytes of info. AWS staff come with the trailer and help with setup.

#### S3 Features ####

- Prefixes and Delimiters

S3 doesn't actually have folder hierarchy. Organization and identification   is achieved by prefixes and delimiters. With prefixes and delimiters give   the impression of folders.

- S3 Storage Classes. From most expensive at the top to least expensive.

  * Amazon S3 Standard
  * Amazon S3 Infrequent Access (IA)
  * Amazon S3 Reduced Redundancy Storage (RRS)
  * Amazon S3 Glacier

Though glacier is the least expensive, if accessed frequently then the price shoots up due to the access charge.

- Object Lifecycle Management

The standard is to add info to S3 Standard, migrate to S3 IA after some months and further move the data to Glacier after some months.

- Encryption

Server side and Client side.

  * Server side. AWS does the 256 bit encryption on the server. Note it is   storage security not transit security.

  * Client side. You encrypt the file before uploading to S3.

- Versioning

Maintains multiple versions of objects. Turned off by default. Once you enable it, you can't disable it. But you can suspend it so that new versions are no longer created.

- Multi-Factor Authentication (MFA) Delete

- Multi-part upload. Giga bytes of data upload in parts

- Range GETs. E.g get the range from 10kb to 20kb.

- Cross region Replication. Replicate data accross S3 buckets in different regions. When enabled it doesn't replicate existing data but newly added data.

- Logging. Log addition, deletion, changes etc

- Event Notifications

Enabling Encryption (Server side encryption) Encryption Options are:

- AES Option - Managed by Amazon. Easier.
- KMS Option - Managed by you. More Flexible. You have the ability to archive or restore your key.

Permissions

- Bucket level permission
- Object level permission. Will override bucket level per object.

Manage Lifecycle

Tags or prefixes could be used to apply rules to a group of objects in a bucket.

- Storage class Transiton

  * To IA after 30 days
  * To Glacier after 90 days
  * You could also set for deletion after a set amount of time (It is advisable to have a backup)

Bucket Policy

- JSON policies could be done, but we have visual editors to help build JSON policies

- CORs - Cross Origin Resource sharing for web apps

- Others Management, Analytics, Metrics, Inventory

Adding objects

- Object duration is specified at creation time.

- Minimum size of an s3 bucket object is 0 bytes. You can add a zero byte file.

#### S3 Terminology ####

- Regions.
- Buckets.
- Objects.
- Keys. Objects have keys, like filenames for files
- Object URLs
- Eventual consistency. S3 objects have eventual consistency while Elastic Block Store (EBS) objects are consistent. Eventual consistency means there is a lag between when the operation is carried out on one location (originating location) and when the new state becomes consistent with redundant locations.

#### Common S3 Operations ####

- Creating and deleting buckets
- Write, read, delete objects
- Manage object properties
- List keys in buckets

#### REST Interface ####

Representational State Transfer (REST) uses HTTP methods.

- Create - HTTP PUT or POST
- Read - HTTP GET
- Update - HTTP POST or PUT
- Delete - HTTP DELETE

### Glacier ###

- Glacier is for achiving data

- You could automatially provision for a glacier by adding a lifecycle rule to a bucket e.g move to glacier after 90 days

- If you want to manually put stuff in Glacier, you have to create your own vault.

  * Management Console -> Glaciers -> Create vault

  * You could enable notifications and create an SNS topic or use existing SNS topic. A topic is just that a topic... used to identify a queue e.g football, marketing etc

  * A topic has an Amazon Resource Name (ARN)

  * You may set permissions for a Vault. (You could use tags like in buckets)

  * You could use your vault with your storage gateway, if you have implemented one.

  * Settings

#### Q and A ####

- What is the maximum number of vaults an AWS account can create in a region?

  * 1000

- What is the expected recovery window for a Glacier restore with standard access?

  * 3 - 5 hours

### Elastic Block Store (EBS) ###

- Each instance uses EBS. EBS used for durable/persistent storage in the instance.

- EBS is block level storage from one AWS service to another

- EBS Volume Types:

  * Magnetic, slowest, cheapest
    . Standard (54 rpm like in computer hard drive)
    . Throughput optimized (10k rpm +)
  * SSD
    . General Purpose
    . Provisioned IOPS

- Generally
  * Cold Hard Disk Drive - (Really large and really slow)
  * Throughput Optimized - (Potentially large, really fast) e.g 10000+ rpm
  * Magnetic Standard - (Middle of the road) like a typical 5400rmp hard drive found in local computers
  * If you use SSD, to take advantage of the additional performance, you need and EBS optimzed instance.
  * EBS volume type: Magnetic Standard SSD is free tier.

Protecting EBS Data

- Snapshots.
  * Take a snapshot, then restore to that point in time later.
  * Take a snapshot, create another EBS volume from the snapshot. Create an instance and used the newly created EBS volume.

- Volume recovery
  * Attach volumes from one instance to another.

- Encryption methods

#### Creating EBS Volumes ####

Note: No link to EBS volumes under storages in AWS Services. EBS links are under EC2.

Management Console -> Compute -> EC2 -> Volumes -> Create Volume

- Range: 1 gigabyte - 1 terrabyte (1024 gigabytes)
- You want your EBS to be in the AZ that your instance is.
- Encrypt volume uses ASW EBS master key by default

After creating volume

Browse to: Actions -> Attach to instance

or

During instance creation attach the newly created EBS volume.

#### EBS Volume Types ####

![EBS Volume Types](https://secureservercdn.net/160.153.138.177/3d9.249.myftpupload.com/wp-content/uploads/2016/03/EBS_Volume_Types.png "EBS Volume Types")

### Elastic File System ###

- EFS is different from other storage because it is sharable. This means that multiple devices can access it at the same time.
- EFS is heirarchichal in nature, unlike S3 which uses prefix and delimiters
- EFS can be accessed through NFSv4 (Network File System version 4)
- EFS could be used by EC2 instances
- EFS not supported on windows instances
  For windows, create an EBS volume and use shared folders from the windows instance itself.

Comparison      | Type                            | EFS                    	| S3                  		| EBS
-------------------------------------------------------------------------------------------------------------------------------------------------------
Performance     | Per ops			  | low, consistent		| low for mixed req & CloudFront| lowest, consistent 	
                | Thoughput scale		  | Multiple Gigabytes/sec	| Multiple Gigabytes/sec	| Single Gigabytes/sec
Characteristics | Data Availability & Durability  | Multiple AZ redundancy	| Multiple AZ redundancy        | Single AZ & hardware based redundancy
                | Access			  | Thousands from multiple AZs	| Millions over the web		| Single EC2 in single AZ
                | Use cases			  | Web serving, content mgt,   | Web serv(static), content mgt,| Boot volumes, transactional & NoSQL
                | 				  | enterprise apps, media &    | media & entertainment, backups| db, data warehouse & ETL
                |                                 | entertainment, home dirs, db| big data analytics, data lake |
                |                                 | backup, dev tools, container|				|
                |				  | storage, big data analysis	|				|
--------------------------------------------------------------------------------------------------------------------------------------------------------

#### Create EFS File System ####

- Management Console -> Storage -> EFS -> Create EFS File System
  * Select VPC
  * Performance Mode
    . General Purpose
    . Max IO - Good to use when large number of access.
  * Throughput mode:
    . Bursting - Increase or decrease with demand.
    . Provisioned - fixed at a certain amount.

### Integrating Cloud with On-premises Storage ###

Storage Gateway - Software appliance that creates a gateway on the customers location. Storage gateway provides 3 types of storage solutions

- File based (uses NFS, unlike EFS it supports windows systems)
- Volume based (iSCSI protocol i.e SCSI over internet protocol)  
- Tape based

File gateway provides interface to S3 buckets.

Must Read

AWS Storage Gateway -> Planning your storage gateway deployment

### Storage Access Security ###

- Browse to: Management Console -> S3
- Click on an existing S3 bucket -> Permissions

To add permissions you need the person's email address or canonical id. Some users a created using only username. Also getting their canonical id may not be immediate. For this reason most use JSON based policy for security.

- Click on an existing S3 bucket -> Bucket Policy
- Take advantage of the policy generator if you don't want to type JSON directly.
- Set the following amongst others:
  * Type of Policy
  * Allow/Deny or both
  * Principal (the user's ARN). To get the ARN of the user:
    . Management Console -> Services -> IAM  -> Users -> Select paticulary user
    . The user's ARN will be displayed at the top.
  * Amazon Resource Name (ARN of the current resource)
- Copy the JSON code generated, go back to the S3 management console and paste the copied JSON policy.

Command Line Parameters/Tools Avaialable for S3 Buckets

- Browse to: S3 API Command

- You will find: Get Bucket ACL, Put Bucket ACL. These set permission on a bucket using Access Control Lists (ACL)

### AWS Documentation  and Notes ###

Storage Performance Management is about selecting the right type and class of storage.

SSD vs HDD (Magnetic)

- Amazon EBS Volume Type Performance

Any question above 10k IOPs use provisioned SSD.

  * SSD
    . GP2 - General purpose - max 10k IOPs
    . Provisioned - max 32k IOPs

  * HDD(Magnetic) - Various types have 250 - 500 IOPs (not high)

- Volume Size Constraints

  * SDD
    . General - 1GiB - 16TiB
    . Provisioned IOPs - 4GiB - 16TiB

  * HDD (Magnetic) - Various types have  500GiB - 16TiB

The default of General Purpose SSD is usually adequate.

- Difference between MB and MiB

  * KB = 1000B, KiB =1024B
  * MB = 1000k, MiB = 1024k
  * GB = 1000B, KiB =1024B

- Storage Class Differences

  * S3 standard
    . Durability   - 99.999_999_999%
    . Availability - 99.99%
  * S3 standard IA
    . Durability   - 99.999_999_999%
    . Availability - 99.9%
  * S3 One Zone IA
    . Durability   - 99.999_999_999%
    . Availability - 99.5%

### Notes ###

- S3 is about object storage not just file storage

- There are different classes of S3 storage.

- Many other services can store data in S3 e.g Kinesis, Firehose.

- Once versioning is turned on you can only suspend it for new S3 objects.

- Replication does not apply to existing data in an S3 bucket.

- Use DNS compliant names for buckets

- S3 bucket names must be globally unique

- All Amazon S3 resources and sub-resources are private by default, but you can configure security features, such as access control lists (ACLs) and bucket policies, to allow public access to your buckets or objects.

- When you see 1 grantee under permission, the obviously it is the owner who has permission.

- Default max amount of bucket is 100

- Default max amount of objects in bucket is infinity (theoritically)

- S3 good for static website hosting.

- Max number of tags for S3 object is 10.

- Files in vault are called archives from AWS Glacier perspective.

- What is the maximum number of vaults an AWS account can create in a region? 1000

- What is the expected recovery window for a Glacier restore with standard access? 3 - 5 hours

- To guarantee IOPS use SSD type provisioned IOPS

- If you use SSD, to take advantage of the additional performance, you need and EBS optimzed instance.

- EBS volume type: Magnetic Standard SSD is free tier

- EFS shares can be limited to a VPC.

- Storage security could be managed through Management Console / CLI

### Acronyms ###

- NAS - Network Attached Storage
- AZ - Availability Zone
- IA - Amazon S3 Infrequent Access
- RRS - Amazon S3 Reduced Redundancy Storage
- MFA - Multi-Factor Authentication
- URL - Uniform Resource Location
- REST - Representational State Transfer
- SNS - Simple Notification Service
- ARN - Amazon Resource Name
- EBS - Elastic Block Store
- SSD - Solid State Drive
- Provisioned IOPS - GUARANTEED Input/output operations per seconds
- NFSv4 - Network File System version 4
- ACL - Access Control List
