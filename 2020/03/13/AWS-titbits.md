---
path: "./default-site/content/blog/2020/03/13/AWS-titbits.md"
date: "2020-03-13"
title: "AWS Titbits"
description: "Poshjoshs-Blog - AWS titbits"
lang: "en-us"
---

- IPv6 addresses are public and reachable over the Internet.

- __NAT gateways are not supported for IPv6 traffic__  — use an outbound-only (egress-only)
internet gateway instead. For more information, see Egress-Only Internet Gateways.

- Each NAT gateway is created in a specific Availability Zone and implemented with
redundancy in that zone.

- __BEST PRACTICE__: Create a NAT gateway in each Availability Zone and
configure your routing to ensure that resources use the NAT gateway in the same
Availability Zone.

- [To deploy recommeded best practice VPC](https://docs.aws.amazon.com/quickstart/latest/vpc/architecture/)

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

NACL

You can associate a network ACL with multiple subnets. However, a subnet can be associated with only one network ACL at a time. When you associate a network ACL with a subnet, the previous association is removed
