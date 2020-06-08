---
path: "./2020/06/08/Amazon-Virtual-Private-Cloud-Connectivity-Options.md"
date: "2020-06-08T11:37:00"
title: "Amazon Virtual Private Cloud Connectivity Options"
description: "Amazon Virtual Private Cloud Connectivity Options"
tags: ["AWS", "Virtual Private Cloud (VPC)", "VPC Connectivity", "Network-to-Amazon VPC connectivity options", "AWS Managed VPN", "AWS Transit Gateway + VPN", "AWS Direct Connect", "AWS Direct Connect + AWS Transit Gateway", "AWS Direct Connect + VPN", "AWS Direct Connect + AWS Transit Gateway + VPN", "AWS VPN CloudHub", "Software Site-to-Site VPN", "Amazon VPC-to-Amazon VPC connectivity options", "VPC peering", "AWS Transit Gateway", "Software Site-to-Site VPN", "Software VPN-to-AWS Managed VPN", "AWS Managed VPN", "AWS PrivateLink", "Software remote access-to-Amazon VPC connectivity options", "AWS Client VPN", "Software client VPN", "Transit VPC option", "VPN Monitoring", "Setting up a Site-to-Site VPN"]
lang: "en-us"
---

### Introduction ###

Amazon VPC provides multiple network connectivity options. You select one or
more depending on your network design and requirements. You also have the
option to choose either AWS managed or user-managed network equipment and routes.
The following network connectivity options will be considered:

-    __Network-to-Amazon VPC connectivity options__

    *    __AWS Managed VPN__ – Describes establishing a VPN connection from your network equipment on a remote network to AWS managed service attached to your Amazon VPC.

    *    __AWS Transit Gateway + VPN__ – Describe establishing a VPN connection from your network equipment on a remote network to a regional network hub for Amazon VPCs, using AWS Transit Gateway.

    *    __AWS Direct Connect__ - Describes establishing a private, logical connection from your remote network to Amazon VPC, using AWS Direct Connect.

    *    __AWS Direct Connect + AWS Transit Gateway__ – Describes establishing a private, logical connect from your remote network to a regional network hub for Amazon VPCs, using AWS Direct Connect and AWS Transit Gateway.

    *    __AWS Direct Connect + VPN__ – Describes establishing a private, encrypted connection from your remote network to Amazon VPC, using AWS Direct Connect.

    *    __AWS Direct Connect + AWS Transit Gateway + VPN__ – Describes establishing a private, encrypted connection from your remote network to a regional network hub for Amazon VPCs, using AWS Direct Connect and AWS Transit Gateway.

    *    __AWS VPN CloudHub__ – Describes establishing a hub-and-spoke model for connecting remote branch offices.

    *    __Software Site-to-Site VPN__ – Describes establishing a VPN connection from your equipment on a remote network to a user-managed software VPN appliance running inside an Amazon VPC.

-    __Amazon VPC-to-Amazon VPC connectivity options__

    *    __VPC peering__ – Describes connecting Amazon VPCs within and across regions using the Amazon VPC peering feature.

    *    __AWS Transit Gateway__ – Describes connecting Amazon VPCs within and across regions using AWS Transit Gateway in a hub-and-spoke model.

    *    __Software Site-to-Site VPN__ – Describes connecting Amazon VPCs using VPN connections established between user-managed software VPN appliances running inside of each Amazon VPC.

    *    __Software VPN-to-AWS Managed VPN__ – Describes connecting Amazon VPCs with a VPN connection established between a user-managed software VPN appliance in one Amazon VPC and AWS managed VPN attached to the other Amazon VPC.

    *    __AWS Managed VPN__ – Describes connecting Amazon VPCs with VPN connections between your remote network and each of your Amazon VPCs.

    *    __AWS PrivateLink__ – Describes connecting Amazon VPCs with VPC interface endpoints and VPC endpoint services.

-    __Software remote access-to-Amazon VPC connectivity options__

    *    __AWS Client VPN__ – Describes connecting software remote access to Amazon VPC, leveraging AWS Client VPN.

    *    __Software client VPN__ – Describes connecting software remote access to Amazon VPC, leveraging user-managed software VPN appliances.

-    __Transit VPC option__

    *    Describes establishing a global transit network on AWS using a software VPN in conjunction with an AWS-managed VPN.

### Network-to-VPC connectivity options ###

- conn - Connection
- eqpt - equipment
- TGW - Transit Gateway
- HA - High Availability

Use non-overlapping IP ranges for each network being connected.

Option          | Use case | Advantages | Limitations
----------------|----------|------------|-----------
AWS Managed VPN | IPSEC conn `via internet` to `single VPC` | Reuse existing eqpt & internet conn        | Depends on internet conditions
                |                                           | Supports static routes/dynamic BGP peering | Customer device must support single hop BGP for dynamic routing
                |                                           |                                     | Customer managed endpoint is responsible for redundancy and failover (if required)  
AWS TGW + VPN   | IPSEC conn `via internet` to regional router for `multiple VPCs` | Same as AWS Managed VPN + up to 5k attachments | Same as AWS Managed VPN
Direct Connect  | Dedicated network over private lines | More predictable network performance | May require additional telecom and hosting provider relationships or network circuits
                |                                      | Reduced bandwidth costs |     
                |                                      | Supports BGP peering and routing policies |
AWS VPN CloudHub| Hub-and-spoke model | Reuse existing eqpt & internet conn | Depends on internet conditions
                | Primary or backup conn to remote branch offices | Supports BGP for exchanging routes and routing priorities | Customer managed branch endpoints
Software VPN    | Software appliance-based; `via internet` | Supports a wider array of VPN vendors, products, and protocols | Customer responsible for HA of endpoints (if required)

All VPN connection
Provides IPSEC connectivity
Can reuse existing eqpt & internet conn
Connection over internet
Support BGP for dynamic routing etc
Customer responsible for implementing redundancy and failover


__AWS Managed VPN__

- __AWS Managed VPN (single user gateway)__
<br/>![AWS Managed VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image2.png)
<br/>_AWS Managed VPN (single user gateway). Source: docs.aws.amazon.com_

  With multiple user gateway connections as shown below, you can implement
  redundancy and failover on your side of the VPN connection:

- __AWS Managed VPN (multiple user gateways)__
<br/>![AWS Managed VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image3.png)
<br/>_AWS Managed VPN (multiple user gateway). Source: docs.aws.amazon.com_

  When you use BGP, both the IPSec and the BGP connections must be terminated on
  the same user gateway device, so it must be capable of terminating both IPSec
  and BGP connections.

__AWS Transit Gateway + VPN__

- __AWS Transit Gateway + VPN (single customer gateway)__
<br/>![AWS Transit Gateway + VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image4.png)
<br/>_AWS Transit Gateway + VPN (single customer gateway). Source: docs.aws.amazon.com_

  With multiple user gateway connections as shown below, you can implement
  redundancy and failover on your side of the VPN connection:

- __AWS Transit Gateway + VPN (multiple customer gateways)__
<br/>![AWS Transit Gateway + VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image5.png)
<br/>_AWS Transit Gateway + VPN (multiple customer gateway). Source: docs.aws.amazon.com_

  When you use BGP, both the IPSec and the BGP connections must be terminated on
  the same user gateway device, so it must be capable of terminating both IPSec
  and BGP connections.

__AWS Direct Connect__

- __AWS Direct Connect (single customer connection)__
<br/>![AWS Direct Connect with single customer connection](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image6.png)
<br/>_AWS Direct Connect (single customer connection). Source: docs.aws.amazon.com_

  With multiple connections as shown below, you can implement
  redundancy and failover on your side of the VPN connection:

- __AWS Direct Connect (multiple customer connections)__
<br/>![AWS Direct Connect with multiple customer connections](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image7.png)
<br/>_AWS Direct Connect (multiple customer connections). Source: docs.aws.amazon.com_

  >AWS Direct Connect lets you establish 1 Gbps or 10 Gbps dedicated network
  connections (or multiple connections) between AWS networks and one of the AWS
  Direct Connect locations. You can also work with your provider to create sub-1G
  connection or use link aggregation group (LAG) to aggregate multiple 1 gigabit
  or 10 gigabit connections at a single AWS Direct Connect endpoint, allowing
  you to treat them as a single, managed connection.

- __AWS Direct Connect gateway__
<br/>![AWS Direct Connect gateway](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image8.png)
<br/>_AWS Direct Connect gateway. Source: docs.aws.amazon.com_

  __Use case__: Connections to `multiple VPCs across different regions or AWS accounts`.
  It allows you to connect to any participating VPCs from one private VIF,
  reducing Direct Connect management, as shown in the following figure.


__AWS Direct Connect + AWS Transit Gateway__

- __AWS Direct Connect + AWS Transit Gateway__
<br/>![AWS Direct Connect + AWS Transit Gateway](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image9.png)
<br/>_AWS Direct Connect + AWS Transit Gateway. Source: docs.aws.amazon.com_

__AWS Direct Connect + VPN__

- __AWS Direct Connect + VPN__
<br/>![AWS Direct Connect + VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image10.png)
<br/>_AWS Direct Connect + VPN. Source: docs.aws.amazon.com_

__AWS Direct Connect + AWS Transit Gateway + VPN__

- __AWS Direct Connect + AWS Transit Gateway + VPN__
<br/>![AWS Direct Connect + AWS Transit Gateway + VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image11.png)
<br/>_AWS Direct Connect + AWS Transit Gateway + VPN. Source: docs.aws.amazon.com_

  __Use case__: to simplify management and minimize the cost of IPSec VPN
  connections to `multiple Amazon VPCs in the same region`, with the low latency
  and consistent network experience benefits of a private dedicated connection
  over an internet-based VPN.

What       | AWS Direct Connect gateway | AWS Direct Connect + AWS Transit Gateway + VPN
-----------|----------------------------|-----------------------------------------------
Connect to | Multiple VPCs across different regions or AWS accounts | Multiple VPCs in the same region
Advantage  |Reduce Direct Connection Management | simplify management and minimize the cost of IPSec VPN

__AWS VPN CloudHub__

- __AWS VPN CloudHub__
<br/>![AWS VPN CloudHub](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image12.png)
<br/>_AWS VPN CloudHub. Source: docs.aws.amazon.com_

  * The remote network prefixes for each spoke must have unique ASNs
  * The sites must not have overlapping IP ranges.

__Software Site-to-Site VPN__

- __Software Site-to-Site VPN__
<br/>![Software Site-to-Site VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image13.png)
<br/>_Software Site-to-Site VPN. Source: docs.aws.amazon.com_

  __Use case__: if you must manage both ends of the VPN connection, either for
  compliance purposes or for leveraging gateway devices that are not currently
  supported by Amazon VPC’s VPN solution.

  Network has `single point of failure` because the software VPN appliance
  runs on a single Amazon EC2 instance.

### VPC-to-VPC connectivity options ###

- conn - Connection
- HA - High Availability
- eqpt - Equipment

Use non-overlapping IP ranges for each VPC being connected.

Option |	Use Case |	Advantages |	Limitations
-------|-----------|-------------|-------------
VPC Peering | AWS provided network connectivity between 2 VPCs | AWS managed | Does not support transitive peering
            |                                                  |             | Difficult to manage at scale
Transit Gateway | AWS provided regional router connectivity    | Regional hub up to 5k attachments | Transit Gateway peering only across regions, not within region
Software site-to-site VPN | Software appliance-based VPN conn between VPCs | Supports a wide array of VPN vendors, products, and protocols | Customer to implement HA if required  
                          |                                                | Customer manages | VPN instances could become a network bottleneck
Software VPN-to-AWS Managed VPN | | AWS managed HA VPC VPN conn | Customer to implement HA if required
                                | | Supports a wide array of VPN vendors and products managed by you | VPN instances could become a network bottleneck
                                | | Supports BGP peering and routing policies | IPSec VPN protocol only to AWS Managed VPN
AWS managed VPN | VPC-to-VPC routing managed by you over IPsec VPN conn using your eqpt | Amazon managed HA VPC VPN conn | Endpoint you manage is responsible for redundancy and failover
                |                                                                       | Supports BGP peering and routing policies |
AWS PrivateLink | AWS-provided network connectivity between 2 VPCs using interface endpoints | AWS managed | VPC Endpoint services only available in AWS region in which they are created.

__VPC Peering__

- __VPC Peering__
<br/>![VPC Peering](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image14.png)
<br/>_VPC Peering. Source: docs.aws.amazon.com_

  * Traffic never traverses the internet
  * Can be created between your own VPCs or with a VPC in another AWS account.
  * Supports inter-region peering.

__AWS Transit Gateway__

- __AWS Transit Gateway__
<br/>![AWS Transit Gateway](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image15.png)
<br/>_AWS Transit Gateway. Source: docs.aws.amazon.com_

 * Traffic never traverses the internet
 * Transit Gateway across different regions can peer with each other to enable
 VPC communications across regions.
 * With large number of VPCs, Transit Gateway provides simpler VPC-to-VPC
 communication management over VPC Peering

 __Software Site-to-Site VPN__

 - __Software Site-to-Site VPN__
 <br/>![Software Site-to-Site VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image16.png)
 <br/>_Software Site-to-Site VPN. Source: docs.aws.amazon.com_

  __Use case__: when you want to manage both ends of the VPN connection using
  your preferred VPN software provider.

  * This design introduces a potential single point of failure into the network
  design as the software VPN appliance runs on a single Amazon EC2 instance.

__Software VPN-to-AWS Managed VPN__

- __Software VPN-to-AWS Managed VPN__
<br/>![Software VPN-to-AWS Managed VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image17.png)
<br/>_Software VPN-to-AWS Managed VPN. Source: docs.aws.amazon.com_

  __Use case__: When you want instances in each VPC to seamlessly connect to
  each other using `private IP addresses`.

  * This design introduces a potential single point of failure into the network
  design as the software VPN appliance runs on a single Amazon EC2 instance.

__AWS Managed VPN__

- __AWS Managed VPN__
<br/>![AWS Managed VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image18.png)
<br/>_AWS Managed VPN. Source: docs.aws.amazon.com_

- __AWS Managed VPN + Direct Connect__
<br/>![AWS Managed VPN + Direct Connect](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image19.png)
<br/>_AWS Managed VPN + Direct Connect. Source: docs.aws.amazon.com_

  >This approach is suboptimal from a routing perspective since the traffic must
  traverse to router on your network, but it gives you a lot of flexibility for
  controlling and managing routing on your local and remote networks, and the
  potential ability to reuse VPN connections.

__AWS PrivateLink__

- AWS PrivateLink enables you to connect to some AWS services, services hosted by other AWS accounts (referred to as endpoint services), and supported AWS Marketplace partner services, via private IP addresses in your VPC. The interface endpoints are created directly inside of your VPC, using elastic network interfaces and IP addresses in your VPC’s subnets. That means that VPC Security Groups can be used to manage access to the endpoints.

- __AWS PrivateLink__
<br/>![AWS PrivateLink](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image20.png)
<br/>_AWS PrivateLink. Source: docs.aws.amazon.com_

  __Use case__: If you want to use services offered by another VPC securely
  within AWS network (traffic never traverses internet).

### Software remote access-to-Amazon VPC connectivity options ###

Option 	| Use Case | Advantages | Limitations
--------|----------|------------|-----------
AWS Client VPN | AWS managed remote access solution to VPC and/or internal networks | AWS managed HA and scalability service | OpenVPN clients only
Software client VPN | Software VPN appliance remote access solution to VPC and/or internal networks | Wider array of VPN vendors, products, & protocols | You are responsible for HA
                    |                                                                               | Fully customer-managed solution |

__AWS Client VPN__

- __AWS Client VPN__
<br/>![AWS Client VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image21.png)
<br/>_AWS Client VPN. Source: docs.aws.amazon.com_

  * Remote clients can be the AWS Client VPN for Desktop, or third-party OpenVPN VPN clients.
  * Authentication by either Active Directory or mutual certificate authentication.

__Software client VPN__

- __Software client VPN__
<br/>![Software client VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image22.png)
<br/>_Software client VPN. Source: docs.aws.amazon.com_

  __Use case__ Provide great flexibility on the security protocol used for
  remote-access into your Amazon VPCs

  * This design introduces a potential single point of failure into the network
  design as the remote access server runs on a single Amazon EC2 instance.

### Transit VPC ###

A transit VPC is a common strategy for connecting multiple, geographically disperse VPCs and remote networks

__Transit VPC__
<br/>![Transit VPC](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image23.png)
<br/>_Transit VPC. Source: docs.aws.amazon.com_

  __Use case__: Private networking, shared connectivity and cross account AWS usage.
  Simplify network management and minimize the number of connections
  required to connect multiple geographically disperse VPCs and remote networks.

  * For providing direct network routing between VPCs and on-premises networks
  * Enables the transit VPC to implement more complex routing rules, such as
  network address translation between overlapping network ranges, or to add
  additional network-level packet filtering or inspection.

### High-Level HA architecture for software VPN instances  ###

Creating a fully resilient VPC connection for software VPN instances requires the setup and configuration of multiple VPN instances and a monitoring instance to monitor the health of the VPN connections.

__High-Level Software VPN with HA

- __High-Level Software VPN with HA__
<br/>![High-Level Software VPN with HA](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/images/image24.png)
<br/>_High-Level Software VPN with HA. Source: docs.aws.amazon.com_

  Amazon recommends configuring your VPC route tables to leverage all VPN
  instances simultaneously by directing traffic from all of the subnets in one
  AZ through its respective VPN instances in the same AZ. Each VPN instance then
  provides VPN connectivity for instances that share the same AZ.

__VPN Monitoring__

To monitor Software based VPN appliance you can create a VPN Monitor. The VPN
monitor is a custom instance that you will need to run the VPN monitoring scripts.
If a VPN instance or connection goes down, the monitor needs to stop, terminate,
or restart the VPN instance while also rerouting traffic from the affected subnets
to the working VPN instance until both connections are functional again.
[This link](https://aws.amazon.com/articles/high-availability-for-amazon-vpc-nat-instances-an-example/)
contains an example script for enabling HA between NAT instances and could be
used as a starting point for creating an HA solution for Software VPN instances.

>You can monitor the AWS Managed VPN tunnels using Amazon CloudWatch
metrics, which collects data points from the VPN service into readable, near
real-time metrics. Each VPN connection collects and publishes a variety of tunnel
metrics to Amazon CloudWatch. These metrics allow you to monitor tunnel health,
activity, and create automated actions.

### Setting up a Site-to-Site VPN ###

You can create a Site-to-Site VPN connection with either a virtual private
gateway or a transit gateway as the target gateway. To manually set up a
Site-to-Site VPN connection, complete the following steps:

- Step 1: __Create a customer gateway__ via the Amazon VPC console.

- Step 2: __Create a target gateway.__ Either a virtual private gateway or a
transit gateway.

  * Virtual Private Gateway
    - via the Amazon VPC console.
    - After you create a virtual private gateway, you must attach it to your VPC.
  * [Click here for information about creating a transit gateway](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-transit-gateways.html)  

- Step 3: __Configure routing.__ Configure your route table to include the
routes used by your Site-to-Site VPN connection and point them to your virtual
private gateway or transit gateway.

- Step 4: __Update your security group.__ To allow access to instances in your
VPC from your network, you must update your security group rules to enable
inbound SSH, RDP, and ICMP access.

- Step 5: __Create a Site-to-Site VPN connection.__ Via the Amazon VPC console,
create the Site-to-Site VPN connection using the customer gateway and the virtual
private gateway or transit gateway that you created earlier.

- Step 6: __Download the configuration file.__ Via the Amazon VPC console,
download the configuration information and use it to configure the customer
gateway device or software application.

- Step 7: __Configure the customer gateway device.__ Use the configuration file
to configure your customer gateway device. The customer gateway device is the
physical or software appliance on your side of the Site-to-Site VPN connection.
[Click here for more information](https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html).

### Takeaways ###

@TODO Write a summary of the salient points

### References ###

- [AWS Docs - VPC Connectivity Options](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/welcome.html)
- [AWS Articles - High Availability for VPC NAT Instances](https://aws.amazon.com/articles/high-availability-for-amazon-vpc-nat-instances-an-example/)
- [AWS - Setup VPN Connections](https://docs.aws.amazon.com/vpn/latest/s2svpn/SetUpVPNConnections.html)
