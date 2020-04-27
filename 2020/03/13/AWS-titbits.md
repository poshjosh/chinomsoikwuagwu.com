---
path: "./2020/03/13/AWS-Titbits.md"
date: "2020-03-13"
title: "AWS Titbits"
description: "Game changing tips, for AWS Certified Cloud Architect certification"
lang: "en-us"
---

### Acronyms ###

- S3 - Simple Storage Service
- S3 Standard IA - S3 Standard Infrequent Access
- DNS - Domain Name Server
- VPC - Virtual Private Cloud
- CDN - Content Delivery Network
- ELB - Elastic Load Balancer
- EC2 - Elastic Cloud Compute
- CIDR - Class Inter-Domain Routing
- ENI - Elastic Network Interface
- IP - Internet Protocol
- NACL - Network Access Control List

### This is not an Introduction ###

Hi, this article contains game changing tips for those who would like to get
AWS Certified Cloud Architect certified. It is not an introduction to AWS or
any of the core concepts of the AWS Cloud. In order words, if you are not
familiar with the AWS cloud, you need to read the series of articles beginning
at [AWS Certified Solutions Architect Associate - Part 1](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-1_Key-services-relating-to-the-Exam)

### Best Practices ###

- [To deploy recommeded best practice VPC](https://docs.aws.amazon.com/quickstart/latest/vpc/architecture/)

### Storage ###

- S3 buckets are located in the AWS cloud not our VPC. So, when you want to access
s3 bucket objects from an EC2 instance in your VPC, create a VPC endpoint to allow
traffic flow in and out of our VPC.

__AWS S3 Bucket__

- S3 Bucket names must be unique across the existing buckets for entire AWS Cloud. Names must also be DNS compliant.

- Default max amount of bucket is 100

- Default max amount of objects in bucket is infinity (theoritically)

- S3 Storage Classes. From most expensive at the top to least expensive.

  - S3 Standard
  - S3 Infrequent Access (IA)
  - S3 Reduced Redundancy Storage (RRS)
  - S3 Glacier

- S3 Storage Differences

  - S3 standard . Durability - 99.999999999% . Availability - 99.99%
  - S3 standard IA . Durability - 99.999999999% . Availability - 99.9%
  - S3 One Zone IA . Durability - 99.999999999% . Availability - 99.5%

- Though glacier is the least expensive, if accessed frequently then the price
shoots up due to the access charge.

- __Object Lifecycle Management__. The standard is to add info to S3 Standard,
migrate to S3 IA after some months and further move the data to Glacier after
some months.

- After uploading files to an AWS s3 bucket, if you change the __bucket permission__,
the existing files/directories inside the bucket will not be affected by the
update.

Once versioning is turned on you can only suspend it for new S3 objects.

- __Cross region Replication__. Replicate data across S3 buckets in different
regions. When enabled it doesn’t replicate existing data but newly added data.

- S3 bucket object duration is specified at creation time.

- Minimum size of an s3 bucket object is 0 bytes. You can add a zero byte file.

- __Eventual consistency__. S3 objects have eventual consistency while Elastic
Block Store (EBS) objects are consistent. Eventual consistency means there is a
lag between when a new state is introduced on one location (originating location)
and when the new state becomes consistent with redundant locations

__EBS__

- EBS Volume Types:

  * Magnetic, slowest, cheapest
    - Standard (54 rpm like in computer hard drive)
    - Throughput optimized (10k rpm +)
  * SSD
    - General Purpose
    - Provisioned IOPS

- Generally
  * Cold Hard Disk Drive - (Really large and really slow)
  * Throughput Optimized - (Potentially large, really fast) e.g 10000+ rpm
  * Magnetic Standard - (Middle of the road) like a typical 5400rmp hard drive
  found in local computers
  * If you use SSD, to take advantage of the additional performance, you need
  an EBS optimized instance.

__Elastic File System (EFS)__

- EFS is not supported on windows instances. For windows instances, create an
EBS volume and use shared folders from the windows instance itself.

__General__

- Any scenario requiring greater than 10k IOPs use provisioned SSD.

### Networking & Content Delivery ###

- Use CDN (AWS CloudFront)for content which does not change often which needs
to be delivery with high speed and low latency e.g images, videos.

- For other requests, CloudFront forwards to ELB which forwards to EC2 instance

__Regions and Zones__

- A __Local Zone__ is an extension of a Region that is in a
different location from your Region. It provides you the ability to place
resources, such as compute and storage, in multiple locations closer to your
end users. It provides a high-bandwidth backbone to the AWS infrastructure and
is ideal for latency-sensitive applications, for example machine learning.

- Note that there is a charge for data transfer between Regions.

- __Note__ The AZ `us-east-1a` for your AWS account might not be the same
location as `us-east-1a` for another AWS account. This is because, AWS ensures
that resources are distributed across the AZs by _independently mapping AZs to
names for each AWS account_.

- To coordinate AZs across accounts, you must use the AZ ID, which is a unique
and consistent identifier for an Availability Zone. For example, `use1-az1` is
an AZ ID for the `us-east-1` Region and it has the same location in every AWS
account.

A __network border group__ is a unique set of Availability Zones or Local Zones
from where AWS advertises IP addresses. You can allocate the following resources
from a network border group:

- Elastic IPv4 addresses that Amazon provides

- IPv6 Amazon-provided VPC addresses

A network border group limits the addresses to the group. IP addresses cannot
move between network border groups.

### IP addresses ###

- A `Public IP address` is how you are identified from the internet.

- A `Private IP address` is how you are identified from within a private network.

- IP addresses could be static or dynamic.

- A `Static IP address` once assigned to you is not changed. On the other hand,
a dynamic IP address may be changed by the provider each day, per session etc

- In AWS, you cannot reuse a public IPv4 address, and you cannot convert a public
IPv4 address to an Elastic IP address.

- An `Elastic IP address` is a public static IPv4 address. It is termed `elastic`
because you can remap the address to another instance in the event of a failure.

- While your instance is running, you are not charged for one Elastic IP
address, but you are charged for any additional Elastic IP addresses associated
with the instance.

- Elastic IP addresses incur a small hourly bill if not associated with a
running instance, or if associated with a stopped instance or an unattached
network interface.

- You can bring part or all of your public IPv4 address range from your
on-premises network to your AWS account. You continue to own the address range,
but AWS advertises it on the internet.

- IPv6 addresses are public and reachable over the Internet.

### NAT Gateways ###

- Use NAT gateway to enable instances in a private subnet connect to the internet
or other AWS services, but prevent te internet from initiating a connection to
those instances.

- __NAT gateways are not supported for IPv6 traffic__  — use an outbound-only (egress-only)
internet gateway instead. For more information, see Egress-Only Internet Gateways.

- Each NAT gateway is created in a specific Availability Zone and implemented with
redundancy in that zone.

- __BEST PRACTICE__: Create a NAT gateway in each Availability Zone and
configure your routing to ensure that resources use the NAT gateway in the same
Availability Zone.

### Elastic Network Interface ###

- Every instance in a VPC has a default network interface, called the
__primary network interface (eth0)__. You cannot detach a primary network interface
from an instance. You can create and attach additional network interfaces.

- __You can't detach the primary network interface (eth0).__

- __Attaching from same subnet causes conflict__ If you attach two or more network
interfaces from the same subnet to an instance, you may encounter networking issues
such as asymmetric routing. If possible, use a secondary private IPv4 address on
the primary network interface instead.

- When you create a network interface, it inherits the public IPv4 addressing
attribute from the subnet. If you later modify the public IPv4 addressing attribute
of the subnet, the network interface keeps the setting that was in effect when it
was created.

- __Hot, warm, cold attaching of eni.__ You can attach a network interface to an
instance when it's running (hot attach), when it's stopped (warm attach), or
when the instance is being launched (cold attach).

- __You can move a network interface from one instance to another__, if the
instances are in the same Availability Zone and VPC but in different subnets.

- Attaching another network interface to an instance does not increase or double
the network bandwidth to or from the dual-homed instance.

### NACL ###

You can associate a network ACL with multiple subnets. However, a subnet can be associated with only one network ACL at a time. When you associate a network ACL with a subnet, the previous association is removed

### References ###

- [AWS Certified Solutions Architect Associate - Part 1](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-1_Key-services-relating-to-the-Exam)

- [AWS Certified Solutions Architect Associate - Part 3 - Storage Services](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-3_Storage-services)
