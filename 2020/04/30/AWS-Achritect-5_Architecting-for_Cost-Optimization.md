---
path: "./2020/04/30/AWS-Achritect-5_Architecting-for_Cost-Optimization.md"
date: "2020-04-30T23:51:09"
title: "AWS Achritect 5 - Architecting for Cost Optimization"
description: "Game changing tutorial on AWS - Architecting for Cost Optimization"
tags: ["AWS", "tutorial", "architect", "cost optimized", "cost optimization", "design principles", "appropriately provisioned resources", "right sizing", "purchasing options", "geographic selection", "managed services", "optimize data transfer", "matching supply and demand", "demand-based", "buffer-based", "time-based", "usage and expenditure awareness", "stakeholders", "visibility and governance", "cost attribution", "tagging", "entity lifecycle tracking", "optimizing over time", "staying ever green"]
lang: "en-us"
---

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

- This article is an estimated 30 minute read.

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

>Cost optimization is a continual process of refinement and improvement of a
system over its entire lifecycle... A cost-optimized system will fully utilize
 all resources, achieve an outcome at the lowest possible price point, and meet
 your functional requirements.

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

  * Cost-Effective Resources
  * Matching supply and demand
  * Expenditure Awareness
  * Optimizing Over Time

### Cost Effective Resources ###

__Appropriately Provisioned__

You should use managed resources like Amazon RDS and Amazon Redshift amongst
others. However, you need to understand the requirements of adjusting the
service capacity. These requirements are typically time, effort, and any impact
to normal system operation. If the time to adjust is longer than you want,
consider over-provisioning just a bit to allow for growth. The ongoing effort
required to modify services can be reduced to virtually zero by using APIs and
SDKs that are integrated with system and monitoring tools such as Amazon
CloudWatch. AWS Trusted Advisor also monitors services such as Amazon Redshift
and Amazon RDS for resource utilization and active connections.

__Right Sizing__

Right sizing is using the lowest cost resource that still meets the technical
specifications of a specific workload. You can right size iteratively by
adjusting the size of resources to optimize for costs.

- EBS elastic volumes allow you to increase volume size or adjust performance
while still in use.

- Use CloudWatch to monitor resources (like memory utilization, network bandwidth,  
and system connections) as well as alarms to provide the data for right sizing.

Keep in mind three key considerations when you perform right-sizing exercises:

- The monitoring must accurately reflect the end-user experience. Choose the
maximum or 99th percentile instead of the average.

- Select the correct granularity for the time period of analysis that is
required to cover any system cycles. For example, if a two-week analysis is
performed, you might be overlooking a monthly cycle of high utilization.

- Assess the cost of modification against the benefit of right sizing.  

- __AWS Trusted Advisor__ performs analysis of resources and reports on any under-
or over-utilized resources. For example, on Amazon EC2 Trusted Advisor performs
analysis on CPU utilization and network traffic over a period of time. On Amazon
EBS it analyzes the IOPS activity on a volume and provides a list of resources
that could benefit from a right-sizing activity.

__Purchasing Options__

- __On demand__. You pay a flat hourly rate with no long term commitment.

  * Use for short term workloads (e.g 4 months projects), development and
  test environments.

- __Spot Instances__. Spot Instances allow you to use spare compute capacity
at a significantly lower cost than On-Demand EC2 instances (up to 90%).

  * `Spot block`. Spot Instances with a required duration (Spot blocks,
  from 1 to 6 hours)

  * `Spot fleet`. A fleet of Spot Instances, and optionally On-Demand Instances
  to meet the target capacity and price point. The fleet maintains this pool should interruptions occur.

    - A Spot Instance pool is a set of unused EC2 instances with the same
    instance type (for example, m5.large), operating system, Availability Zone,
    and network platform.

    - The Spot Fleet selects the Spot Instance pools based on specifications
    you provide.

    - __Cost Optimization__

    - Cost optimize use of spot instances - specify the `lowestPrice allocation strategy`
    so that Spot Fleet automatically deploys the least expensive combination of
    instance types and Availability Zones based on the current Spot price.

    - Cost optimize use of on-demand instances - In this case, Spot Fleet
    always selects the least expensive instance type based on the public On-Demand price.

    - __Cost Optimization and Diversification__ - To create a fleet of Spot
    Instances that is both cheap and diversified, use the `lowestPrice allocation strategy`
    in combination with `InstancePoolsToUseCount`. Spot Fleet automatically
    deploys the cheapest combination of instance types and Availability Zones
    based on the current Spot price across the number of Spot pools that you specify

  * Use spot instances for batch processing, scientific research, image or
  video processing, financial analysis, and testing.

  * You set a maximum price (defaults is the on-demand price) you are willing
  to pay. The instance is stopped if price goes above and resumed if price falls
  back to or below the max price. The instance can be gracefully stopped or
  placed into hibernation, when the capacity is reclaimed by AWS. This way, the
  instances will be resumed from their prior state to continue their work.

  * If your instance is due to be reclaimed you will receive a two-minute warning
  (EC2 Spot Instance Termination Notice).

  * For `lowest possible cost` and chance of interruption.

    - Use __flexible instance types__ for

    - Be __flexible on Availability Zone__

  * EBS volumes attached to stopped instances remain intact, as does the
  EBS-backed root volume.

- __Reserved Instances/Capacity__

With Reserved Instances, you commit to a period of usage (one or three years)
and save up to 75% over equivalent On-Demand hourly rates.

  * When your Reserved Instances are assigned to a specified Availability Zone,
  they also provide you with `capacity reservation` (a standard Reserved Instance)
  so that you can launch the number of instances you need when you need them.

  * Reserved Instances do not renew automatically

  * A Reserved Instance has four (4) instance attributes that determine its price.
  The attributes also determine how the Reserved Instance is applied to a
  running instance in your account.

    - `Instance type`: For example, m4.large. This is composed of the instance family (m4) and the instance size (large).

    - `Region`: The Region in which the Reserved Instance is purchased.

    - `Tenancy`: Whether your instance runs on shared (default) or single-tenant (dedicated) hardware.

    - `Platform`: The operating system; for example, Windows or Linux/Unix.

  * __Amazon CloudFront__ has reserved capacity pricing.

  * __Types of Amazon EC2 reserved instances__.

    - `Standard` Reserved Instances provide both a billing benefit and capacity
    reservation when the instance family, size, and Availability Zone are specified.
    - `Convertible` Reserved Instances are provided for a one-year or three-year term
    and allow conversion to different families, new pricing, different instance sizes,
    different platforms,  or tenancy during the period

  * __Payment options__.

    - `No up-front payment`. You pay a reduced hourly rate each month for the
    total hours in the month.
    - `Partial up-front payment`. You pay a reduced hourly rate each month for the
    total hours in the month.
    - `Full up-front payment`. No other costs are incurred for the remainder
    of the term regardless of the number of hours used.

- __EC2 Fleet__

>EC2 Fleet allows you to define a target compute capacity, and then specify the
instance types and the balance of On-Demand, Reserved,  and Spot for the fleet.
EC2 Fleet will then automatically launch the lowest price combination of
resources to meet the defined capacity

__AWS Cost Explorer__ is a free tool that you can use to analyze your costs.
You can use Cost Explorer to see patterns in how much you spend on AWS resources
over time, identify areas that need further inquiry, provide recommendations for
reserved instances, and see trends that you can use to understand your costs.

- If you `enable Cost Explorer`, you automatically get `Amazon EC2`, `Amazon RDS`,
`ElastiCache`, `Amazon ES`, and `Amazon Redshift` Reserved Instance (RI)
purchase recommendations that could help you reduce your costs.

- Cost Explorer doesn't forecast your usage or take forecasts into account when recommending RIs.

- Linked accounts need permissions to view Cost Explorer and permissions to view recommendations.

__Geographic Selection__

Resource pricing can be different in each Region. You should therefore choose
a specific Region to operate a component of or your entire solution so that
you can run at the lowest possible price globally.

- Use __AWS Simple Monthly Caclculator__ to estimate the cost of architecting
your solution in various Regions around the world and compare the cost of each.
[Simple Monthly Calculator](https://calculator.s3.amazonaws.com/index.html)
is being deprecated in favor of [AWS Pricing Calculator](https://calculator.aws/#/)

- Use __AWS CloudFormation__ or __AWS CodeDeploy__ provision a proof of concept
environment in different Regions, run workloads through the environments,  
and analyze the exact and complete system costs in each Region.

__Managed Services__

By using managed services,  you can reduce or remove much of your
administrative and operational overhead, freeing you to work on value-adding activities.

- Use managed services to reduce cost.

- Using managed services could also remove or reduce license costs.

__Optimize Data Transfer__

 By using CloudFront,  you can reduce the administrative effort in delivering
 content to large numbers of users globally, with minimum latency.

 >AWS Direct Connect allows you to establish a dedicated network connection
 from your premises to AWS. This can reduce network costs,  increase bandwidth,  
 and provide a more consistent network experience than internet-based connections

### Matching Supply and Demand  ###

__Demand-Based__

Leveraging the elasticity of the cloud to meet demand as it changes can provide
significant cost savings. Within AWS this is normally accomplished using Auto Scaling.  

- __Auto Scaling__ helps you to scale your EC2 instances and Spot Fleet
capacity up or down automatically according to conditions you define.

- Use __Elastic Load Balancing (ELB)__ with Auto Scaling to distribute incoming
application traffic across multiple EC2 instances in an Auto Scaling group.

- Use __CloudWatch__ metrics to trigger the scaling event. CloudWatch supports
custom metrics, for example, that might originate from application code on your
EC2 instances

__Buffer-Based__

A buffer-based approach to matching supply and demand uses a queue to accept
messages (units of work) from producers.  For resiliency the queue should use
durable storage (such as disks or a database)

- Use buffers when you have a workload that generates a significant write load
that doesn’t need to be processed immediately.

- On AWS, you can choose `Amazon SQS` or `Amazon Kinesis` amongst other services
to implement a buffering approach.

- __Amazon SQS__ provides a queue that allows a single consumer to read individual
messages.

  * Use __long polling__ to reduce the cost of retrieving messages. Long polling
  lets you retrieve messages from your Amazon SQS queue as soon as they become available.

  * SQS `at-least-once` delivery means that you can receive a message more than once.

  * For `exactly-once` processing, use __SQS first in/first out (FIFO)__ queues.

  * For long-running tasks you can extend the `visibility time-out`.

  * Your application will need to delete messages after they have been processed.

- __Amazon Kinesis__ provides a stream that allows many consumers to read
the same messages. It differs from Amazon SQS in that it allows multiple
consumers to read the same message at any one time.

  * Use Spot Instances to optimize the speed with which work items are consumed
  by more consumers

  * To prevent duplicate processing of the same message, either:

    - Provision a table in Amazon DynamoDB that can track the work items that
    have already been successfully processed

    - Implement idempotent processing.

__Time-Based__

A time-based approach aligns resource capacity to demand that is predictable
or well defined by time.

You can leverage the AWS APIs and AWS CloudFormation to automatically provision
and decommission entire environments as you need them.

When architecting with a time-based approach keep in mind two key considerations:  

  - How consistent is the usage pattern?
  - What is the impact if the pattern changes?

### Usage and Expenditure Awareness ###

__Stakeholders__

Relevant stakeholders within your business need to be involved in usage and
expenditure discussions at all stages of your cloud journey. The following are
typical stakeholders for engagement:

- CFO
- Business unit owners
- Tech leads
- Third parties.

__Visibility and Governance__

Before taking action, a detailed level of visibility into your AWS environment
will enable you to identify opportunities for saving.

The __AWS Billing and Cost Management__ service enables you to do the following:

  - Estimate and forecast your AWS cost and usage.
  - Receive notifications when you exceed your budgeted thresholds.
  - Assess your biggest investments in AWS resources.
  - Analyze your spend and usage data.
  - Reserved Instance Utilization Report. Allows you to visualize your RI
  utilization (that is, the percentage of purchased RI hours consumed by
  instances during a period of time) and show your savings due to RIs.
  - Reserved Instance Coverage Report. Allows you to visualize the percentage
  of running instance hours thatare covered by RIs (that is, RI coverage) in
  aggregate or in detail (for example, by account, instance type, Region,
  Availability Zone, tags, platform) and the On-Demand cost of the usage.

Use the __[Cost Explorer](https://aws.amazon.com/about-aws/whats-new/2014/04/08/introducing-cost-explorer-view-and-analyze-your-historical-aws-spend/)__ tool to visualize and analyze your costs. This tool
allows you to graphically view your costs over a year, and forecast how much
you are likely to spend for the coming months with a more than 80% confidence interval.  

Use __Budgets__ tool to define a monthly budget for your AWS costs and usage,  
at an aggregate cost level (that is, all costs),  or at a more granular level
where you can include only specific dimensions such as linked accounts, services,
tags, or Availability Zones. You can also attach email notifications to your
budgets, which will trigger when your current or forecasted costs exceed a
percentage threshold that you define.

The __Cost and Usage Reports__ provide the most granular level of reporting.  
They provide hourly usages and charges for all chargeable AWS services.

Use the __IAM service__ in conjunction with Billing and Cost Management to
control access to your financial data and to the AWS tools in the billing console

__Cost Attribution__

You can use cost attribution to drive cost management by assigning costs to
systems, revenue streams, or parts of your organization,  such as departments,
business units, products,  or internal teams.

__Tagging__

>Tags allow you to overlay business and organizational information onto your
billing and usage data. This helps you categorize and track your costs by
meaningful, relevant business information. You can apply tags that represent
business categories (such as cost centers, application names, projects, or owners)
to organize your costs across multiple services and teams. When you apply tags
to your AWS resources (such as EC2 instances or Amazon S3 buckets) and activate
the tags, AWS adds this information to the Cost and Usage Reports.

>When you apply tags to your AWS resources (such as EC2 instances or Amazon
S3 buckets) and activate the tags, AWS adds this information to the Cost and Usage Reports.

Read [AWS Tagging Best Practices](https://d1.awsstatic.com/whitepapers/aws-tagging-best-practices.pdf)

__Entity Lifecycle Tracking__

AWS provides a number of services you can use for entity lifecycle tracking.

- __AWS Config__ provides a detailed inventory of your AWS resources and
configuration and continuously records configuration changes

- __AWS CloudTrail__ and __Amazon CloudWatch__ allow you to establish a
record of resource lifecycle events

- __IAM__ allows you to manage groups, users, and roles as well as establish trust
with existing identity providers using federation already tied to your
organization’s workforce source of record.

- __Federation__ allows you to reduce the need to create users in IAM, and
still use the existing identities, credentials, and role-based access you
have already established in your organization.

### Optimizing Over Time ###

__Measure, Monitor and Improve__

>When you measure and monitor your users and applications, and combine the
data you collect with data from AWS platform monitoring, you can perform a
gap analysis that tells you how closely aligned your system utilization is
to your requirements. By working continually to minimize this utilization
gap you can ensure that your systems are cost effective. There are four key
ways to set this up:

- __Establish a cost optimization function__. AWS Enterprise Support will provide
a Technical Account Manager (TAM) who specializes in optimization.

- __Establish goals and metrics__. Examples:

  * `On-Demand EC2 Elasticity`: The percentage of your On-Demand EC2 instances
  that are turned on and off every day. This should be as close to 100% as is
  feasible, and be in the range of 80%-100%.  To measure,  take the number of
  instances started during the day and divide it by the maximum number of
  instances running at any time.

  * `Overall Elasticity`: The percentage of On-Demand and Reserved Instances
  that are turned on and off every day. This should match your customer usage
  as close as possible. However, if you operate systems that are in use 24 hours
  a day, 7 days a week the range will be broader.  If your systems peak from
  20% to 100% of usage during the day, then elasticity should be driving towards 80%.

  * `Baseload Reserved Instance coverage`: The number of “always on” instances
  that are running as reserved capacity. Your organization should aim for
  80%-90% coverage

- __Gather insight and perform analysis.__ AWS provides the following tools to
measure and monitor usage: `The Billing and Cost Management Dashboard` (including
`Cost Explorer` and `Budgets`), `Amazon CloudWatch`,  and `AWS Trusted Advisor`.

- __Report and validate.__ Reports using the tooling and analysis described
above should be reviewed regularly to ensure alignment with and progress
toward your defined goals. It is also essential to validate any implemented
cost measures, for example savings due to reserved capacity, and adjust them
if required.

__Staying Ever Green__

>As AWS releases new services and features, it is a best practice to review
your existing architectural decisions to ensure that they remain cost effective
and stay ever green. As your requirements change, be aggressive in decommissioning
resources,  components,  and workloads that you no longer require

Keep up to date with these 2 AWS resources:

- [AWS Blog](https://aws.amazon.com/blogs/aws/)

- [What's New at AWS](https://aws.amazon.com/new/)

### Takeaways ###

- EBS elastic volumes allow you to increase volume size or adjust performance
while still in use.

- __AWS Trusted Advisor__ performs analysis of resources and reports on any under-
or over-utilized resources.

- Use __On demand__ instances for short term workloads (e.g 4 months projects),
development and test environments.

- Use __Spot Instances__. for workloads that could survive and interruption,
to significantly lower cost than On-Demand EC2 instances (up to 90%). For
example: batch processing, scientific research, image or video processing,
financial analysis, and testing

  * `Spot block`. Spot Instances with a required duration (Spot blocks,
  from 1 to 6 hours)

  * `Spot fleet`. A fleet of Spot Instances, and optionally On-Demand Instances
  to meet the target capacity and price point. The fleet maintains this
  pool should interruptions occur.

- __Cost optimize__ use of

  * Spot instances - specify the `lowestPrice allocation strategy`
  so that Spot Fleet automatically deploys the least expensive combination of
  instance types and Availability Zones based on the current Spot price.

  * On-demand instances - In this case, Spot Fleet always selects the least
  expensive instance type based on the public On-Demand price.

- __Cost Optimization and Diversification__ - To create a fleet of Spot
Instances that is both cheap and diversified, use the `lowestPrice allocation strategy`
in combination with `InstancePoolsToUseCount`.

- If your Spot Instance is due to be reclaimed you will receive a two-minute warning
(EC2 Spot Instance Termination Notice).

- For `lowest possible cost` and chance of interruption.

    - Use __flexible instance types__ for

    - Be __flexible on Availability Zone__

- EBS volumes attached to stopped instances remain intact, as does the
EBS-backed root volume.

- When your Reserved Instances are assigned to a specified Availability Zone,
they also provide you with `capacity reservation` (a standard Reserved Instance)
so that you can launch the number of instances you need when you need them.

- Reserved Instances do not renew automatically

- A Reserved Instance has four (4) instance attributes that determine its price.
The attributes also determine how the Reserved Instance is applied to a
running instance in your account.

    - `Instance type`: For example, m4.large. This is composed of the instance family (m4) and the instance size (large).

    - `Region`: The Region in which the Reserved Instance is purchased.

    - `Tenancy`: Whether your instance runs on shared (default) or single-tenant (dedicated) hardware.

    - `Platform`: The operating system; for example, Windows or Linux/Unix.

- __Amazon CloudFront__ has reserved capacity pricing.

- `Standard` Reserved Instances provide both a billing benefit and capacity
reservation when the instance family, size, and Availability Zone are specified.

- `Convertible` Reserved Instances are provided for a one-year or three-year term
and allow conversion to different families, new pricing, different instance sizes,
different platforms,  or tenancy during the period

- __Payment options__ for reserved instances:

  * `No up-front payment`. You pay a reduced hourly rate each month for the
  total hours in the month.
  * `Partial up-front payment`. You pay a reduced hourly rate each month for the
  total hours in the month.
  * `Full up-front payment`. No other costs are incurred for the remainder
  of the term regardless of the number of hours used.

- __EC2 Fleet__ allows you to define a target compute capacity, and then specify the
instance types and the balance of On-Demand, Reserved, and Spot for the fleet.

__AWS Cost Explorer__ is a free tool that you can use Cost Explorer to see
patterns in how much you spend on AWS resources over time.

- If you `enable Cost Explorer`, you automatically get `Amazon EC2`, `Amazon RDS`,
`ElastiCache`, `Amazon ES`, and `Amazon Redshift` Reserved Instance (RI)
purchase recommendations that could help you reduce your costs.

- Cost Explorer doesn't forecast your usage or take forecasts into account when recommending RIs.

- Linked accounts need permissions to view Cost Explorer and permissions to view recommendations.

- Use __AWS Simple Monthly Caclculator__ to estimate the cost of architecting
your solution in various Regions around the world and compare the cost of each.
[Simple Monthly Calculator](https://calculator.s3.amazonaws.com/index.html)
is being deprecated in favor of [AWS Pricing Calculator](https://calculator.aws/#/)

- Use managed services to reduce cost, and in some cases license costs.

- Optimize Data Transfer by using CloudFront or DirectConnect

- Use buffers (e.g queues) when you have a workload that generates a
significant write load that doesn’t need to be processed immediately.

- __Amazon SQS__ provides a queue that allows a single consumer to read individual
messages.

  * Use __long polling__ to reduce the cost of retrieving messages. Long polling
  lets you retrieve messages from your Amazon SQS queue as soon as they become available.

  * SQS `at-least-once` delivery means that you can receive a message more than once.

  * For `exactly-once` processing, use __SQS first in/first out (FIFO)__ queues.

  * For long-running tasks you can extend the `visibility time-out`.

  * Your application will need to delete messages after they have been processed.

- __Amazon Kinesis__ provides a stream that allows many consumers to read
the same messages. It differs from Amazon SQS in that it allows multiple
consumers to read the same message at any one time.

  * Use Spot Instances to optimize the speed with which work items are consumed
  by more consumers

  * To prevent duplicate processing of the same message, either:

    - Provision a table in Amazon DynamoDB that can track the work items that
    have already been successfully processed

    - Implement idempotent processing.

The __AWS Billing and Cost Management__ service provides the following reports:

  - `Reserved Instance Utilization Report`. Allows you to visualize your RI
  utilization (that is, the percentage of purchased RI hours consumed by
  instances during a period of time) and show your savings due to RIs.
  - `Reserved Instance Coverage Report`. Allows you to visualize the percentage
  of running instance hours thatare covered by RIs (that is, RI coverage) in
  aggregate or in detail (for example, by account, instance type, Region,
  Availability Zone, tags, platform) and the On-Demand cost of the usage.

- Use the __[Cost Explorer](https://aws.amazon.com/about-aws/whats-new/2014/04/08/introducing-cost-explorer-view-and-analyze-your-historical-aws-spend/)__ tool to visualize and analyze your costs.

- Use __Budgets__ tool to define a monthly budget for your AWS costs and usage.

- You can also attach email notifications to your budgets, which will trigger
when your current or forecasted costs exceed a percentage threshold that you define.

- The __Cost and Usage Reports__ provide the most granular level of reporting.  
They provide hourly usages and charges for all chargeable AWS services.

- Use the __IAM service__ in conjunction with Billing and Cost Management to
control access to your financial data and to the AWS tools in the billing console

- When you apply tags to your AWS resources (such as EC2 instances or Amazon
S3 buckets) and activate the tags, AWS adds this information to the Cost and Usage Reports.

- AWS provides a number of services you can use for entity lifecycle tracking.

  * __AWS Config__ provides a detailed inventory of your AWS resources and
  configuration and continuously records configuration changes

  * __AWS CloudTrail__ and __Amazon CloudWatch__ allow you to establish a
  record of resource lifecycle events

  * __IAM__ allows you to manage groups, users, and roles.

  * __Federation__ allows you to reduce the need to create users in IAM, and
  still use the existing identities, credentials, and role-based access you
  have already established in your organization.

- __Establish goals and metrics__. Examples:

  * `On-Demand EC2 Elasticity`: The percentage of your On-Demand EC2 instances
  that are turned on and off every day. This should be as close to 100% as is
  feasible, and be in the range of 80%-100%.  To measure,  take the number of
  instances started during the day and divide it by the maximum number of
  instances running at any time.

  * `Overall Elasticity`: The percentage of On-Demand and Reserved Instances
  that are turned on and off every day. This should match your customer usage
  as close as possible. However, if you operate systems that are in use 24 hours
  a day, 7 days a week the range will be broader.  If your systems peak from
  20% to 100% of usage during the day, then elasticity should be driving towards 80%.

  * `Baseload Reserved Instance coverage`: The number of “always on” instances
  that are running as reserved capacity. Your organization should aim for
  80%-90% coverage

### References ###

- [Lexico.com - Definition of Optimization](https://www.lexico.com/en/definition/optimization)

- [AWS - 5 Pillars of Well Architected Framework]([pillar](https://aws.amazon.com/blogs/apn/the-5-pillars-of-the-aws-well-architected-framework/))

- [AWS - Cost Optimization Pillar](https://wa.aws.amazon.com/wat.pillar.costOptimization.en.html)

- [AWS - Cost Optimization Pillar - White Paper](https://d0.awsstatic.com/whitepapers/architecture/AWS-Cost-Optimization-Pillar.pdf?ref=wellarchitected-ws)

- [AWS Tagging Best Practices](https://d1.awsstatic.com/whitepapers/aws-tagging-best-practices.pdf)
