---
path: "./2020/05/04/AWS-VPC-FAQs_curated.md"
date: "2020-05-04T20:03:19"
title: "AWS VPC FAQs - Curated"
description: "Curated FAQs on AWS VPC, plus a must read summary for quick start"
tags: ["AWS", "FAQ", "Amazon Virtual Private Cloud (VPC)", "Subnet", "Internet Gateway", "NAT Gateway", "Network Address Translation (NAT)", "Virtual private gateway", "Peering Connection", "VPC Endpoints", "Egress-only Internet Gateway", "network architecture", "VPC Connectivity", "VPC traffic", "IP Address", "Elastic IP Address", "Security Group", "Network Access Control Lists (NACL)", "VPC traffic mirroring", "VPC traffic monitoring", "VPC flow logs", "default VPC", "Elastic Network Interface (ENI)", "ClassicLink", "Privatelink", "Bring Your Own IP (BYOIP)", "VPC limits"]
lang: "en-us"
---

### Introduction ###

- This article features a curated set of FAQs on AWS VPC

- It is an estimated 20 - minute read.

- __TL;DR__ - Read the Takeaways at the end of this article.

### General ###

Q: __What is Amazon Virtual Private Cloud (VPC)__

Amazon Virtual Private Cloud (Amazon VPC) is a virtual network within AWS cloud
which you can launch AWS resources into. This virtual network closely resembles a
traditional network that you'd operate in your own data center, with the benefits of
using the scalable infrastructure of AWS. Read more about
[AWS VPC here](/2020/03/04/AWS_Virtual-Private-Cloud-VPC)

Q. __What are the components of Amazon VPC?__

- A Virtual Private Cloud: A logically isolated virtual network in the AWS cloud. You define a VPC’s IP address space from ranges you select.
- Subnet: A segment of a VPC’s IP address range where you can place groups of isolated resources.
- Internet Gateway: The Amazon VPC side of a connection to the public Internet.
- NAT Gateway: A highly available, managed Network Address Translation (NAT) service for your resources in a private subnet to access the Internet.
- Virtual private gateway: The Amazon VPC side of a VPN connection.
- Peering Connection: A peering connection enables you to route traffic via private IP addresses between two peered VPCs.
- VPC Endpoints: Enables private connectivity to services hosted in AWS, from within your VPC without using an Internet Gateway, VPN, Network Address Translation (NAT) devices, or firewall proxies.
- Egress-only Internet Gateway: A stateful gateway to provide egress only access for IPv6 traffic from the VPC to the internet

Q: __What options for network architecture are available?__

1. Amazon VPC with a single public subnet only
2. Amazon VPC with public and private subnets
3. Amazon VPC with public and private subnets and AWS Site-to-Site VPN access
4. Amazon VPC with a private subnet only and AWS Site-to-Site VPN access

### Connectivity ###

Q. __What are the connectivity options for my Amazon VPC?__

- You may connect your Amazon VPC to:
- The internet (via an internet gateway)
- Your corporate data center using an AWS Site-to-Site VPN connection (via the virtual private gateway)
- Both the internet and your corporate data center (utilizing both an internet gateway and a virtual private gateway)
- Other AWS services (via internet gateway, NAT, virtual private gateway, or VPC endpoints)
- Other Amazon VPCs (via VPC peering connections)

Q. __How do instances without public IP addresses access the Internet?__

Instances without public IP addresses can access the Internet in one of two ways:

- Instances without public IP addresses can route their traffic through a NAT gateway or a NAT instance to access the Internet. These instances use the public IP address of the NAT gateway or NAT instance to traverse the Internet. The NAT gateway or NAT instance allows outbound communication but doesn’t allow machines on the Internet to initiate a connection to the privately addressed instances.

- For VPCs with a hardware VPN connection or Direct Connect connection, instances can route their Internet traffic down the virtual private gateway to your existing datacenter. From there, it can access the Internet via your existing egress points and network security/monitoring devices.

Q. __Does traffic go over the internet when two instances communicate using public IP addresses?__

Traffic between two EC2 instances in:

- The same AWS Region stays within the AWS network, even when it goes over public IP addresses.
- Different AWS Regions stays within the AWS network, if there is an Inter-Region VPC Peering connection between the VPCs where the two instances reside.
- Different AWS Regions where there is no Inter-Region VPC Peering connection between the VPCs where these instances reside, is not guaranteed to stay within the AWS network.

Q. __Can I connect to my VPC using a software VPN?__

Yes. You may use a third-party software VPN to create a site to site or remote access VPN connection with your VPC via the Internet gateway. Amazon supports Internet Protocol Security (IPSec) VPN connections. An internet gateway is not required to establish an AWS Site-to-Site VPN connection.

### IP Addressing ###

Q: __Can I get an IPv6 Elastic IP address?__

No, Amazon VPCs do not support EIPs for IPv6 at this time.

Q. __Can I advertise my VPC public IP address range to the internet and route the traffic through my datacenter, via the AWS Site-to-Site VPN, and to my Amazon VPC?__

Yes, you can route traffic via the AWS Site-to-Site VPN connection and advertise the address range from your home network.

Q. __Can I use my public IPv4 addresses in VPC and access them over the Internet?__

Yes, you can bring your public IPv4 addresses into AWS VPC and statically allocate them to subnets and EC2 instances. To access these addresses over the Internet, you will have to advertise them to the Internet from your on-premises network. You will also have to route the traffic over these addresses between your VPC and on-premises network using AWS DX or AWS VPN connection. You can route the traffic from your VPC using the Virtual Private Gateway. Similarly, you can route the traffic from your on-premises network back to your VPC using your routers.

Q. __How large of a VPC can I create?__

Amazon VPC supports

- five (5) IP address ranges, one (1) primary and four (4) secondary for IPv4.

- A max of 200 subnets per VPC

- The minimum size of a subnet is a /28 (or 14 IP addresses.) for IPv4. Subnets cannot be larger than the VPC in which they are created. For IPv6, the subnet size is fixed to be a /64. Only one IPv6 CIDR block can be allocated to a subnet.

Q. __Can I use all the IP addresses that I assign to a subnet?__

No. Amazon reserves the first four (4) IP addresses and the last one (1) IP address of every subnet for IP networking purposes.

Q. __Can I assign multiple IP addresses to an instance?__

Yes. You can assign one or more secondary private IP addresses to an Elastic Network Interface or an EC2 instance in Amazon VPC, depending on the instance type.

Q. __Can I assign one or more Elastic IP (EIP) addresses to VPC-based Amazon EC2 instances?__

Yes, however, the EIP addresses will only be reachable from the Internet (not over the VPN connection). Each EIP address must be associated with a unique private IP address on the instance. EIP addresses should only be used on instances in subnets configured to route their traffic directly to the Internet gateway. EIPs cannot be used on instances in subnets configured to use a NAT gateway or a NAT instance to access the Internet. This is applicable only for IPv4. Amazon VPCs do not support EIPs for IPv6 at this time.

### Security and Filtering ###

Q. __How do I secure Amazon EC2 instances running within my VPC?__

Amazon EC2 security groups can be used to help secure instances within an Amazon VPC. Security groups in a VPC enable you to specify both inbound and outbound network traffic that is allowed to or from each Amazon EC2 instance. Traffic which is not explicitly allowed to or from an instance is automatically denied.
In addition to security groups, network traffic entering and exiting each subnet can be allowed or denied via network Access Control Lists (ACLs).

Q. __What are the differences between security groups in a VPC and network ACLs in a VPC?__

          | Security Group | Network ACL
----------|----------------|----------------          
Level     | EC2 Instance   | Subnet
Filtering | Stateful       | Stateless
Rules     | Deny Automatic | Explicit allow and deny required

Stateful - If you allow incoming, then outgoing will be allowed for the same incoming traffic rule. Stateful filtering automatically allows the reply to the request to be returned to the originating computer.

[See this link for more details](/2020/03/04/AWS_Virtual-Private-Cloud-VPC)

Q. __Can Amazon EC2 instances within a VPC communicate with Amazon EC2 instances not within a VPC?__

Yes. Requires either an internet gateway or a virtual private gateway.

Q. __Can Amazon EC2 instances within a VPC in one region communicate with Amazon EC2 instances within a VPC in another region?__

Yes. Using Inter-Region VPC Peering, public IP addresses, NAT gateway, NAT instances, VPN Connections or Direct Connect connections.

Q. __Can Amazon EC2 instances within a VPC communicate with Amazon S3?__

Yes. There are multiple options:

- VPC Endpoint for S3 - All traffic remains within Amazon's network and enables you to apply additional access policies to your Amazon S3 traffic.
- Internet gateway - Enable Internet access from your VPC and instances in the VPC can communicate with Amazon S3.
- Direct Connect or VPN connection, egress from your datacenter

Q. __Can I monitor the network traffic in my VPC?__

Yes. You can use `Amazon VPC traffic mirroring` and `Amazon VPC flow logs` features.

### VPC Traffic Mirroring ###

Q. __What is Amazon VPC traffic mirroring?__

>Amazon VPC traffic mirroring makes it easy for customers to replicate network traffic to and from an Amazon EC2 instance and forward it to out-of-band security and monitoring appliances for use-cases such as content inspection, threat monitoring, and troubleshooting. These appliances can be deployed on an individual EC2 instance or a fleet of instances behind a Network Load Balancer (NLB) with User Datagram Protocol (UDP) listener.

Q. __Which resources can be monitored with Amazon VPC traffic mirroring ?__

Traffic mirroring supports network packet captures at the Elastic Network Interface (ENI) level for EC2 instances. This feature is currently supported on all virtualized Nitro based EC2 instances.

Q. __How is Amazon VPC traffic mirroring different from Amazon VPC flow logs?__

- __Amazon VPC flow logs__ - Information captured in flow logs includes information about `allowed and denied traffic, source and destination IP addresses, ports, protocol number, packet and byte counts, and an action (accept or reject)`. You can use this feature to troubleshoot connectivity and security issues and to make sure that the network access rules are working as expected.

- __Amazon VPC traffic mirroring__ - provides deeper insight by allowing you to analyze `actual traffic content, including payload`, and is targeted for use-cases when you need to analyze the actual packets to determine the root cause a performance issue, reverse-engineer a sophisticated network attack, or detect and stop insider abuse or compromised workloads.

### Amazon VPC and EC2 ###

Q. __Can a VPC span multiple Availability Zones?__

Yes.

Q. __Can a subnet span Availability Zones?__

No. A subnet must reside within a single Availability Zone.

Q. __How do I specify which Availability Zone my Amazon EC2 instances are launched in?__

When you launch an Amazon EC2 instance, you must specify the subnet in which to launch the instance. The instance will be launched in the Availability Zone associated with the specified subnet.

Q. __How do I determine which Availability Zone my subnets are located in?__

When you create a subnet you must specify the Availability Zone in which to place the subnet. If you don’t specify an Availability Zone, the subnet will be created in an available Availability Zone in the region.

Q. __Am I charged for network bandwidth between instances in different subnets?__

If the instances reside in subnets in different Availability Zones, you will be charged __$0.01 per GB__ for data transfer.

Q. __How many Amazon EC2 instances can I use within a VPC?__
You can run any number of Amazon EC2 instances within a VPC, so long as your VPC is appropriately sized to have an IP address assigned to each instance. You are initially limited to launching 20 Amazon EC2 instances at any one time and a maximum VPC size of /16 (65,536 IPs). If you would like to increase these limits, please [complete the following form](http://aws.amazon.com/contact-us/vpc-request/).

Q. __Can I use my existing AMIs in Amazon VPC?__

You can use AMIs in Amazon VPC that are registered within the same region as your VPC.

Q. __Can I use my existing Amazon EBS snapshots?__

Yes, you may use Amazon EBS snapshots if they are located in the same region as your VPC.

Q: __Can I boot an Amazon EC2 instance from an Amazon EBS volume within Amazon VPC?__

Yes, however, an instance launched in a VPC using an Amazon EBS-backed AMI maintains the same IP address when stopped and restarted. This is in contrast to similar instances launched outside a VPC, which get a new IP address. The IP addresses for any stopped instances in a subnet are considered unavailable.

### Default VPCs ###

Q. __Can I specify which VPC is my default VPC?__

Not at this time.

Q. __Can I specify which subnets are my default subnets?__

Not at this time.

Q. __Can I delete a default VPC?__

Yes, you can delete a default VPC. Once deleted, you can create a new default VPC.

Q. __Can I delete a default subnet?__

Yes, you can delete a default subnet. Once deleted, you can create a new
default subnet in the availability zone.

### Elastic Network Interface ###

Q. __Can I attach a network interface in one Availability Zone to an instance
in another Availability Zone?__

Network interfaces can only be attached to instances residing in the same
Availability Zone.

Q. __Can I attach a network interface in one VPC to an instance in another VPC?__

Network interfaces can only be attached to instances in the same VPC as the interface.

Q. __Can I use Elastic Network Interfaces as a way to host multiple websites requiring separate IP addresses on a single instance?__

Yes, however, this is not a use case best suited for multiple interfaces. Instead, assign additional private IP addresses to the instance and then associate EIPs to the private IPs as needed.

Q. __Will I get charged for an Elastic IP Address that is associated to a network interface but the network interface isn’t attached to a running instance?__

Yes.

Q. __Can I detach the primary interface (eth0) on my EC2 instance?__

No. You can attach and detach secondary interfaces (eth1-ethn) on an EC2 instance, but you can’t detach the eth0 interface.

### Peering Connections ###

Q: __What is VPC Peering?__

With __VPC Peering__ you connect your VPC to another VPC. Both VPC owners are
involved in setting up this connection. When one VPC, (the visiting) wants
to access a resource on the other (the visited), the connection need not
go through the internet. [Click here for more on VPC Peering](/2020/04/02/AWS_VPC-peering_vs_PrivateLink)

Q. __Can I peer two VPCs with matching IP address ranges?__

No. Peered VPCs must have non-overlapping IP ranges.

Q. __Can I use AWS Direct Connect or hardware VPN connections to access VPCs I’m peered with?__

No. “Edge to Edge routing” isn’t supported in Amazon VPC. Refer to the VPC Peering Guide for additional information.

Q. __Is VPC peering traffic within the region encrypted?__

No. Traffic between instances in peered VPCs remains private and isolated – similar to how traffic between two instances in the same VPC is private and isolated.

Q. __Is Inter-Region VPC Peering traffic encrypted?__

Traffic is encrypted using modern AEAD (Authenticated Encryption with Associated Data) algorithms. Key agreement and key management is handled by AWS.

Q. __How do DNS translations work with Inter-Region VPC Peering?__

By default, a query for a public hostname of an instance in a peered VPC in a different region will resolve to a public IP address. Route 53 private DNS can be used to resolve to a private IP address with Inter-Region VPC Peering.

Q. __Can I reference security groups across an Inter-Region VPC Peering connection?__

No. Security groups cannot be referenced across an Inter-Region VPC Peering connection.

Q. __Does Inter-Region VPC Peering support with IPv6?__

Yes. Inter-Region VPC Peering supports IPv6.

Q. __Can Inter-Region VPC Peering be used with EC2-Classic Link?__

No. Inter-Region VPC Peering cannot be used with EC2-ClassicLink.

### ClassicLink ###

Q. __What is ClassicLink?__

Amazon Virtual Private Cloud (VPC) ClassicLink allows EC2 instances in the EC2-Classic platform to communicate with instances in a VPC using private IP addresses.

Q. __Can traffic from an EC2-Classic instance travel through the Amazon VPC and egress through the Internet gateway, virtual private gateway, or to peered VPCs?__

Traffic from an EC2-Classic instance can only be routed to private IP addresses within the VPC. They will not be routed to any destinations outside the VPC, including Internet gateway, virtual private gateway, or peered VPC destinations.

### Private Link ###

Q: __What is AWS PrivateLink?__

__PrivateLink__ provides a convenient way to connect to applications/services
by name with added security. You configure your application/service in your
VPC as an AWS PrivateLink-powered service (referred to as an endpoint service).
AWS generates a specific DNS hostname for the service. Other AWS principals
can create a connection to your endpoint service after you grant them permission.
[Click here for more on PrivateLink](/2020/04/02/AWS_VPC-peering_vs_PrivateLink)

Q. __Which services are currently available on AWS PrivateLink?__

The following AWS services support this feature: Amazon Elastic Compute Cloud (EC2), Elastic Load Balancing (ELB), Kinesis Streams, Service Catalog, EC2 Systems Manager, Amazon SNS, and AWS DataSync.

Q. __Can I privately access services powered by AWS PrivateLink over AWS Direct Connect?__

Yes. The application in your on-premises can connect to the service endpoints in Amazon VPC over AWS Direct Connect. The service endpoints will automatically direct the traffic to AWS services powered by AWS PrivateLink.

Q. __What CloudWatch metrics are available for the interface-based VPC endpoint?__

Currently, no CloudWatch metric is available for the interface-based VPC endpoint.

### Bring Your Own IP ###

Q. __What is the Bring Your Own IP feature?__

Bring Your Own IP (BYOIP) enables customers to move all or part of their existing publicly routable IPv4 or IPv6 address space to AWS for use with their AWS resources

Q. __In which AWS Regions is BYOIP available?__

The feature is currently available in the US-East (N.Virginia), US-East (Ohio), US-West (Oregon), EU (Dublin), EU (London), EU (Frankfurt), Canada (Central), Asia Pacific (Mumbai), Asia Pacific (Sydney), Asia Pacific (Tokyo), Asia Pacific (Singapore) and South America (Sao Paulo) AWS Regions.

Q. __Can I bring a reassigned or reallocated prefix?__

We are not accepting reassigned or reallocated prefixes at this time. IP ranges should be a net type of direct allocation or direct assignment.

Q. __How many VPCs, subnets, Elastic IP addresses, and internet gateways can I create?__

- Five Amazon VPCs per AWS account per region
- Two hundred subnets per Amazon VPC
- Five Amazon VPC Elastic IP addresses per AWS account per region
- One internet gateway per Amazon VPC
See the [Amazon VPC user guide](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Appendix_Limits.html)
for more information on VPC limits.

### Takeaways ###

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

- You can't create a peering connection between two VPCs with matching IP address ranges?

- You cannot use AWS Direct Connect or hardware VPN connections to access VPCs you are peered with. “Edge to Edge routing” isn’t supported in Amazon VPC. Refer to the VPC Peering Guide for additional information.

- You can privately access services powered by AWS PrivateLink over AWS Direct Connect. The application in your on-premises can connect to the service endpoints in Amazon VPC over AWS Direct Connect. The service endpoints will automatically direct the traffic to AWS services powered by AWS PrivateLink.

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

- Currently, EC2 instances, NAT Gateways, and Network Load Balancers support EIPs.
https://aws.amazon.com/vpc/faqs/

- BYOIP is currently available only in the US-East (N.Virginia), US-East (Ohio), US-West (Oregon), EU (Dublin), EU (London), EU (Frankfurt), Canada (Central), Asia Pacific (Mumbai), Asia Pacific (Sydney), Asia Pacific (Tokyo), Asia Pacific (Singapore) and South America (Sao Paulo) AWS Regions.

- Some VPC limits

  * Five (5) Amazon VPCs per AWS account per region

  * Two hundred (200) subnets per Amazon VPC

  * Five Amazon (5) VPC Elastic IP addresses per AWS account per region

  * One (1) internet gateway per Amazon VPC

### References ###

- [AWS VPC](/2020/03/04/AWS_Virtual-Private-Cloud-VPC)

- [AWS VPC FAQs](https://aws.amazon.com/vpc/faqs/)

- [AWS - VPC Peering vs PrivateLink](/2020/04/02/AWS_VPC-peering_vs_PrivateLink)
