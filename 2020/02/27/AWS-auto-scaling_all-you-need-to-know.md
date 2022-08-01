---
path: "./2020/02/27/AWS-auto-scaling_all-you-need-to-know.md"
date: "2020-02-27T10:33:28"
title: "AWS Auto Scaling - All you need to know"
description: "AWS Auto Scaling - everything you need to know"
tags: ["AWS", "auto scaling", "auto scaling group"]
lang: "en-us"
---

### Introduction ###

As demand grows supply lags behind, often leading to revenue loss - or not.
`Enter AWS auto scaling`. Auto scaling automatically scales your AWS cloud
resources to meet demand. For example you could provision thousands of servers
in minutes.

Amazon EC2 Auto Scaling helps you ensure that you have the correct number of
Amazon EC2 instances available to handle the load for your application. This
improves `fault tolerance`, `availability` and `cost`.

__Features of AWS Auto Scaling__

Use AWS Auto Scaling to automatically scale the following resources:

- __Amazon EC2 Auto Scaling groups__: Launch or terminate EC2 instances in an Auto Scaling group.

- __Amazon EC2 Spot Fleet requests__: Launch or terminate instances from a Spot Fleet request, or automatically replace instances that get interrupted for price or capacity reasons.

- __Amazon ECS__: Adjust the ECS service desired count up or down in response to load variations.

  * Amazon ECS can be configured to use Service Auto Scaling to adjust it desired
  count up or down in response to CloudWatch alarms. Service Auto Scaling leverages
  the Application Auto Scaling service to provide this functionality.

  * Amazon ECS publishes CloudWatch metrics with your service's average CPU and
  memory usage. Use these service utilization metrics to scale your service.

- __Amazon DynamoDB__: Enable a DynamoDB table or a global secondary index to increase its provisioned read and write capacity to handle increases in traffic without throttling. DynamoDB auto scaling leverages Application Auto Scaling service to `dynamically
adjust provisioned throughput capacity` on your behalf.

  * Even if DynamoDB auto scaling is managing our table's throughput, you still
  must provide initial settings for read and write capacity.
  * You may need to manually adjust throughput capacity to bulk-load data.

- __Amazon Aurora__: Dynamically adjust the number of Aurora read replicas provisioned for an Aurora DB cluster to handle changes in active connections or workload.

- Amazon EC2 Auto Scaling does not support:

  * Resource-based policies.
  * Access Control Lists (ACLs).

### Auto Scaling Group (ASG) ###

- You create collections of EC2 instances, called __Auto Scaling groups (ASG)__. To
control the number of instances in the group, you specify the following:

  * Minimum number - Auto Scaling ensures that your group never goes below this.

  * Maximum number - Auto Scaling ensures that your group never goes above this.

  * Desired capacity - Auto Scaling ensures that your group has this many instances.

- You specify Desired capacity, either when you create the group or at any time thereafter.

- If you specify scaling policies, then Amazon EC2 Auto Scaling can launch or
terminate instances as demand on your application increases or decreases.

- Your auto scaling group (ASG) uses a launch template or a launch configuration
as a configuration template for its EC2 instances. You can specify information
such as the AMI ID, instance type, key pair, security groups, and block device
mapping for your instances.

- Auto scaling has been validated as being compliant with Payment Card Industry
(PCI) Data Security Standard (DSS).

- An ASG can contain EC2 instances in one or more Availability Zones (AZ) within
the same Region.

- ASGs cannot span multiple Regions.

- For ASGs in a VPC, you can select one or more subnets per AZ.

__Rebalancing Activities__

- Carried out when your ASG becomes unbalanced between AZs.

- ASG launches new instances before terminating the old ones. As a result,
during rebalancing activity, the system can temporarily exceed the specified
maximum capacity of a group by a 10 percent margin (or by a 1-instance margin,
whichever is greater).

__Lifecycle__

- __Lifecycle Hooks__ - You can add a lifecycle hook to your Auto Scaling group
so that you can perform custom actions when instances launch or terminate.

- __Standby__ - Instances in Standby are part of the ASG but not accessible to your application.
This enables you to troubleshoot or make changes to it, and then put it back into service.

__Launching__

Whenever you create an ASG, you must specify either:

- Launch configuration.
- Launch template.
- An EC2 instance - launch configuration created for you.

- Create ASGs from launch templates for the latest features from Amazon EC2.

  * Multiple versions of template.
  * Specify both Spot and On-Demand Instances.
  * Specify multiple instance types.
  * Other features not supported by launch configuration.

- ASG - Only one launch configuration at a time.
- Launch configuration - Many ASGs.

__Tutorial__

[Setup a scaled and load balanced application](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-register-lbs-with-asg.html)

### Configuring ASGs ###

  * Instance type, optionally override launch template.
  * Assign weights to instance types.
  * Specify how much on-demand and spot instances to launch. And optional on-demand base proportion.
  * Prioritize how instance types can benefit from reserved instance or savings plan.
  * Define how spot capacity will be distributed across instance types.

- __Maximum instance lifetime__ specifies the maximum amount of time (in seconds)
that an instance can be in service. Minimum of 604,800 seconds (7 days). To clear
a previously set value, specify a new value of 0.   

- __Merging ASGs__ To merge separate single-zone ASGs into a single ASG
spanning multiple AZs:

  * Rezone one of the single-zone groups into a multi-zone group.
  * Delete the other groups.

This works for groups with or without a load balancer, as long as the new
multi-zone group is in one of the same Availability Zones as the original single-zone groups.

__Scaling Options__

- You can configure your ASG to __Maintain a specified number of running instances__ at all times.
- __Manual__. You specify maximum, minimum or desired capacity of your ASG.
- __Scheduled__. Scaling actions are performed automatically as a function of time
and date. This is useful when you know exactly when to increase or decrease the number of instances in your group

  * You create a scheduled action which tells Amazon EC2 Auto Scaling to perform a scaling action at specified times.
  * A scheduled action does not persist in your account once it has reached its end time.
  * Cooldown periods are not supported.
  * In additon to EC2, you can also schedule action for ECS, DynamoDB, AppStream 2.0, Sport Fleet etc

- __Demand__. Use scaling policies eg CPU utilization of the ASG to stay at around 50 percent target.

  * A scaling policy instructs Amazon EC2 Auto Scaling to track a specific CloudWatch metric, and it defines what action to take when the associated CloudWatch alarm is in `ALARM`.

__Scaling Policy Types__ Increase or decrease the current capacity of the group based on:


  * __Target tracking__ - A target value for a specific metric e.g CPU utilization.

  * __Step__ - A set of scaling adjustments, known as step adjustments, that vary based on the size of the alarm breach.

  * __Simple__ - A single scaling adjustment.

__Multiple Scaling Policies__

- You can use multiple scaling policies. For example, consider an application
that uses an ASG and an SQS queue to send requests to a single EC2 instance.
To help ensure that the application performs at optimum levels, there are two
policies that control when the ASG should scale out. One is a `target tracking`
policy that uses a custom metric to add and remove capacity `based on the number
of SQS messages` in the queue. The other is a step scaling policy that uses the
`CloudWatch CPUUtilization` metric to add capacity when the instance exceeds
90 percent utilization for a specified length of time.

When multiple polices instruct ASG to scale at the same time, the policy that
results in the largest capacity (for both scale out and scale in) is chosen.

__Cooldown period__

- ASG waits for the cooldown period to complete before further scaling activities

- Applicable only to simple scaling policies.

-  Unhealthy instances a replaced irrespective of cooldown period.  

-  `300 seconds` is used if you do not provide value.

__Lifecycle Hooks__

Lifecycle hooks enable you to perform custom actions by pausing instances as an Auto Scaling group launches or terminates them. When an instance is paused, it remains in a wait state either until you complete the lifecycle action using the complete-lifecycle-action command or the CompleteLifecycleAction operation, or until the timeout period ends (one hour by default).

Example uses:

- Before launch - install or configure software on it, making sure that your instance is fully ready before it starts receiving traffic
- Before termination - connect to the instance and download logs or other data before the instance is fully terminated.

Each Auto Scaling group can have multiple lifecycle hooks.

__Cooldowns and Lifecycle Hooks__

You have the option to add lifecycle hooks to your Auto Scaling groups. These hooks enable you to control how instances launch and terminate within an Auto Scaling group so that you can perform custom actions on an instance before it is put into service or before it is terminated. When a lifecycle action occurs, and an instance enters the wait state, scaling activities due to simple scaling policies are paused

### Monitoring ASGs ###

__Health Checks__ - performed periodically by EC2 auto scaling. ASGs could be
configured to use:

- EC2 status checks.
- ELB health checks.
- Custom health checks.

__Health check grace period__ - amount of time Amazon EC2 Auto Scaling waits
before checking the health status of the instance. `Ensure the health check
grace period covers the expected startup time for your application`

You can configure Auto Scaling groups to:

- Send Amazon SNS notifications when Amazon EC2 Auto Scaling launches or terminates instances.
- Submit events to Amazon CloudWatch Events when your Auto Scaling groups launch or terminate instances, or when a lifecycle action occurs.
- You can configure a CloudWatch alarm to monitor certain metrics of your AWS services
- CloudTrail enables you to track the calls made to the Amazon EC2 Auto Scaling API by or on behalf of your AWS account.
- CloudWatch Logs enable you to monitor, store, and access your log files from Amazon EC2 instances, CloudTrail, and other sources.
- CloudWatch Logs can monitor information in the log files and notify you when certain thresholds are met.
- Personal Health Dashboard (PHD) displays information, and also provides notifications that are triggered by changes in the health of AWS resources.

### Miscellany ###

- EC2 Auto Scaling lets you use two different allocation strategies for Spot Instances:

  * __Lowest-price__ – Allocates instances from the Spot Instance pools that have the lowest price at the time of fulfillment. Good fit for fault-tolerant workloads with a low cost of interruption.

    - Time-insensitive workloads
    - Extremely transient workloads
    - Workloads that are easily check-pointed and restarted

  * __Capacity-optimized__ – Allocates instances from the Spot Instance pools with the optimal capacity for the number of instances that are launching, making use of real-time capacity data. good choice for workloads with a high cost of interruption, such as:

    - Big data and analytics
    - Image and media rendering
    - Machine learning
    - High performance computing
