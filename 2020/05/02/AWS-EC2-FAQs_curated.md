---
path: "./2020/05/02/AWS-EC2-FAQs_curated.md"
date: "2020-05-02T19:22:10"
title: "AWS EC2 FAQs - Curated"
description: "Curated FAQs on AWS EC2, plus a must read summary for quick start"
tags: ["AWS", "FAQ", "EC2", "On-Demand Instance limits", "vCPU-based limits", "SMTP endpoint policy", "SLA Credit", "accelerated computing instances", "compute optimized instances", "General Purpose Instances", "High Memory Instances", "Previous Generation Instances", "Memory Optimized Instances", "Amazon Elastic Block Store (EBS)", "Amazon Elastic File System (EFS)", "NVMe Instance storage", "Elastic Fabric Adapter (EFA)", "Elastic IP", "Enhanced Networking",  "Amazon CloudWatch",  "Amazon EC2 Auto Scaling", "Hibernate", "VM Import/Export",  "EC2 Billing",  "EC2 Savings Plans", "Convertible Reserved Instances", "EC2 Fleet", "On-Demand Capacity Reservation", "Reserved Instances", "Reserved Instance Marketplace", "Spot Instances", "Amazon Time Sync Service", "Cluster Instances",  "cluster placement group", "Cluster Compute Instance", "Cluster GPU Instance", "High Memory Cluster Instance", "Micro instances", "Nitro Hypervisor", "Optimize CPUs", "Amazon EC2 running IBM", "EC2 running Microsoft Windows", "EC2 running third-party software"]
lang: "en-us"
---

### Introduction ###

- This article features a curated set of FAQs on AWS EC2

- It is an estimated 40 - minute read.

- __TL;DR__ - Read the Takeaways at the end of this article.

### General ###

Q: __Is automatic recovery of an EC2 Instance on failure possible?__

>You can create an Amazon CloudWatch alarm that monitors an Amazon EC2 instance and automatically recovers the instance if it becomes impaired due to an underlying hardware failure or a problem that requires AWS involvement to repair. Terminated instances cannot be recovered. A recovered instance is identical to the original instance, including the instance ID, private IP addresses, Elastic IP addresses, and all instance metadata. If the impaired instance is in a placement group, the recovered instance runs in the placement group.

Maximum daily allowance of three recovery attempts.

Q: __What is the difference between using the local instance store and Amazon Elastic Block Store (Amazon EBS) for the root device?__

>When you launch your Amazon EC2 instances you have the ability to store your root device data on Amazon EBS or the local instance store. By using Amazon EBS, data on the root device will persist independently from the lifetime of the instance. This enables you to stop and restart the instance at a subsequent time, which is similar to shutting down your laptop and restarting it when you need it again.

>Alternatively, the local instance store only persists during the life of the instance. This is an inexpensive way to launch instances where data is not stored to the root device. For example, some customers use this option to run large web sites where each instance is a clone to handle web traffic.

Q: __What operating system environments are supported?__

>Amazon EC2 currently supports a variety of operating systems including: Amazon Linux, Ubuntu, Windows Server, Red Hat Enterprise Linux, SUSE Linux Enterprise Server, openSUSE Leap, Fedora, Fedora CoreOS, Debian, CentOS, Gentoo Linux, Oracle Linux, and FreeBSD. We are looking for ways to expand it to other platforms.

__EC2 On-Demand Instance limits__

Q: __What is changing?__

Amazon EC2 is transitioning On-Demand Instance limits from the current
__instance count-based__ limits to the new __vCPU-based__ limits

Q: __What are vCPU-based limits?__

Each running on-demand instance has a number of vCPUs assigned as shown in
the following table:

Instance Size | 	vCPUs
--------------|--------
nano |	1
micro |	1
small |	1
medium |	1
large |	2
xlarge |	4
2xlarge |	8
3xlarge |	12
4xlarge |	16
8xlarge |	32
9xlarge |	36
10xlarge |	40
12xlarge |	48
16xlarge |	64
18xlarge |	72
24xlarge |	96
32xlarge |	128

In addtion, each AWS account has the following vCPU limit

Running On-Demand Instance Type |	Default vCPU Limit
--------------------------------|-------------------
Standard (A, C, D, H, I, M, R, T, Z) instances | 	1152 vCPUs
F instances |	128 vCPUs
G instances |	128 vCPUs
Inf instances |	128 vCPUs
P instances |	128 vCPUs
X instances |	128 vCPUs

Q: __Are these On-Demand Instance vCPU-based limits regional?__

Yes, the On-Demand Instance limits for an AWS account are set on a per-region basis.

__Changes to EC2 SMTP endpoint policy__

Q: __What is changing?__

Starting Jan-27 2020, EC2 will restrict email traffic over port 25 by default.
AWS accounts that have requested and had Port 25 throttles removed in the past
will not be impacted by this change.

__Service level agreement (SLA)__

Q: __What is SLA Credit and how can I qualify for it?__

Amazon SLA guarantees a Monthly Uptime of at least 99.99 percent for Amazon EC2
and Amazon EBS within a Region. You are eligible for SLA credit if the Region
that you are operating in has an Monthly Uptime Percentage of less than
99.95 percent during any monthly billing cycle

### EC2 Instance Types ###

__Accelerated Computing Instances__

Q: __Which AMIs can I use with P3, P2 and G3 instances?__

You can currently use Windows Server, SUSE Enterprise Linux, Ubuntu, and Amazon
Linux AMIs on P2 and G3 instances. P3 instances only support HVM AMIs.

Q: __When would I use Inf1 vs. C5 vs. G4 instances for inference?__

Model Characteristics and Libraries Used        | EC2 Instance Type 	
------------------------------------------------|------------------
Models that benefit from low latency and high throughput at low cost 	| Inf1 	  	 
Models not sensitive to latency and throughput 	| C5 	 
Models requiring NVIDIA’s developer libraries 	| G4

__Compute Optimized Instances__

Q. __Should I move my workloads from C3 or C4 instances to C5 instances?__

C5 has 25% price/performance improvement over C4 instances.

Q. __How many EBS volumes can be attached to C5 instances?__

C5 instances support a maximum for 27 EBS volumes for all Operating systems.
The limit is shared with ENI attachments which can be found
[here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html).
For example: since every instance has at least 1 ENI, if you have 3 additional
ENI attachments on the c4.2xlarge, you can attach 24 EBS volumes to that instance.

__General Purpose Instances__

Q: __What are Amazon EC2 M6g instances?__

Amazon EC2 M6g instances are the next-generation of general-purpose instances
powered by Arm-based AWS Graviton2 Processors. M6g instances deliver up to 40%
better price/performance over M5 instances.

Q: __Is memory encryption supported by AWS Graviton2 processors?__

AWS Graviton2 processors support always-on 256-bit memory encryption to further
enhance security.
- Encryption keys are generated within and do not leave the host system.
- Keys are irrecoverably destroyed when the host is rebooted or powered down.
- AWS KMS and customer bring-your-own-keys not supported by memory encryption.

Q: __Will customers need to modify their applications and workloads to be able
to run on the M6g instances?__

- Applications built on open source software are well supported by Arm ecosystem.
- Most linux distros as well as containers (Docker, Kubernetes, Amazon ECS,
Amazon EKS) support ARM architecture.
- Applications based on interpreted languages (such as Java, Node, Python, Go)
not reliant on native CPU instruction sets, should run with minimal to no changes.
- Other applications may need to be re-compiled.

Q: __Are there specific AMI requirements to run on M6g and A1 instances?__

You will need to use the “arm64” AMIs with the M6g and A1 instances. x86 AMIs
are not compatible with M6g and A1 instances.

Q: __Does my T2 instance credit balance persist at stop / start?__

No, a stopped instance does not retain its previously earned credit balance.

Q: __Can T2 instances be purchased as Reserved Instances or Spot Instances?__

T2 instances can be purchased as On-Demand Instances, Reserved Instances or Spot Instances.

__High Memory Instances__

Q. __What are EC2 High Memory instances?__

High Memory instances offer 6 - 24 TB of memory in a single instance.

Q. __Are High Memory instances certified by SAP to run SAP HANA workloads?__

- `x1e.32xlarge` - certified by SAP to run next-generation Business Suite S/4HANA, Business Suite on HANA (SoH), Business Warehouse on HANA (BW), and Data Mart Solutions on HANA on the AWS cloud.

- `X1` - Certified by SAP to run Business Warehouse on HANA (BW), Data Mart Solutions on HANA, Business Suite on HANA (SoH), Business Suite S/4HANA.

- `High Memory` - Certified by SAP for running Business Suite on HANA, the next-generation Business Suite S/4HANA, Data Mart Solutions on HANA, Business Warehouse on HANA, and SAP BW/4HANA in production environments.

Q. __What is the lifecycle of a Dedicated Host?__

>Once a Dedicated Host is allocated within your account, it will be standing by for your use. You can then launch an instance with a tenancy of "host" using the RunInstances API, and can also stop/start/terminate the instance through the API. You can use the AWS Management Console to manage the Dedicated Host and the instance. The Dedicated Host will be allocated to your account for the period of 3-year reservation. After the 3-year reservation expires, you can continue using the host or release it anytime.

__Previous Generation Instances__

Q: __Why don’t I see M1, C1, CC2 and HS1 instances on the pricing pages any more?__

These have been moved to the Previous Generation Instance page.

__Memory Optimized Instances__

Q. __Do Dense-storage and HDD-storage instances provide any failover mechanisms or redundancy?__

>The primary data storage for Dense-storage instances is HDD-based instance storage. Like all instance storage, these storage volumes persist only for the life of the instance. Hence, we recommend that you build a degree of redundancy (e.g. RAID 1/5/6) or use file systems (e.g. HDFS and MapR-FS) that support redundancy and fault tolerance. You can also back up data periodically to more durable data storage solutions such as Amazon Simple Storage Service (S3) for additional data durability. Please refer to Amazon S3 for reference.

Q. __AWS has other database and Big Data offerings. When or why should I use High I/O instances?__

High I/O instances are ideal for applications that require access to millions of low latency IOPS, and can leverage data stores and architectures that manage data redundancy and availability. Example applications are:

- NoSQL databases like Cassandra and MongoDB
- In-memory databases like Aerospike
- Elasticsearch and analytics workloads
- OLTP systems

### Storage ###

__Amazon Elastic Block Store (EBS)__

Q: __What happens to my data when a system terminates?__

The data stored on a local instance store will persist only as long as that instance is alive. However, data that is stored on an Amazon EBS volume will persist independently of the life of the instance. If you are using an Amazon EBS volume as a root partition, __you will need to set the Delete On Terminate flag to "N" if you want your Amazon EBS volume to persist outside the life of the instance__.

Q: __What are the types of EBS volumes available?__

Amazon EBS provides four current generation volume types and are divided into
two major categories: SSD-backed storage for transactional workloads and
HDD-backed storage for throughput intensive workloads.

Volume Type           | Drive Type  | API Name
----------------------|-------------|----------
Provisioned           | SSD         | `io1`
EBS General Purpose   | SSD         | `gp2`
Throughput Optimized  | HDD         | `st1`
Cold                  | HDD         | `sc1`

Q: __Do you support multiple instances accessing a single volume?__

While you are able to attach multiple volumes to a single instance, attaching multiple instances to one volume is not supported at this time.

Q: __Do volumes need to be un-mounted in order to take a snapshot? Does the snapshot need to complete before the volume can be used again?__

>No, snapshots can be done in real time while the volume is attached and in use. However, snapshots only capture data that has been written to your Amazon EBS volume, which might exclude any data that has been locally cached by your application or OS. In order to ensure consistent snapshots on volumes attached to an instance, we recommend cleanly detaching the volume, issuing the snapshot command, and then reattaching the volume. For Amazon EBS volumes that serve as root devices, we recommend shutting down the machine to take a clean snapshot.

Q: __What charges apply when using Amazon EBS shared snapshots?__

If you share a snapshot, you won’t be charged when other users make a copy of your snapshot. If you make a copy of another user’s shared volume, you will be charged normal EBS rates.

Q: __Do you offer encryption on Amazon EBS volumes and snapshots?__

Yes. EBS offers seamless encryption of data volumes and snapshots. EBS encryption better enables you to meet security and encryption compliance requirements.

__Amazon Elastic File System (EFS)__

Q. __How do I access a file system from an Amazon EC2 instance?__

Mount the file system on an Amazon EC2 Linux-based instance using the standard
Linux mount command and the file system’s DNS name. Amazon EFS uses the NFSv4.1
protocol.

Q. __What Amazon EC2 instance types and AMIs work with Amazon EFS?__

Amazon EFS is compatible with all Amazon EC2 instance types and is accessible
from Linux-based AMIs. You can mix and match the instance types connected to a
single file system.

Q. __How do I access my file system from outside my VPC?__

- Within VPC - EC2 instances can access your file system directly
- Outside VPC:
  * EC2 Classic instances - mount your file system via
  [ClassicLink](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html).
  * On-premises servers - mount your file systems via an
  [AWS Direct Connect](https://aws.amazon.com/directconnect/) connection to your VPC.

Q. __How many Amazon EC2 instances can connect to a file system?__

Amazon EFS supports one to thousands of Amazon EC2 instances connecting to a file system concurrently.

__NVMe Instance storage__

Q: __Which instance types offer NVMe instance storage?__

- d variants use NVMe SSD storage, currently: C5d, M5d, M5ad, R5d, R5ad, z1d
- `I` and `F` instance types use NVMe SSD storage, currently: I3, I3en, F1

Q: __Is data stored on Amazon EC2 NVMe instance storage encrypted?__

Yes, all data is encrypted in an AWS Nitro hardware module prior to being written on the locally attached SSDs offered via NVMe instance storage.

Q: __What encryption algorithm is used to encrypt Amazon EC2 NVMe instance storage?__

Amazon EC2 NVMe instance storage is encrypted using an XTS-AES-256 block cipher.

Q: __Are encryption keys unique to an instance or a particular device for NVMe instance storage?__

Encryption keys are unique to each NVMe instance storage device that is provided
with an EC2 instance.

Q: __What is the lifetime of encryption keys on NVMe instance storage?__

All keys are irrecoverably destroyed on any de-allocation of the storage,
including instance stop and instance terminate actions.

Q: __Can I disable NVMe instance storage encryption?__

No, NVMe instance storage encryption is always on, and cannot be disabled.

Q: __Does Amazon EC2 NVMe instance storage support AWS Key Management Service (KMS)?__

No, disk encryption on NVMe instance storage does not support integration with
AWS KMS system. Customers cannot bring in their own keys to use with NVMe
instance storage.

### Networking and Security ###

__Elastic Fabric Adapter (EFA)__

Q: __Why should I use EFA?__

>EFA brings the scalability, flexibility, and elasticity of cloud to tightly-coupled HPC applications. With EFA, tightly-coupled HPC applications have access to lower and more consistent latency and higher throughput than traditional TCP channels, enabling them to scale better. EFA support can be enabled dynamically, on-demand on any supported EC2 instance without pre-reservation, giving you the flexibility to respond to changing business/workload priorities.

Q: __What types of applications can benefit from using EFA?__

High Performance Computing (HPC) applications distribute computational workloads across a cluster of instances for parallel processing

__Elastic IP__

Q: __Why am I charged when my Elastic IP address is not associated with a running instance?__

> In order to help ensure our customers are efficiently using the Elastic IP addresses, we impose a small hourly charge for each address when it is not associated to a running instance.

Q: __Can I configure the reverse DNS record for my Elastic IP address?__

>All Elastic IP addresses come with reverse DNS, in a standard template of the form ec2-1-2-3-4.region.compute.amazonaws.com. For customers requiring custom reverse DNS settings for internet-facing applications that use IP-based mutual authentication (such as sending email from EC2 instances), you can configure the reverse DNS record of your Elastic IP address by filling out this form. Alternatively, please contact AWS Customer Support if you want AWS to delegate the management of the reverse DNS for your Elastic IPs to your authoritative DNS name servers (such as Amazon Route 53), so that you can manage your own reverse DNS PTR records to support these use-cases. Note that a corresponding forward DNS record pointing to that Elastic IP address must exist before we can create the reverse DNS record.

Q: __When should I use the Classic Load Balancer and when should I use the Application Load Balancer?__

The Classic Load Balancer is ideal for simple load balancing of traffic across multiple EC2 instances, while the Application Load Balancer is ideal for applications needing advanced routing capabilities, microservices, and container-based architectures. Please visit Elastic Load Balancing for more information.

__Enhanced Networking__

Q: __What networking capabilities are included in enhanced networking?__

Enhanced networking provides higher packet per second (PPS) performance,
lower inter-instance latencies, and very low network jitter.

Q: __Why should I use Enhanced Networking?__

If your applications benefit from high packet-per-second performance and/or low latency networking, Enhanced Networking will provide significantly improved performance, consistence of performance and scalability.

Q: __How can I enable Enhanced Networking on supported instances?__

In order to enable this feature, you must launch an HVM AMI with the appropriate drivers.

- `ena` Linux driver - used by C5, C5d, F1, G3, H1, I3, I3en, m4.16xlarge, M5, M5a, M5ad, M5d, P2, P3, R4, R5, R5a, R5ad, R5d, T3, T3a, X1, X1e, and z1d instances.

- `ixgbevf` Linux driver - used by C3, C4, D2, I2, M4 (excluding m4.16xlarge), and R3 instances.

Amazon Linux AMI includes both of these drivers by default. For AMIs that do not contain these drivers, you will need to download and install the appropriate drivers based on the instance types you plan to use.

Enhanced Networking is only supported in Amazon VPC. It is not supported in EC2-Classic

Q: __Do I need to pay an additional fee to use Enhanced Networking?__

No, there is no additional fee for Enhanced Networking.

__Security__

Q: __Can I get a history of all EC2 API calls made on my account for security analysis and operational troubleshooting purposes?__

Yes. To receive a history of all EC2 API calls (including VPC and EBS) made on your account, you simply turn on CloudTrail

### Management ###

__Amazon CloudWatch__

Q: __What is the minimum time interval granularity for the data that Amazon CloudWatch receives and aggregates?__

Metrics are received and aggregated at __1 minute intervals__.

Q: __Will I lose the metrics data if I disable monitoring for an Amazon EC2 instance?__

Metrics data are stored for __2 weeks__. If you want to archive metrics beyond
2 weeks you can do so by calling `mon-get-stats` command from the command line
and storing the results in [Amazon S3](https://aws.amazon.com/s3/) or
[Amazon SimpleDB](https://aws.amazon.com/simpledb/).

__Amazon EC2 Auto Scaling__

Q: __Can I automatically scale Amazon EC2 Auto Scaling Groups?__

>Yes. Amazon EC2 Auto Scaling is a fully managed service designed to launch or terminate Amazon EC2 instances automatically to help ensure you have the correct number of Amazon EC2 instances available to handle the load for your application.

__Hibernate__

Q: __What is the difference between hibernate and stop?__

In the case of hibernate, your instance gets hibernated and the RAM data persisted. In the case of Stop, your instance gets shutdown and RAM is cleared.

In both the cases, data from your EBS root volume and any attached EBS data volumes is persisted. Your private IP address remains the same, as does your elastic IP address (if applicable). The network layer behavior will be similar to that of EC2 Stop-Start workflow. Stop and hibernate are available for Amazon EBS backed instances only. Local instance storage is not persisted.

Q: __Can I enable hibernation on an existing instance?__

No, you cannot enable hibernation on an existing instance (running or stopped). This needs to be enabled during instance launch.

Q: __How can I tell that an instance is hibernated?__

Hibernated instances are in `Stopped` state. However, state reason for
hibernate should be `Client.UserInitiatedHibernate`.

Q: __Is my memory (RAM) data encrypted when it is moved to EBS?__

Yes, RAM data is always encrypted when it is moved to the EBS root volume. Encryption on the EBS root volume is enforced at instance launch time. This is to ensure protection for any sensitive content that is in memory at the time of hibernation.

Q: __How long can I keep my instance hibernated?__

60 days max.

Q: __What are the prerequisites to hibernate an instance?__

- Root volume must be an encrypted EBS volume.
- Sufficient space available on your EBS root volume to write data from memory.
- For Windows, Hibernation is supported for instances up to 16 GB of RAM
- For other operating systems, Hibernation is supported for instances with less than 150 GB of RAM.
- The instance needs to be configured to receive the `ACPID` signal for
hibernation (or use the Amazon published AMIs that are configured for hibernation).

Q: __Which instances and operating systems support hibernation?__

Hibernation is currently supported across M3, M4, M5, C3, C4, C5, R3, R4, R5, and T2 instances running Amazon Linux, Amazon Linux 2, Ubuntu and Windows.

__VM Import/Export__

Q. __What is VM Import/Export?__

VM Import/Export enables customers to import Virtual Machine (VM) images in order to create Amazon EC2 instances.

Q. __Are there requirements when importing a VM into Amazon EC2?__

- _VM must be in stopped state_ - The virtual machine must be in a stopped state before generating the VMDK or VHD image. The VM cannot be in a paused or suspended state.
- _Export VM with only boot volume attached_ - It is recommended you export the virtual machine with only the boot volume attached. You can import additional disks using the `ImportVolume` command and attach them to the virtual machine using `AttachVolume`.
- _Encrypted disks not supported_ - Encrypted disks (e.g. Bit Locker) and encrypted image files are not supported.
- _Ensure remote access enabled_ - Ensure Remote Desktop (RDP) or Secure Shell (SSH) is enabled for remote access.
- _Ensure host firewall configured to allow remote access_ - Verify that your host firewall (Windows firewall, iptables, or similar), if configured, allows access to RDP or SSH.

### Billing and Purchase options ##

__Billing__

Q: __How will I be charged and billed for my use of Amazon EC2?__

You pay only for what you use. Displayed pricing is an hourly rate but depending on which instances you choose, you pay by the hour or second (minimum of 60 seconds) for each instance type

Q: __How will I be charge for data transfer between 2 EC2 instances in different AZs/regions?__

The sending EC2 instance gets outgoing rate, while the receiving instance gets
incoming rate. Also for:

- Different AZs within same region - Data Transfer rate
- Different regions - Internet Data Transfer rate  

Q: __Do prices include taxes?__

Except as otherwise noted, prices are exclusive of applicable taxes and duties,
including VAT and applicable sales tax.

__Savings Plans__

Q: __What is Savings Plans?__

Savings Plans is a flexible pricing model that offers low prices on EC2, Lambda and Fargate usage, in exchange for a commitment to a consistent amount of usage (measured in $/hour) for a 1 or 3 year term.

Q: __What types of Savings Plans does AWS offer?__

AWS offers two types of Savings Plans:

1. __Compute Savings Plans__ provides the most flexibility and help to reduce your costs by up to 66%. These plans automatically apply to EC2 instance usage regardless of instance family, size, AZ, region, OS or tenancy, and also apply to AWS Fargate and Lambda usage. For example, with Compute Savings Plans, you can change from C4 to M5 instances, shift a workload from EU (Ireland) to EU (London), or move a workload from EC2 to Fargate or Lambda at any time and automatically continue to pay the Savings Plans price.

2. __EC2 Instance Savings Plans__ provides the lowest prices, offering savings up to 72% in exchange for commitment to usage of individual instance families in a region (e.g. M5 usage in N. Virginia). This automatically reduces your cost on the selected instance family in that region regardless of AZ, size, OS or tenancy. EC2 Instance Savings Plans give you the flexibility to change your usage between instances within a family in that region. For example, you can move from c5.xlarge running Windows to c5.2xlarge running Linux and automatically benefit from the Savings Plan prices.

Q: __How do Savings Plans compare to EC2 RIs?__

Unlike EC2 RI, savings plans automatically reduce your bills on compute usage across any AWS region, even as usage changes.

Compute Savings Plans, automatically reduce your cost on any EC2 instance usage regardless of region, instance family, size, OS, tenancy and even on AWS Fargate and Lambda.

EC2 Instance Savings Plans, automatically save you money on any instance usage within a given EC2 instance family in a chosen region (e.g. M5 in N. Virginia) regardless of size, OS or tenancy.

For more detailed comparison see [this](https://www.gorillastack.com/news/aws-savings-plans-reserved-instances/) and [this](https://www.cloudhealthtech.com/blog/reserved-instances-vs-aws-saving-plan) articles

Q: __Do Savings Plans provide capacity reservations for EC2 instances?__

No, Savings Plans do not provide a capacity reservation. You can however reserve capacity with On Demand Capacity Reservations and pay lower prices on them with Savings Plans.

__Convertible Reserved Instances__

Q: __What is a Convertible RI?__

A Convertible RI is a type of Reserved Instance with attributes that can be changed during the term.

Q: __What term length options are available on Convertible RIs?__

Like Standard RIs, Convertible RIs are available for purchase for a one-year or three-year term.

Q: __Can I transfer a Convertible or Standard RI from one region to another?__

No, a RI is associated with a specific region, which is fixed for the duration of the reservation's term.

Q: __Do I have the freedom to choose any instance type when I exchange my Convertible RIs?__

No, you can only exchange into Convertible RIs that are currently offered by AWS.

__EC2 Fleet__

Q. __What is Amazon EC2 Fleet?__

With a single API call, EC2 Fleet lets you provision compute capacity across different instance types, Availability Zones and across On-Demand, Reserved Instances (RI) and Spot Instances purchase models to help optimize scale, performance and cost.

Q. __If I currently use Amazon EC2 Spot Fleet should I migrate to Amazon EC2 Fleet?__

If you are leveraging Amazon EC2 Spot Instances with Spot Fleet, you can continue to use that. Spot Fleet and EC2 Fleet offer the same functionality. There is no requirement to migrate.

Q. __What is the pricing for Amazon EC2 Fleet?__

EC2 Fleet comes at no additional charge, you only pay for the underlying resources that EC2 Fleet launches.

Q. __Can I submit a multi-region Amazon EC2 Fleet request?__

No, we do not support multi-region EC2 Fleet requests.

Q: __How do I control cost of my EC2 fleet?__

You can set a maximum amount per hour that you’re willing to pay for your fleet, and EC2 Fleet launches instances until it reaches the maximum amount.

__On-Demand Capacity Reservation__

>On-Demand Capacity Reservation is an EC2 offering that lets you create and manage reserved capacity on Amazon EC2. You can create a Capacity Reservation by choosing an Availability Zone and quantity (number of instances) along with other instance specifications such as instance type and tenancy. Once created, the EC2 capacity is held for you regardless of whether you run the instances or not.

Q. __How does Capacity Reservations fit with Savings Plans, EC2 RIs?__

Capacity Reservations can be created for any duration and can be managed independently of your Savings Plans or RIs. If you have Savings Plans or Regional RIs, they will automatically apply to matching Capacity Reservations. This gives you the flexibility to selectively add Capacity Reservations to a portion of your instance footprint and still reduce your bill for that usage.

Q. __How much do Capacity Reservations cost?__

>When the Capacity Reservation is active, you will pay equivalent instance charges whether you run the instances or not. If you do not use the reservation, the charge will show up as unused reservation on your EC2 bill. When you run an instance that matches the attributes of a reservation, you just pay for the instance and nothing for the reservation. There are no upfront or additional charges.

>For example, if you create a Capacity Reservation for 20 c5.2xlarge instances and you run 15 c5.2xlarge instances, you will be charged for 15 instances and 5 unused instances in the reservation (effectively charged for 20 instances).

Q. __Can I share a Capacity Reservation with another AWS Account?__

Yes, you can share Capacity Reservations with other AWS accounts or within your AWS Organization via AWS Resource Access Manager service.

Note that sharing of Capacity Reservation is not available to new AWS accounts or AWS accounts that have a limited billing history. New accounts that are linked to a qualified master (payer) account or through an AWS Organization are exempt from this restriction.

Q. __Is there an additional charge for sharing a reservation?__

There is no additional charge for sharing a reservation.

__Reserved Instances__

Q: __What is a Reserved Instance?__

A Reserved Instance (RI) is an EC2 offering that provides you with a significant discount on EC2 usage when you commit to a one-year or three-year term.

Q: __What are the differences between Standard RIs and Convertible RIs?__

Standard RIs offer a significant discount on EC2 instance usage when you commit to a particular instance family. Convertible RIs offer you the option to change your instance configuration during the term, and still receive a discount on your EC2 usage. For more information on Convertible RIs, please click here.

Q: __When should I purchase a zonal RI?__

If you want to take advantage of the capacity reservation, then you should buy an RI in a specific Availability Zone.

Q: __When should I purchase a regional RI?__

If you do not require the capacity reservation, then you should buy a regional RI. Regional RIs provide AZ and instance size flexibility, which offers broader applicability of the RI’s discounted rate.

Q: __Do RIs apply to Spot instances or instances running on a Dedicated Host?__

No, RIs do not apply to Spot instances or instances running on Dedicated Hosts. To lower the cost of using Dedicated Hosts, purchase Dedicated Host Reservations.

Q: __Can I get a discount on RI purchases?__

Yes, EC2 provides tiered discounts on RI purchases. These discounts are determined based on the total list value (non-discounted price) for the active RIs you have per region. Your total list value is the sum of all expected payments for an RI within the term, including both the upfront and recurring hourly payments. The tier ranges and corresponding discounts are shown alongside.

Tier Range of List Value | Discount on Upfront | Discount on Hourly
-------------------------|---------------------|--------------------
Less than $500k          | 0%                  | 0%
$500k-$4M                | 5%                  | 5%
$4M-$10M 	               | 10% 	               | 10%
More than $10M 	         | Call AWS            |  	

Q: __Do Convertible RIs qualify for Volume Discounts?__

No, however the value of each Convertible RI that you purchase contributes to your volume discount tier standing.

Q: __Do I need to take any action at the time of purchase to receive volume discounts?__

No, you will automatically receive volume discounts when you use the existing PurchaseReservedInstance API or EC2 Management Console interface to purchase RIs.

__Reserved Instance Marketplace__

Q. __What is the Reserved Instance Marketplace?__

The Reserved Instance Marketplace is an online marketplace that provides AWS customers the flexibility to sell their Amazon Elastic Compute Cloud (Amazon EC2) Reserved Instances to other businesses and organizations.

Q. __When can I list a Reserved Instance on the Reserved Instance Marketplace?__

You can list a Reserved Instance when:

- You've registered as a seller in the Reserved Instance Marketplace.
- You've paid for your Reserved Instance.
- You've owned the Reserved Instance for longer than 30 days.

Q. __Can I still use my reservation while it is listed on the Reserved Instance Marketplace?__

Yes, you will continue to receive the capacity and billing benefit of your reservation until it is sold.

Q. __Can I resell a Reserved Instance that I purchased from the Reserved Instance Marketplace?__

Yes

Q. __Are there any restrictions when selling Reserved Instances?__

Yes, you must have a US bank account to sell Reserved Instances in the Reserved Instance Marketplace. Support for non-US bank accounts will be coming soon. Also, you may not sell Reserved Instances in the US GovCloud region.

Q. __Can I sell Reserved Instances purchased from the public volume pricing tiers?__

No, this capability is not yet available.

Q. __Is there a charge for selling Reserved Instances on the Reserved Instance Marketplace?__

Yes, AWS charges a service fee of 12% of the total upfront price of each Reserved Instance you sell in the Reserved Instance Marketplace.

Q. __Do I have to pay for Premium Support when purchasing Reserved Instances from the Reserved Instance Marketplace?__

Yes, if you are a Premium Support customer, you will be charged for Premium Support when you purchase a Reserved Instance through the Reserved Instance Marketplace.

__Spot Instances__

Q. __What is a Spot Instance?__

Spot Instances are spare EC2 capacity that can save you up 90% off of On-Demand prices that AWS can interrupt with a 2-minute notification. Spot prices adjust gradually based on long term supply and demand for spare EC2 capacity.

Q. __What price will I pay for a Spot Instance?__

You pay the Spot price that’s in effect at the beginning of each instance-hour for your running instance. If Spot price changes after you launch the instance, the new price is charged against the instance usage for the subsequent hour.

Q. __What are the best practices to use Spot Instances?__

We highly recommend using multiple Spot capacity pools to maximize the amount of Spot capacity available to you. EC2 provides built-in automation to find the most cost-effective capacity across multiple Spot capacity pools using EC2 Auto Scaling, EC2 Fleet or Spot Fleet.

Q. __Can I use a Spot Instance with a paid AMI for third-party software (such as IBM’s software packages)?__

Not at this time.

Q. __Can I stop my running Spot Instances?__

Yes, you can “stop” your running Spot Instances when they are not needed and keep these stopped instances for later use, instead of terminating instances or cancelling the Spot request. Stop is available for persistent Spot requests.

Q __How do I start/stop Spot Instances?__

Just like On-demand instances, but with the exception that: the Spot Instances will start only if Spot capacity is still available within your maximum price.

Q. __When would my Spot Instance get interrupted?__

Over the last 3 months, 92% of Spot Instance interruptions were from a customer manually terminating the instance because the application had completed its work.

Q. __What happens to my Spot instance when it gets interrupted?__

You can choose to have your Spot instances terminated, stopped or hibernated upon interruption. Stop and hibernate options are available for persistent Spot requests and Spot Fleets with the “maintain” option enabled. By default, your instances are terminated.

Refer to [Spot Hibernation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-hibernation.html) to learn more about handling interruptions.

Q. __Can I resume a hibernated instance?__

No, you will not be able to resume a hibernated instance directly. Hibernate-resume cycle is controlled by Amazon EC2. If an instance is hibernated by Spot, it will be resumed by Amazon EC2 when the capacity becomes available.

Q. __What is a Spot fleet?__

A Spot Fleet allows you to automatically request and manage multiple Spot instances that provide the lowest price per unit of capacity. You can include the instance types that your application can use. You define a target capacity based on your application needs (in units including instances, vCPUs, memory, storage, or network throughput) and update the target capacity after the fleet is launched. Spot fleets enable you to launch and maintain the target capacity, and to automatically request resources to replace any that are disrupted or manually terminated. Learn more about
[Spot fleets](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet.html).

Q. __What happens if my Spot Fleet request tries to launch Spot instances but exceeds my regional Spot request limit?__

If your Spot Fleet request exceeds your regional Spot instance request limit, individual Spot instance requests will fail with a Spot request limit exceeded request status.

Q. __Can I submit a multi-Availability Zone Spot Fleet request?__

Yes, visit the [Spot Fleet Examples](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-examples.html) section of the Amazon EC2 User Guide to learn how to submit a multi-Availability Zone Spot Fleet request.

Q. __Can I tag a Spot Fleet request?__

No, the Fleet by itself cannot be tagged but you can request to launch Spot Instances with tags via Spot Fleet.

Q. __Can I use Spot Fleet with Elastic Load Balancing, Auto Scaling, or Elastic MapReduce?__

Elastic Load Balancing - Yes
Auto Scaling - Yes
Elastic MapReduce - has a feature named `Instance fleets` that provides capabilities similar to Spot Fleet.

Q: __Can I use stop or Hibernation interruption behaviors with Spot Fleet?__

Yes, stop-start and hibernate-resume are supported with Spot Fleet with `maintain` fleet option enabled.

### Platform ###

__Amazon Time Sync Service__

A consistent and accurate reference time source is crucial for many applications and services. The Amazon Time Sync Service provides a time reference that can be securely accessed from an instance without requiring VPC configuration changes and updates.

Q. __How do I use this service?__

The service provides an NTP endpoint at a link-local IP address (169.254.169.123) accessible from any instance running in a VPC. Instructions for configuring NTP clients are available for Linux and Windows.

__Availability Zones__

Q: __How can I make sure that I am in the same Availability Zone as another developer?__

You can't, currently. One Availability Zone name (for example, us-east-1a) in two AWS customer accounts may relate to different physical Availability Zones.

Q: __If I transfer data between Availability Zones using public IP addresses, will I be charged twice for Regional Data Transfer (once because it’s across zones, and a second time because I’m using public IP addresses)?__

No. Regional Data Transfer rates apply if at least one of the following is true, but is only charged once for a given instance even if both are true:

- The other instance is in a different Availability Zone, regardless of which type of address is used.
- Public or Elastic IP addresses are used, regardless of which Availability Zone the other instance is in.

__Cluster Instances__

Q. __What is a cluster placement group?__

A cluster placement group is a logical entity that enables creating a cluster of instances by launching instances as part of a group. The cluster of instances then provides low latency connectivity between instances in the group.

Q. __What is a Cluster Compute Instance?__

Cluster Compute Instances combine high compute resources with a high performance networking for High Performance Compute (HPC) applications and other demanding network-bound applications. Amazon EC2 cluster placement group functionality allows users to group Cluster Compute Instances in clusters – allowing applications to get the low-latency network performance.

Q. __What is a Cluster GPU Instance?__

Cluster GPU Instances provide general-purpose graphics processing units (GPUs) with proportionally high CPU and increased network performance. Cluster GPU Instances give customers with HPC workloads an option beyond Cluster Compute Instances to further benefit from the parallel computing power of GPUs. Cluster GPU Instances use the same cluster placement group functionality as Cluster Compute Instances for grouping instances into clusters – allowing applications to get the low-latency, high bandwidth network performance.

Q. __What is a High Memory Cluster Instance?__

High Memory Cluster Instances provide customers with large amounts of memory and CPU capabilities per instance in addition to high network capabilities. These instance types are ideal for memory intensive workloads. High Memory Cluster Instances use the same cluster placement group functionality as Cluster Compute Instances for grouping instances into clusters – allowing applications to get the low-latency, high bandwidth network performance.

Q. __Is there a limit on the number of Cluster Compute or Cluster GPU Instances I can use and/or the size of cluster I can create by launching Cluster Compute Instances or Cluster GPU into a cluster placement group?__

- Cluster Compute Instance - `no limit`
- Cluster GPU Instances - you can launch `2 Instances` on your own. _If you need more capacity, please complete the Amazon EC2 instance request form (selecting the appropriate primary instance type)._

Q. __Are there any ways to optimize the likelihood that I receive the full number of instances I request for my cluster via a cluster placement group?__

We recommend that you launch the minimum number of instances required to participate in a cluster in a single launch. For very large clusters, you should launch multiple placement groups, e.g. two placement groups of 128 instances, and combine them to create a larger, 256 instance cluster.

Q. __If an instance in a cluster placement group is stopped then started again, will it maintain its presence in the cluster placement group?__

Yes. A stopped instance will be started as part of the cluster placement group it was in when it stopped. If capacity is not available for it to start within its cluster placement group, the start will fail.

Q: __How do I select the right instance type?__

Amazon EC2 instances are grouped into 5 families: General Purpose, Compute Optimized, Memory Optimized, Storage Optimized and Accelerated Computing instances. When choosing instance types, you should consider the characteristics of your application with regards to resource utilization (i.e. CPU, Memory, Storage) and select the optimal instance family and instance size.

Class                 | Types
----------------------|-------------------------
General Purpose       | A, T, M
Compute Optimized     | C
Memory Optimized      | R, X, High Memory, z
Accelerated Computing | P, Inf1, G, F
Storage Optimized     | I, D, H

For more information on [EC2 instance types](/2020/02/07/AWS_EC2-Instance-Types_curated)
click [here](/2020/02/07/AWS_EC2-Instance-Types_curated)

__Micro instances__

Q. __How much compute power do Micro instances provide?__

Micro instances provide a small amount of consistent CPU resources and allow you to burst CPU capacity up to 2 ECUs when additional cycles are available. They are well suited for lower throughput applications and web sites that consume significant compute cycles periodically but very little CPU at other times.

Q. __Are all features of Amazon EC2 available for Micro instances?__

Currently Amazon DevPay is not available for Micro instances.

__Nitro Hypervisor__

Q. __What is the Nitro Hypervisor?__

The launch of C5 instances introduced a new hypervisor for Amazon EC2, the Nitro Hypervisor. As a component of the Nitro system, the Nitro Hypervisor primarily provides CPU and memory isolation for EC2 instances. VPC networking and EBS storage resources are implemented by dedicated hardware components, Nitro Cards that are part of all current generation EC2 instance families. The Nitro Hypervisor is built on core Linux Kernel-based Virtual Machine (KVM) technology, but does not include general-purpose operating system components.

Q. __How does the Nitro Hypervisor benefit customers?__

The Nitro Hypervisor provides consistent performance and increased compute and memory resources for EC2 virtualized instances by removing host system software components.

Q. __How many EBS volumes and Elastic Network Interfaces (ENIs) can be attached to instances running on the Nitro Hypervisor?__

Instances running on the Nitro Hypervisor support a maximum of 27 additional PCI devices for EBS volumes and VPC ENIs. Each EBS volume or VPC ENI uses a PCI device. For example, if you attach 3 additional network interfaces to an instance that uses the Nitro Hypervisor, you can attach up to 24 EBS volumes to that instance.

Q. __Will I notice any difference between instances using Xen hypervisor and those using the Nitro Hypervisor?__

Yes. For example, instances running under the Nitro Hypervisor boot from EBS volumes using an NVMe interface. Instances running under Xen boot from an emulated IDE hard drive, and switch to the Xen paravirtualized block device drivers.

All the features of EC2 such as Instance Metadata Service work the same way on instances running under both Xen and the Nitro Hypervisor. The majority of applications will function the same way under both Xen and the Nitro Hypervisor as long as the operating system has the needed support for ENA networking and NVMe storage.

__Optimize CPUs__

Q: __What is Optimize CPUs?__

Optimize CPUs gives you greater control of your EC2 instances on two fronts. First, you can specify a custom number of vCPUs when launching new instances to save on vCPU-based licensing costs. Second, you can disable Intel Hyper-Threading Technology (Intel HT Technology) for workloads that perform well with single-threaded CPUs, such as certain high-performance computing (HPC) applications.

Q: __How will the CPU optimized instances be priced?__

CPU optimized instances will be priced the same as equivalent full-sized instance.

Q: __How will my application performance change when using Optimize CPUs on EC2?__

Your application performance change with Optimize CPUs will be largely dependent on the workloads you are running on EC2. We encourage you to benchmark your application performance with Optimize CPUs to arrive at the right number of vCPUs and optimal hyper-threading behavior for your application.

Q: __Can I use Optimize CPUs on EC2 Bare Metal instance types (such as i3.metal)?__

No. You can use Optimize CPUs with only virtualized EC2 instances.

### Workloads ###

__Amazon EC2 running IBM__

Q. __How am I billed for my use of Amazon EC2 running IBM?__

You pay only for what you use and there is no minimum fee. Pricing is per instance-hour consumed for each instance type. Partial instance-hours consumed are billed as full hours. Data transfer for Amazon EC2 running IBM is billed and tiered separately from Amazon EC2. There is no Data Transfer charge between two Amazon Web Services within the same region (i.e. between Amazon EC2 US West and another AWS service in the US West). Data transferred between AWS services in different regions will be charged as Internet Data Transfer on both sides of the transfer.

For Amazon EC2 running IBM pricing information, please visit the pricing section on the [Amazon EC2 running IBM detail page](https://aws.amazon.com/partners/find/partnerdetails/?n=IBM-&id=001E000000UfakGIAR).

Q. __Can I use Amazon DevPay with Amazon EC2 running IBM?__

No, you cannot use DevPay to bundle products on top of Amazon EC2 running IBM at this time.

__Amazon EC2 running Microsoft Windows and other third-party software__

Q. __Can I use my existing Windows Server license with EC2?__

Yes you can. After you’ve imported your own Windows Server machine images using the ImportImage tool, you can launch instances from these machine images on EC2 Dedicated Hosts and effectively manage instances and report usage. Microsoft typically requires that you track usage of your licenses against physical resources such as sockets and cores and Dedicated Hosts helps you to do this. Visit the Dedicated Hosts detail page for more information on how to use your own Windows Server licenses on Amazon EC2 Dedicated Hosts.

Q. __What software licenses can I bring to the Windows environment?__

Specific software license terms vary from vendor to vendor. Therefore, we recommend that you check the licensing terms of your software vendor to determine if your existing licenses are authorized for use in Amazon EC2.

### Takeaways ###

- To auto recover an EC2 instance, create a CloudWatch alarm that monitors the
instance and automatically recovers it if it becomes impaired.

- A recovered instance is identical to the original instance, including the
instance ID, private IP addresses, Elastic IP addresses, and all instance
metadata. If the impaired instance is in a placement group, the recovered
instance runs in the placement group.

- Max of __three (3) daily recovery attempts__ on each EC2 instances.

- EBS vs local instance store as root volumes.

  Data on the root device will persist independently from the lifetime of the
  instance.

  * YES - EBS
  * NO - Local instance store.

- If you are using an Amazon EBS volume as a root partition, you will need to
set the Delete On Terminate flag to "N" if you want your Amazon EBS volume to
persist outside the life of the instance.

- C5 has 25% price/performance improvement over C4 instances.

- Maximum of 27 EBS volumes per C5 instance. Generally a max of 27 PCI devices,
which include EBS volumes and ENI. For example: since every instance has at
least 1 ENI, if you have 3 additional ENI attachments on the `c4.2xlarge`,
you can attach 24 EBS volumes to that instance.

- T2 instance credit balance does not persist after stop.

- Dense-storage instances use HDD-based instance storage which persist only for
the life of the EC2 instance. It is thus recommended that users build a degree
of redundancy (e.g. RAID 1/5/6) or use fault tolerant file systems
(e.g. HDFS and MapR-FS). Users can also back up data periodically to S3.

- Types of EBS Volumes

  Volume Type           | Drive Type  | API Name
  ----------------------|-------------|----------
  Provisioned           | SSD         | `io1`
  EBS General Purpose   | SSD         | `gp2`
  Throughput Optimized  | HDD         | `st1`
  Cold                  | HDD         | `sc1`

- While you are able to attach multiple volumes to a single instance,
attaching multiple instances to one volume is not supported at this time.

- Snapshots can be done in real time while the volume is attached and in use

- Accessing an EFS
  * Within VPC - EC2 instances can access your file system directly
  * Outside VPC:
    - EC2 Classic instances - mount your file system via
    [ClassicLink](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html).
    - On-premises servers - mount your file systems via an
    [AWS Direct Connect](https://aws.amazon.com/directconnect/) connection to your VPC.

- Amazon EFS supports one to thousands of Amazon EC2 instances connecting to a file system concurrently.

- NVMe Encryption

  * Encryption keys are unique to each NVMe instance storage device that is provided
  with an EC2 instance.

  * All keys are irrecoverably destroyed on any de-allocation of the storage,
  including instance stop and instance terminate actions.

  * Cannot be disabled.

  * Does not support integration with AWS KMS system. Customers cannot bring
  in their own keys.

- The Classic Load Balancer is ideal for simple load balancing of traffic
across multiple EC2 instances, while the Application Load Balancer is ideal
for applications needing advanced routing capabilities, microservices, and
container-based architectures.

- Amazon Linux AMI includes drivers required for Enhanced Networking by default.

- Enhanced Networking is only supported in Amazon VPC. It is not supported in EC2-Classic

- CloudWatch Metrics are received and aggregated at __1 minute intervals__.

- CloudWatch Metrics data are stored for __2 weeks__

- __Hibernate__ - RAM data gets persisted. __Stop__ - RAM is cleared.
- In both Hibernate and Stop:
  * Data from your EBS root volume and any attached EBS data volumes is persisted.
  * Private IP address remains the same
  * Elastic IP address (if applicable) remains the same.

- Stop and hibernate are available for Amazon EBS backed instances only. Local
instance storage is not persisted.

- Max hibernate duration - __60 days__.

- For EC2, you pay only for what you use. Displayed pricing is an hourly rate
but depending on which instances you choose, you pay by the hour or second
(minimum of 60 seconds) for each instance type.

- Savings Plans is a flexible pricing model that offers low prices on EC2,
Lambda and Fargate usage, in exchange for a commitment to a consistent amount
of usage (measured in $/hour) for a 1 or 3 year term.

- A Convertible Reserved Instance (RI) is a type of RI with attributes that can
be changed during the term.

- EC2 Fleet allows you to, with a single API call, provision compute capacity
across different instance types, Availability Zones and across On-Demand,
Reserved Instances (RI) and Spot Instances purchase models to help optimize
scale, performance and cost.

- Multi-region EC2 Fleets are not supported.

- On-Demand Capacity Reservation lets you reserve and manage AZs, quantity of
instances, instance type and tenancy. The reservation is held for you regardless
of whether you run the instance or not.

- A Reserved Instance (RI) is an EC2 offering that provides you with a
significant discount on EC2 usage when you commit to a one-year or three-year
term.

- RIs do not apply to Spot instances or instances running on Dedicated Hosts.
To lower the cost of using Dedicated Hosts, purchase Dedicated Host Reservations.

- You cannot sell Reserved Instances purchased from the public volume pricing tiers.

- Spot Instances are spare EC2 capacity that can save you up 90% off of
On-Demand prices that AWS can interrupt with a 2-minute notification. Spot
prices adjust gradually based on long term supply and demand for spare EC2 capacity.

- Spot Instances does not currently support paid AMI for third-party software.

- Over the last 3 months, 92% of Spot Instance interruptions were from a
customer manually terminating the instance because the application had
completed its work.

- A Spot Fleet allows you to automatically request and manage multiple Spot
instances that provide the lowest price per unit of capacity. You can include
the instance types that your application can use. You define a target capacity
based on your application needs (in units including instances, vCPUs, memory,
storage, or network throughput) and update the target capacity after the
fleet is launched.

- One Availability Zone name (for example, us-east-1a) in two AWS customer
accounts may relate to different physical Availability Zones.

- Regional Data Transfer rates apply when Public or Elastic IP addresses are
used, regardless of which Availability Zone the other instance is in.

- A cluster placement group is a logical entity that enables creating a
cluster of instances by launching instances as part of a group. The cluster of
instances then provides low latency connectivity between instances in the group.

- Cluster Compute Instances combine high compute resources with a high
performance networking for High Performance Compute (HPC) applications and other
demanding network-bound applications.

- Cluster GPU Instances give customers with HPC workloads an option beyond
Cluster Compute Instances to further benefit from the parallel computing power
of GPUs.

- High Memory Cluster Instances provide customers with large amounts of memory
and CPU capabilities per instance in addition to high network capabilities.

- Cluster Compute or Cluster GPU Instance limit
  * Cluster Compute Instance - `no limit`
  * Cluster GPU Instances - you can launch `2 Instances`

Class                 | Types
----------------------|-------------------------
General Purpose       | A, T, M
Compute Optimized     | C
Memory Optimized      | R, X, High Memory, z
Accelerated Computing | P, Inf1, G, F
Storage Optimized     | I, D, H

- The Nitro Hypervisor primarily provides CPU and memory isolation for EC2
instances. This ensures consistent performance and increased compute and memory
resources for EC2 virtualized instances by removing host system software components.

- Maximum of 27 EBS volumes per instance running on the Nitro Hypervisor
support. Generally a max of 27 PCI devices, which include EBS volumes and ENI.
For example: since every instance has at least 1 ENI, if you have 3 additional
ENI attachments on the `c4.2xlarge`, you can attach 24 EBS volumes to that instance.

- `Optimize CPUs` gives you greater control of your EC2 instances on two fronts.
  * You can specify a custom number of vCPUs when launching new instances to
  save on vCPU-based licensing costs.
  * You can disable Intel Hyper-Threading Technology (Intel HT Technology)

- You can use Optimize CPUs with only virtualized EC2 instances, but not on
bare metal instance types (such as `i3.metal`)

- You can use your existing Windows Server license with EC2, but you typically
require dedicated hosts to do this

### References ###

- [AWS EC2 FAQs](https://aws.amazon.com/ec2/faqs/)
- [AWS EC2 Instance Types](/2020/02/07/AWS_EC2-Instance-Types_curated)
- [AWS EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/)
- [AWS User Guide - EC2 Instance Recover](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-recover.html)
- [AWS EBS Features](https://aws.amazon.com/ebs/features/)
