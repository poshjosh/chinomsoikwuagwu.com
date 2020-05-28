---
path: "./2020/04/30/AWS-Achritect-5_Architecting-for_Cost-Optimization.md"
date: "2020-04-30T23:51:09"
title: "AWS Achritect 5 - Architecting for Cost Optimization"
description: "Game changing tutorial on AWS - Architecting for Cost Optimization"
tags: ["AWS", "tutorial", "architect", "cost optimized", "cost optimization", "design principles", "appropriately provisioned resources", "right sizing", "purchasing options", "geographic selection", "managed services", "optimize data transfer", "matching supply and demand", "demand-based", "buffer-based", "time-based", "usage and expenditure awareness", "stakeholders", "visibility and governance", "cost attribution", "tagging", "entity lifecycle tracking", "optimizing over time", "staying ever green"]
lang: "en-us"
---

### Acronyms ###

- EC2 - Elastic Cloud Compute
- IAM - Identity and Access Management
- JSON - Javascript Object Notation
- S3 - Simple Storage Service
- SSM - AWS Systems Manager
- YAML - YAML ain't Markup Language

### Before we set off ###

__About this Article__

- Hi, this article contains game changing information for those who would like
to get AWS Certified Cloud Architect certified.

- It is one of a series of articles.

[Update-2020-04-30]

- This is the fifth (5th) article in the series and here are links to all the articles:

  * [Part 1 - Architecting for Reliability](/2020/04/14/AWS-Architect-1_Architecting-for-Reliability)
  * [Part 2 - Architecting for Security](/2020/04/14/AWS-Architect-2_Architecting-for-Security)
  * [Part 3 - Architecting for Operational Excellence](/2020/04/14/AWS-Architect-1_Architecting-for-Reliability)
  * [Part 4 - Architecting for Performance Efficiency](/2020/04/19/AWS-Achritect-4_Architecting-for_Performance-Efficiency)
  * [Part 5 - Architecting for Cost Optimization](/2020/04/30/AWS-Achritect-5_Architecting-for_Cost-Optimization)
  * [Part 6 - Passing the Certificate Exam](/2020/04/14/AWS-Architect-6_Passing-the-Certification-Exam)

[/Update-2020-04-30]

- This article is an estimated 18 minute read.

__This Article is not an Introduction to AWS__

This series of articles is not an introduction to AWS or any of the core
concepts of the AWS Cloud. You need to be already familiar with some core
concepts of AWS Cloud to fully benefit from this article. In order words,
if you are not familiar with the AWS cloud, you should read the series of
articles beginning at:

- [Notes on Amazon Web Services - 1](/2020/03/02/Notes-on-Amazon-Web-Services_1_Introduction)

- [AWS Certified Solutions Architect Associate - Part 1](/2020/03/09/AWS_Certified-Solutions-Architect-Associate_Part-1_Key-services-relating-to-the-Exam)

### What does it mean to architect for Cost Optimization? ###

- First off, what is optimization?

  `Optimization`
  : is the action of making the best or most effective use of a situation or resource.

- Ergo, cost optimization simply means to make best use of financial resources
(particularly money).

- It is no surprise then, that `Cost Optimization` is one of Amazon's
[5 pillars of a well architected system](https://aws.amazon.com/blogs/apn/the-5-pillars-of-the-aws-well-architected-framework/)
and it involves 5 design principles:

  * `Adopt a consumption model`: Pay only for the computing resources that you
  require and increase or decrease usage depending on business requirements.

  * `Measure overall efficiency`: To have an insight into gains, measure the
  business output of the workload and the costs associated with delivering it.

  * `Stop spending money on data center operations`: Let AWS do the heavy
  lifting at a reduced cost.

  * `Analyze and attribute expenditure`: This allows transparent attribution of
  IT costs to individual workload owners and thus helps measure return on
  investment (ROI) and gives workload owners an opportunity to optimize their
  resources and reduce costs.

  * `Use managed and application level services` to reduce cost of ownership:
  for example for tasks such as sending email or managing databases.

- There are four (4) best practice areas for cost optimization in the cloud:

  * Expenditure Awareness
  * Cost-Effective Resources
  * Matching supply and demand
  * Optimizing Over Time


//////////
You incur access charges when files are transitioned to EFS IA storage from EFS Standard storage.
https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html
////////
### Cost Optimization ###

__Design Principles__

__Definition__

### Cost Effective Resources ###

__Appropriately Provisioned__

__Right Sizing__

__Purchasing Options__

__Geographic Selection__

__Managed Services__

__Optimize Data Transfer__

### Matching Supply and Demand  ###

__Demand-Based__

__Buffer-Based__

__Time-Based__

### Usage and Expenditure Awareness ###

__Stakeholders__

__Visibility and Governance__

__Cost Attribution__

__Tagging__

__Entity Lifecycle Tracking__

### Optimizing Over Time ###

__Measure, Monitor and Improve__

__Staying Ever Green__

### Takeaways ###


### References ###

- [Lexico.com - Definition of Optimization](https://www.lexico.com/en/definition/optimization)

- [AWS - 5 Pillars of Well Architected Framework]([pillar](https://aws.amazon.com/blogs/apn/the-5-pillars-of-the-aws-well-architected-framework/))

- [AWS - Cost Optimization Pillar](https://wa.aws.amazon.com/wat.pillar.costOptimization.en.html)

- [AWS - Cost Optimization Pillar - White Paper](https://d0.awsstatic.com/whitepapers/architecture/AWS-Cost-Optimization-Pillar.pdf?ref=wellarchitected-ws)
