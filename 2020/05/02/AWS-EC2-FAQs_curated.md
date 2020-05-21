---
path: "./2020/05/02/AWS-EC2-FAQs_curated.md"
date: "2020-05-02T19:22:10"
title: "AWS FAQs - Curated"
description: "Curated FAQs on AWS"
tags: ["AWS", "FAQ", "NAT", "EC2"]
lang: "en-us"
---

### EC2 ###

Q: __What is the difference between using the local instance store and Amazon Elastic Block Store (Amazon EBS) for the root device?__

When you launch your Amazon EC2 instances you have the ability to store your root device data on Amazon EBS or the local instance store. By using Amazon EBS, data on the root device will persist independently from the lifetime of the instance. This enables you to stop and restart the instance at a subsequent time, which is similar to shutting down your laptop and restarting it when you need it again.

Alternatively, the local instance store only persists during the life of the instance. This is an inexpensive way to launch instances where data is not stored to the root device. For example, some customers use this option to run large web sites where each instance is a clone to handle web traffic.

Q: __What operating system environments are supported?__

Amazon EC2 currently supports a variety of operating systems including: Amazon Linux, Ubuntu, Windows Server, Red Hat Enterprise Linux, SUSE Linux Enterprise Server, openSUSE Leap, Fedora, Fedora CoreOS, Debian, CentOS, Gentoo Linux, Oracle Linux, and FreeBSD. We are looking for ways to expand it to other platforms.

### EC2 On-Demand Instance limits ###

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

### Changes to EC2 SMTP endpoint policy ###

Q: __What is changing?__

Starting Jan-27 2020, EC2 will restrict email traffic over port 25 by default.
AWS accounts that have requested and had Port 25 throttles removed in the past
will not be impacted by this change.

### Service level agreement (SLA) ###

Q: __What is SLA Credit and how can I qualify for it?__

Amazon SLA guarantees a Monthly Uptime of at least 99.99 percent for Amazon EC2
and Amazon EBS within a Region. You are eligible for SLA credit if the Region
that you are operating in has an Monthly Uptime Percentage of less than
99.95 percent during any monthly billing cycle

### References ###

- [AWS EC2 FAQs](https://aws.amazon.com/ec2/faqs/)
- [AWS EC2 Instance Types](/2020/02/07/AWS_EC2-Instance-Types_curated)
- [AWS EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/)
