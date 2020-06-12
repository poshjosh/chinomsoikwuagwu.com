---
path: "./2020/06/12/Amazon-Relational-Database-Service.md"
date: "2020-06-12T13:55:00"
title: "Amazon Relational Database Service"
description: "Amazon Relational Database Service"
tags: ["AWS", "Relational Database Service (RDS)", "db instance", "db instance class", "multi-AZ rds", "VolumeReadIOPS", "BufferCacheHitRatio", "Option Groups", "Parameter Groups", "Backup and Restoration", "Copying a Snapshot", "Sharing Snapshots", "Amazon RDS Events", "Database log files", "RDS Enhanced Monitoring", "RDS Performance Insights", "Amazon RDS Recommendations", "Master User Account Privileges"]
lang: "en-us"
---

### Introduction ###

Amazon Relational Database Service (Amazon RDS) is a web service that makes it easier to set up, operate, and scale a relational database in the AWS Cloud.

- Independently allocate CPU, IOPS, and storage.

- Amazon RDS manages backups, software patching, automatic failure detection, and recovery.

- Shell access to DB instances NOT PROVIDED.

- Access to certain system procedures and tables that require advanced privileges are RESTRICTED.

- Automated or manual backups.

- You can get high availability with a primary instance and a synchronous secondary instance that you can fail over to when problems occur.

- Supports: `MySQL`, `MariaDB`, `PostgreSQL`, `Oracle`, `Microsoft SQL Server`.

- In addition to the security in your database package, you can help control who can access your RDS databases by using AWS Identity and Access Management (IAM) to define users and permissions

__DB Instances__

The basic building block of Amazon RDS is the DB instance. A DB instance is an isolated database environment in the AWS Cloud. Your DB instance can contain multiple user-created databases.

- The computation and memory capacity of a DB instance is determined by its DB instance class.

- DB instance storage comes in three types: `Magnetic`, `General Purpose (SSD)`, and `Provisioned IOPS (PIOPS)`.

- __General Purpose SSD__

General Purpose SSD storage offers cost-effective storage. _Use cases: Acceptable for most database workloads._

- __Provisioned IOPS__

For a production application that requires fast and consistent I/O performance, we recommend Provisioned IOPS (input/output operations per second) storage. _Use cases: Online transaction processing (OLTP) workloads that have consistent performance requirements._

For production OLTP use cases, we recommend that you use Multi-AZ deployments for enhanced fault tolerance with Provisioned IOPS storage for fast and predictable performance.

The type of storage for a read replica is independent of that on the master DB instance. For example, you might use General Purpose SSD for read replicas with a master DB instance that uses Provisioned IOPS SSD storage to reduce costs.

- __Magnetic Storage__ - Amazon RDS also supports magnetic storage for backward compatibility. We recommend that you use General Purpose SSD or Provisioned IOPS SSD for any new storage needs. The following are some limitations for magnetic storage:

  * Doesn't allow you to scale storage when using the SQL Server database engine.

  * Doesn't support storage autoscaling.

  * Doesn't support elastic volumes.

  * Limited to a maximum size of 3 TiB.

  * Limited to a maximum of 1,000 IOPS.

__High Availability (Multi-AZ) for Amazon RDS__

Amazon RDS provides high availability and failover support for DB instances using Multi-AZ deployments.

In a Multi-AZ deployment, Amazon RDS automatically provisions and maintains a synchronous standby replica in a different Availability Zone.

You can experience a performance impact during and after converting from Single-AZ to Multi-AZ. This impact can be significant for large write-intensive DB instances.

__Billing__

- __On-Demand Instances__ – Pay by the hour for the DB instance hours that you use.

- __Reserved Instances__ – Reserve a DB instance for a one-year or three-year
term and get a significant discount compared to the on-demand DB instance pricing.

### Best Practices ###

- __Allocate enough RAM__ - To optimize performance, allocate enough RAM so that your working set resides almost completely in memory. To determine whether your working set is almost all in memory, examine the following metrics in Amazon CloudWatch:
  * `VolumeReadIOPS`: average number of read I/O operations - `should be small and stable`.
  * `BufferCacheHitRatio`: percentage of requests served from cache - `should be high`.

- __Set TTL value of less than 30 seconds__ - If your client application is caching the Domain Name Service (DNS) data of your DB instances, set a time-to-live (TTL) value of less than 30 seconds. Because the underlying IP address of a DB instance can change after a failover, caching the DNS data for an extended time can lead to connection failures if your application tries to connect to an IP address that no longer is in service. Aurora DB clusters with multiple read replicas can experience connection failures also when connections use the reader endpoint and one of the read replica instances is in maintenance or is deleted.

### Configuring ###

__Option Groups__

Amazon RDS uses option groups to enable and configure additional features that make it easier to manage data and databases, and to provide additional security for your database. An option group can specify features, called options, that are available for a particular Amazon RDS DB instance. Options can have settings that specify how the option works. When you associate a DB instance with an option group, the specified options and option settings are enabled for that DB instance.

Amazon RDS provides an empty default option group for each new DB instance. You cannot modify this default option group, but any new option group that you create derives its settings from the default option group.

- To apply an option to a DB instance, you must do the following:

  * Create a new option group, or copy or modify an existing option group.

  * Add one or more options to the option group.

  * Associate the option group with the DB instance.

- Persistent options can't be removed from an option group while DB instances are associated with the option group.

- Permanent options, such as the TDE option for Oracle Advanced Security TDE, can never be removed from an option group.

- If a DB instance is in a VPC, the option group associated with the instance is linked to that VPC. This means that you can't use the option group assigned to a DB instance if you try to restore the instance to a different VPC or a different platform.

__Parameter Groups__

- A DB parameter group acts as a container for engine configuration values that are applied to one or more DB instances.

- If you create a DB instance without specifying a DB parameter group, the DB instance uses a default DB parameter group.

- You can't modify the parameter settings of a default parameter group. Instead, you create your own parameter group where you choose your own parameter settings.

- Not all DB engine parameters can be changed in a parameter group that you create.

- If you update parameters within a DB parameter group, the changes apply to all DB instances that are associated with that parameter group.

Improperly setting parameters in a DB parameter group can have unintended adverse effects, including degraded performance and system instability. Always exercise caution when modifying database parameters and back up your data before modifying your DB parameter group. Try out parameter group changes on a test DB instances, created using point-in-time-restores, before applying those parameter group changes to your production DB instances.

### Managing ###

__Stopping__

During periods where you don't need an Aurora cluster, you can stop all instances
in that cluster at once. You can start the cluster again anytime you need to use it.

- RDS automatically starts your instance after seven days so that it doesn't
fall behind any required maintenance updates.

- You can't stop a DB instance that has a read replica, or that is a read replica.

- You can't stop an Amazon RDS for SQL Server DB instance in a Multi-AZ configuration.

- You can't modify a stopped DB instance. (You can change the option/parameter group)

- You can't delete an option group that is associated with a stopped DB instance.

- You can't delete a DB parameter group that is associated with a stopped DB instance.

__Renaming__

When you rename a DB instance, the endpoint for the DB instance changes, because the URL includes the name you assigned to the DB instance.

When you rename a DB instance, the old DNS name that was used by the DB instance is immediately deleted, although it could remain cached for a few minutes. The new DNS name for the renamed DB instance becomes effective in about 10 minutes.

All read replicas associated with a DB instance remain associated with that instance after it is renamed.

Metrics and events associated with the name of a DB instance are maintained if you reuse a DB instance name. For example, if you promote a read replica and rename it to be the name of the previous master, the events and metrics associated with the master are associated with the renamed instance.

DB instance tags remain with the DB instance, regardless of renaming.

DB snapshots are retained for a renamed DB instance.

If you make certain modifications, or if you change the DB parameter group associated with the DB instance , you must reboot the instance for the changes to take effect.

You can only create a new read replica from an existing DB instance.

Amazon RDS doesn't support circular replication. You can't configure a DB instance to serve as a replication source for an existing DB instance.

__Tags__

An Amazon RDS tag is a name-value pair that you define and associate with an
Amazon RDS resource. The name is referred to as the key. `Supplying a value
for the key of a tag is optional`.

`Tags are not copied by default`. When you create or restore a DB instance, you can specify that the tags from the DB instance are copied to snapshots of the DB instance. Copying tags ensures that the metadata for the DB snapshots matches that of the source DB instance and any access policies for the DB snapshot also match those of the source DB instance.  

### Backup and Restoration ###

__Backup and Restoration__

- RDS supports both automated and manual backups. You create a manual backup of
your DB instance, by manually creating a DB snapshot.

- Automated backups occur daily during the preferred backup window. If the backup requires more time than allotted to the backup window, the backup continues after the window ends, until it finishes.

You can restore a DB instance and use a different storage type than the source DB snapshot.

You can specify the parameter group when you restore the DB. Amazon recommends that you retain the parameter group for any DB snapshots you create, so that you can associate your restored DB instance with the correct parameter group.

When you restore a DB instance, the default security group is associated with the restored instance by default.

When you restore a DB instance, the option group associated with the DB snapshot is associated with the restored DB instance after it is created.

When you assign an option group to a DB instance, the option group is also linked to the supported platform the DB instance is on, either VPC or EC2-Classic (non-VPC). This means that you can't use the option group assigned to a DB instance if you attempt to restore the instance into a different VPC or onto a different platform.

__Copying a Snapshot__

With Amazon RDS, you can copy automated or manual DB snapshots. After you copy a snapshot, the copy is a manual snapshot.

You can copy a snapshot within the same AWS Region, you can copy a snapshot across AWS Regions, and you can copy shared snapshots.

You can copy snapshots shared to you by other AWS accounts. If you are copying an encrypted snapshot that has been shared from another AWS account, you must have access to the KMS encryption key that was used to encrypt the snapshot.

You can copy a shared DB snapshot across Regions, provided that the snapshot is unencrypted. However, if the shared DB snapshot is encrypted, you can only copy it in the same AWS Region.

You can copy a snapshot that has been encrypted using an AWS KMS encryption key. If you copy an encrypted snapshot, the copy of the snapshot must also be encrypted.

If you copy an encrypted snapshot within the same AWS Region, you can encrypt the copy with the same KMS encryption key as the original snapshot, or you can specify a different KMS encryption key.

If you copy an encrypted snapshot across Regions, you can't use the same KMS encryption key for the copy as used for the source snapshot, because KMS keys are Region-specific.

When you copy a snapshot to an AWS Region that is different from the source snapshot's AWS Region, the first copy is a full snapshot copy, even if you copy an incremental snapshot.

For shared snapshots, all of the copies are full snapshots, even within the same Region.

Option groups are specific to the AWS Region that they are created in.

If you copy a snapshot and you don't specify a new option group for the snapshot, when you restore it the DB instance gets the default option group.

When you copy a snapshot across Regions, the copy doesn't include the parameter group used by the original DB instance.

When you restore a snapshot to create a new DB instance , that DB instance gets the default parameter group for the AWS Region it is created in.

__Sharing Snapshots__

Sharing a manual DB snapshot, whether encrypted or unencrypted, enables authorized AWS accounts to copy the snapshot.

Sharing an unencrypted manual DB snapshot enables authorized AWS accounts to directly restore a DB instance from the snapshot instead of taking a copy of it and restoring from that

You can't restore a DB instance from a DB snapshot that is both shared and encrypted. Instead, you can make a copy of the DB snapshot and restore the DB instance from the copy.

You cannot share a DB snapshot that uses an option group with permanent or persistent options, except for Oracle DB instances that have the Timezone or OLS option (or both).

You can't share encrypted snapshots as public.

You can't share Oracle or Microsoft SQL Server snapshots that are encrypted using Transparent Data Encryption (TDE).

You can't share a snapshot that has been encrypted using the default AWS KMS encryption key of the AWS account that shared the snapshot.

### Monitoring ###

__Automated Monitoring__

You can use the following automated monitoring tools to watch Amazon Aurora and report when something is wrong:

- __Amazon RDS Events__ – Subscribe to Amazon RDS events to be notified when changes occur with a DB instance, DB cluster, DB cluster snapshot, DB parameter group, or DB security group.

- __Database log files__ – View, download, or watch database log files using the Amazon RDS console or Amazon RDS API operations. You can also query some database log files that are loaded into database tables.

- __Amazon RDS Enhanced Monitoring__ — Look at metrics in `real time` for the `operating system`.

- __Amazon RDS Performance Insights__ — Assess the load on your database, and determine when and where to take action.

- __Amazon RDS Recommendations__ — Look at automated recommendations for database resources, such as DB instances, DB clusters, and DB cluster parameter groups.

In addition, Amazon RDS integrates with `Amazon CloudWatch`, `Amazon EventBridge`, and `AWS CloudTrail` for additional monitoring capabilities:

- __Amazon CloudWatch Metrics__ – Amazon RDS automatically sends metrics to CloudWatch every minute for each active database. You don't get additional charges for Amazon RDS metrics in CloudWatch.

- __Amazon CloudWatch Alarms__ – You can watch a single Amazon RDS metric over a specific time period. You can then perform one or more actions based on the value of the metric relative to a threshold that you set.

- __Amazon CloudWatch Logs__ – Most DB engines enable you to monitor, store, and access your database log files in CloudWatch Logs.

- __Amazon CloudWatch Events and Amazon EventBridge__ – You can automate AWS services and respond to system events such as application availability issues or resource changes. Events from AWS services are delivered to CloudWatch Events and EventBridge nearly in real time. You can write simple rules to indicate which events interest you and what automated actions to take when an event matches a rule.

- __AWS CloudTrail__ – You can view a record of actions taken by a user, role, or an AWS service in Amazon RDS. CloudTrail captures all API calls for Amazon RDS as events. These captures include calls from the Amazon RDS console and from code calls to the Amazon RDS API operations. If you create a trail, you can enable continuous delivery of CloudTrail events to an Amazon S3 bucket, including events for Amazon RDS. If you don't configure a trail, you can still view the most recent events in the CloudTrail console in Event history.

__Manual Monitoring__

>Another important part of monitoring Amazon RDS involves manually monitoring those items that the CloudWatch alarms don't cover. The Amazon RDS, CloudWatch, AWS Trusted Advisor and other AWS console dashboards provide an at-a-glance view of the state of your AWS environment. We recommend that you also check the log files on your DB instance.

__Recommendations__

Amazon RDS provides automated recommendations for database resources, such as DB instances, read replicas, and DB parameter groups. These recommendations provide best practice guidance by analyzing DB instance configuration, usage, and performance data.

You can find recommendations in the AWS Management Console. You can perform the recommended action immediately, schedule it for the next maintenance window, or dismiss it.

__Using RDS Events__

Amazon RDS uses the Amazon Simple Notification Service (Amazon SNS) to provide notification when an Amazon RDS event occurs.

RDS event notifications can be in any notification form supported by Amazon SNS for an AWS Region, such as an email, a text message, or a call to an HTTP endpoint.

Amazon RDS doesn't guarantee the order of events sent in an event stream. The event order is subject to change.

- `24 hours` - The AWS __Management Console__, shows events from the past 24 hours.

- `14 days` - The __AWS CLI__ or the __RDS API__ can retrieve events for up to the past 14 days. Use the `describe-events AWS CLI command`, or the `DescribeEvents RDS API operation`. If you use  

- You can configure Amazon RDS to send events to `CloudWatch Events` or `Amazon EventBridge`.

__Logging Amazon RDS API Calls with AWS CloudTrail__

>Amazon RDS is integrated with AWS CloudTrail, a service that provides a record of actions taken by a user, role, or an AWS service in Amazon RDS. CloudTrail captures all API calls for Amazon RDS as events, including calls from the Amazon RDS console and from code calls to the Amazon RDS APIs. If you create a trail, you can enable continuous delivery of CloudTrail events to an Amazon S3 bucket, including events for Amazon RDS. If you don't configure a trail, you can still view the most recent events in the CloudTrail console in Event history. Using the information collected by CloudTrail, you can determine the request that was made to Amazon RDS, the IP address from which the request was made, who made the request, when it was made, and additional details.

### Security ###

__Encryption__

For an Amazon RDS encrypted DB instance, all logs, backups, and snapshots are encrypted. A read replica of an Amazon RDS encrypted instance is also encrypted using the same key as the master instance when both are in the same AWS Region. If the master and read replica are in different AWS Regions, you encrypt using the encryption key for that AWS Region.

You can only enable encryption for an Amazon RDS DB instance when you create it, not after the DB instance is created.

However, because you can encrypt a copy of an unencrypted DB snapshot, you can effectively add encryption to an unencrypted DB instance. That is, you can create a snapshot of your DB instance, and then create an encrypted copy of that snapshot. You can then restore a DB instance from the encrypted snapshot

DB instances that are encrypted can't be modified to disable encryption.

You can't have an encrypted read replica of an unencrypted DB instance or an unencrypted read replica of an encrypted DB instance.

Encrypted read replicas must be encrypted with the same key as the source DB instance when both are in the same AWS Region.

You can't restore an unencrypted backup or snapshot to an encrypted DB instance.

To copy an encrypted snapshot from one AWS Region to another, you must specify the KMS key identifier of the destination AWS Region. This is because KMS encryption keys are specific to the AWS Region that they are created in.

__Key Management__

You can't delete, revoke, or rotate default keys provisioned by AWS KMS. You can't share a snapshot that has been encrypted using the default AWS KMS encryption key of the AWS account that shared the snapshot.

Use `customer-managed key`, if you want full control over a key.

When RDS encounters a DB instance encrypted by a key that RDS doesn't have access to, RDS puts the DB instance into a terminal state. In this state, the DB instance is no longer available and the current state of the database can't be recovered. To restore the DB instance, you must re-enable access to the encryption key for RDS, and then restore the DB instance from a backup.

__SSL__

As of March 5, 2020, Amazon RDS CA-2015 certificates have expired. If you use or plan to use Secure Sockets Layer (SSL) or Transport Layer Security (TLS) with certificate verification to connect to your RDS DB instances, you require Amazon RDS CA-2019 certificates, which are enabled by default for new DB instances.

__IAM Database Authentication for MySQL and PostgreSQL__

You can authenticate to your DB instance using AWS Identity and Access Management (IAM) database authentication. IAM database authentication works with MySQL and PostgreSQL. With this authentication method, you don't need to use a password when you connect to a DB instance. Instead, you use an authentication token.

An authentication token is a unique string of characters that Amazon RDS generates on request. Authentication tokens are generated using AWS Signature Version 4. Each token has a lifetime of 15 minutes. You don't need to store user credentials in the database, because authentication is managed externally using IAM. You can also still use standard database authentication.

An IAM administrator user can access DB instances without explicit permissions in an IAM policy. If you want to restrict administrator access to DB instances, you can create an IAM role with the appropriate, lesser privileged permissions and assign it to the administrator.

__Master User Account Privileges__

When you create a new DB instance, the default master user that you use gets certain privileges for that DB instance. Do not use the master user directly in your applications. Instead, adhere to the best practice of using a database user created with the minimal privileges required for your application.

### Takeaways ###

- Shell access to RDS DB instances NOT PROVIDED. Access to certain system procedures and tables that require advanced privileges are RESTRICTED.

- Supports: `MySQL`, `MariaDB`, `PostgreSQL`, `Oracle`, `Microsoft SQL Server`.

- DB instance storage comes in three types: `Magnetic`, `General Purpose (SSD)`, and `Provisioned IOPS (PIOPS)`.

- The type of storage for a read replica is independent of that on the master DB instance.

- Amazon RDS also supports magnetic storage for backward compatibility.

- In a Multi-AZ deployment, Amazon RDS automatically provisions and maintains a synchronous standby replica in a different Availability Zone.

- __Allocate enough RAM__ - To optimize performance, allocate enough RAM so that your working set resides almost completely in memory.

- __Set TTL value of less than 30 seconds__ - If your client application is caching the Domain Name Service (DNS) data of your DB instances, set a time-to-live (TTL) value of less than 30 seconds.

- You cannot modify this default option group, but any new option group that you create derives its settings from the default option group.

- Persistent options can't be removed from an option group while DB instances are associated with the option group.

- Permanent options, such as the TDE option for Oracle Advanced Security TDE, can never be removed from an option group.

- If a DB instance is in a VPC, the option group associated with the instance is linked to that VPC. This means that you can't use the option group assigned to a DB instance if you try to restore the instance to a different VPC or a different platform.

- If you create a DB instance without specifying a DB parameter group, the DB instance uses a default DB parameter group.

- You can't modify the parameter settings of a default parameter group. Instead, you create your own parameter group where you choose your own parameter settings.

- Always back up your data before modifying your DB parameter group.

- If you stop your RDS instance, RDS automatically starts your instance after seven days so that it doesn't
fall behind any required maintenance updates.

- You can't stop a DB instance that has a read replica, or that is a read replica.

- You can't stop an Amazon RDS for SQL Server DB instance in a Multi-AZ configuration.

- You can't modify a stopped DB instance. (You can change the option/parameter group)

- You can't delete an option/parameter group that is associated with a stopped DB instance.

- All read replicas associated with a DB instance remain associated with that instance after it is renamed.

- Metrics and events associated with the name of a DB instance are maintained if you `reuse` a DB instance name.

- DB instance tags remain with the DB instance, regardless of renaming.

- DB snapshots are retained for a renamed DB instance.

- Supplying a value for the key of a tag is optional.

- `Tags are not copied by default`.

- You can restore a DB instance and use a different storage type than the source DB snapshot.

- When you restore a DB instance:

  * Parameter group - you can specify. (It is recommended to retain the source parameter group)
  * Option group - Same as from the source instance.
  * Security group - The default is applied.

- Option groups are linked to VPC or EC2-Classic (non-VPC). This means that you can't use the option group assigned to a DB instance if you attempt to restore the instance into a different VPC or onto a different platform.

- You can copy a snapshot within the same AWS Region, you can copy a snapshot across AWS Regions, and you can copy shared snapshots.

- If you are copying an encrypted snapshot that has been shared from another AWS account, you must have access to the KMS encryption key that was used to encrypt the snapshot.

- You can copy a shared DB snapshot across Regions, provided that the snapshot is unencrypted. However, if the shared DB snapshot is encrypted, you can only copy it in the same AWS Region.

- The copy of an encrypted snapshot must also be encrypted.

- When you copy a snapshot across Regions, the copy doesn't include the parameter group used by the original DB instance.

- When you restore a snapshot to create a new DB instance , that DB instance gets the default parameter group for the AWS Region it is created in.

- You can copy a shared snapshot. Additionally if the snapshot is unencrypted you can restore a db instance directly from it.

- You can't restore a DB instance from a DB snapshot that is both shared and encrypted. Instead, you can make a copy of the DB snapshot and restore the DB instance from the copy.

- You cannot share a DB snapshot that uses an option group with permanent or persistent options, except for Oracle DB instances that have the Timezone or OLS option (or both).

- You can't share encrypted snapshots as public.

- You can't share a snapshot that has been encrypted using the default AWS KMS encryption key of the AWS account that shared the snapshot.

- Automated monitoring via RDS Events, DB log files, RDS Enhanced monitoring, RDS Performance Insights, RDS recommendations

- Amazon RDS integrates with `Amazon CloudWatch` (metrics, alarms, logs, events), `Amazon EventBridge`, and `AWS CloudTrail` for additional monitoring capabilities

- Amazon RDS doesn't guarantee the order of events sent in an event stream. The event order is subject to change.

- `24 hours` - The AWS __Management Console__, shows events from the past 24 hours.

- `14 days` - The __AWS CLI__ or the __RDS API__ can retrieve events for up to the past 14 days.

- You can only enable encryption for an Amazon RDS DB instance when you create it, not after the DB instance is created.

- DB instances that are encrypted can't be modified to disable encryption.

- You can encrypt a copy of an unencrypted DB snapshot, you can effectively add encryption to an unencrypted DB instance.

- You can't have an encrypted read replica of an unencrypted DB instance or an unencrypted read replica of an encrypted DB instance.

- To copy an encrypted snapshot from one AWS Region to another, you must specify the KMS key identifier of the destination AWS Region. This is because KMS encryption keys are specific to the AWS Region that they are created in.

- You can't share a snapshot that has been encrypted using the default AWS KMS encryption key of the AWS account that shared the snapshot.

- Use `customer-managed key`, if you want full control over a key.

- You can authenticate to your DB instance using AWS Identity and Access Management (IAM) database authentication. IAM database authentication works with MySQL and PostgreSQL. With this authentication method, you don't need to use a password when you connect to a DB instance. Instead, you use an authentication token.

- An IAM administrator user can access DB instances without explicit permissions in an IAM policy.

- Do not use the master user directly in your applications. Instead, adhere to the best practice of using a database user created with the minimal privileges required for your application.
