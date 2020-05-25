---
path: "./2020/05/20/AWS-FAQs-Answers-to-Tricky-Questions-you-didnt-know.md"
date: "2020-05-20T22:07:42"
title: "AWS FAQs - Answers to Tricky Questions you didn't know"
description: "Answers to Tricky AWS FAQs you didn't know"
tags: ["AWS", "FAQ", "EC2", "VPC", "hibernate", "stop", "VPC traffic", "peering"]
lang: "en-us"
---

### EC2 ###

- If you are using an Amazon EBS volume as a root partition, you will need to
set the Delete On Terminate flag to "N" if you want your Amazon EBS volume to
persist outside the life of the instance.

- A recovered instance is identical to the original instance, including the
instance ID, private IP addresses, Elastic IP addresses, and all instance
metadata. If the impaired instance is in a placement group, the recovered
instance runs in the placement group.

- T2 instance credit balance does not persist after stop.

- __Hibernate__ vs __Stop__

  * `Hibernate` - RAM data gets persisted. `Stop` - RAM is cleared.
  * In both Hibernate and Stop:
    - Data from your EBS root volume and any attached EBS data volumes is persisted.
    - Private IP address remains the same
    - Elastic IP address (if applicable) remains the same.

- Multi-region EC2 Fleets are not supported.

- One Availability Zone name (for example, us-east-1a) in two AWS customer
accounts may relate to different physical Availability Zones.

- Regional Data Transfer rates apply if at least one of the following is true,
but is only charged once for a given instance even if both are true:

  * The other instance is in a different Availability Zone, regardless of which
  type of address is used.
  * Public or Elastic IP addresses are used, regardless of which Availability
  Zone the other instance is in.

### VPC ###

- Traffic between two EC2 instances in:

  * The same AWS Region stays within the AWS network, even when it goes over
  public IP addresses.
  * Different AWS Regions stays within the AWS network, if there is an
  Inter-Region VPC Peering connection between the VPCs where the two instances reside.
  * Different AWS Regions where there is no Inter-Region VPC Peering connection
  between the VPCs where these instances reside, is not guaranteed to stay
  within the AWS network.

- Amazon VPCs do not support EIPs for IPv6 at this time.

- For IP addresses you assign to a subnet, amazon reserves the first four (4) IP
addresses and the last one (1) IP address of every subnet for IP networking purposes.

- A subnet must reside within a single Availability Zone.

- In a VPC, you can only use AMIs registered within the same region as the VPC.

- In a VPC, you can only use EBS snapshots located in the same region as the VPC.

- An instance launched in a VPC using an Amazon EBS-backed AMI maintains the
same IP address when stopped and restarted. This is in contrast to similar
instances launched outside a VPC, which get a new IP address. The IP addresses
for any stopped instances in a subnet are considered unavailable.

- You can't specify the default VPC or subnet. However you can delete both the
default VPC and subnet.

- You can’t detach the primary (eth0) network interface, but you can attach
and detach secondary interfaces.

- Network interfaces can only be attached to instances residing in the same
VPC and Availability Zone as the interface.

- You can't create a peering connection between two VPCs with matching IP
address ranges?

- You cannot use AWS Direct Connect or hardware VPN connections to access VPCs
you are peered with. “Edge to Edge routing” isn’t supported in Amazon VPC.
Refer to the VPC Peering Guide for additional information.

- You can privately access services powered by AWS PrivateLink over AWS Direct
Connect. The application in your on-premises can connect to the service endpoints
in Amazon VPC over AWS Direct Connect. The service endpoints will automatically
direct the traffic to AWS services powered by AWS PrivateLink.

- Within a region, traffic within a VPC as well as between VPCs are private and
isolated but not encrypted.

- Between 2 regions, Traffic is encrypted using modern AEAD (Authenticated
Encryption with Associated Data) algorithms. Key agreement and key management
is handled by AWS.

- VPC peering is not transitive.

- Traffic from an EC2-Classic instance can only be routed to private IP addresses
within the VPC. They will not be routed to any destinations outside the VPC,
including Internet gateway, virtual private gateway, or peered VPC destinations.

- CloudWatch metrics are not currently available for the interface-based VPC endpoint.

### CloudFront ###

- Amazon CloudFront works with non-AWS origin servers

- `Geo Restriction` feature lets you specify a whitelist or blacklist of
countries for accessing your content via CloudFront.

- To remove an item from CloudFront edge locations, simply delete the file from
your origin and as content in the edge locations reaches the expiration period
defined in each object’s HTTP header, it will be removed. In the event that
content needs to be removed before the specified expiration time, you can use
the `Invalidation API`.

- Amazon CloudFront is compliant with:

  * Payment Card Industry Data Security Standard (PCI DSS) Merchant Level 1
  * HIPAA
  * System & Organization Control (SOC) measures

- Amazon CloudFront currently supports GET, HEAD, POST, PUT, PATCH, DELETE and
OPTIONS requests.

- Amazon CloudFront does not cache the responses to POST, PUT, DELETE, and PATCH
requests

- CloudFront supports HTTP/2 only over an encrypted connection.

- Amazon CloudFront has an optional private content feature. When this option
is enabled, Amazon CloudFront will only deliver files when you say it is okay
to do so by securely signing your requests.

- With CloudFront caching, you can:

  * Modify, add request headers forwarded to origin server

  * Specify whether you want Amazon CloudFront to forward some or all of your
  cookies to your custom origin server.

  * Specify which query parameters are used in the cache key

  * You can configure Amazon CloudFront to whitelist up to 10 query parameters.

  * Amazon CloudFront support video-on-demand (VOD) streaming protocols

- The maximum size of a single file that can be delivered through Amazon
CloudFront is __20 GB__.

- [Lambda@Edge](https://aws.amazon.com/lambda/edge/) allows you to run code at
global AWS edge locations without provisioning or managing servers, responding
to end users at the lowest network latency.

- Four (4) events can be triggered with Amazon CloudFront: Viewer request,
Viewer response, Origin request, Origin response.

  View   `- viewer request ->`   CloudFront   `- origin request ->`   Origin Server

  View   `<- viewer response -`   CloudFront   `<- origin response -`   Origin Server

- `Price Classes` enable you reduce your delivery prices by excluding Amazon CloudFront’s more expensive edge locations from your Amazon CloudFront distribution.

### EFS vs FSx ###

NFS - Network File System
SMB - Server Message Block - a protocol
NTFS - New Technology File System

Property   |      EFS           | FSx
-----------|--------------------|------------------------------------
File Sys   | NFSv4              | SMB server with NTFS based storage
Latency    | Low latency        | Sub-millisecond latencies
Throughput | 10 GB/sec          | Up to hundreds GB/sec
IOPs       | greater than 500k  | Millions

### Security ###

An option in the answers could suggest using WAF against DDoS, or AWS Shield
mitigate SQL injection attacks - Wrong and wrong again.

- AWS Shield - Provides protection against DDoS. Standard version of Shield implemented automatically on all AWS accounts.

- Web Application Firewall - Sits in front of your website to provide additional protection against common attacks such as SQL injection and XSS.
