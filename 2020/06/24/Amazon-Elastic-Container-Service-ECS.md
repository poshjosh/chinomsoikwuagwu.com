---
path: "./2020/06/24/Amazon-Elastic-Container-Service-ECS.md"
date: "2020-06-24T17:55:00"
title: "AWS API Gateway Quick Reference"
description: "Quick Reference - Amazon Elastic Container Service ECS Cheat sheet"
tags: ["AWS", "Amazon", "Amazon Elastic Container Service (Amazon ECS)", "ECS", "Fargate", "task definition", "task scheduling", "ecs cluster", "capacity provider", "capacity provider strategy", "task networking", "task placement", "task lifecycle", "windows container"]
lang: "en-us"
---

### Introduction ###

Amazon Elastic Container Service (Amazon ECS) is an AWS managed service for
managing containers. ECS makes it easy to run, stop, and manage Docker containers
on a cluster.

- Launch and stop container-based applications with simple API calls
- Get the state of your cluster from a centralized service
- Provides access to many familiar Amazon EC2 features.
- Schedule the placement of containers across your cluster based
on your resource needs, isolation policies, and availability requirements.

Use cases: create a consistent deployment and build experience, manage, and scale:
- Batch and Extract-Transform-Load (ETL) workloads
- Sophisticated application architectures on a microservices model.

AWS Elastic Beanstalk can also be used to rapidly develop, test, and deploy Docker
containers in conjunction with other components of your application infrastructure;
however, using Amazon ECS directly provides more fine-grained control and access
to a wider set of use cases.

__ECS Launch Types:__

- Fargate
- EC2

__Task Definitions__

To prepare your application to run on Amazon ECS, you create a task definition.
The task definition is a text file, in JSON format, that describes one or more
containers, up to a maximum of ten, that form your application. `Maximum of 10
containers in a task definition`

__Tasks and Scheduling__

A task is the instantiation of a task definition within a cluster. After you
have created a task definition for your application within Amazon ECS, you can
specify the number of tasks that will run on your cluster.

__Clusters__

When you run tasks using Amazon ECS, you place them on a cluster, which is a
logical grouping of resources. When using the Fargate launch type with tasks
within your cluster, Amazon ECS manages your cluster resources. When using the
EC2 launch type, then your clusters are a group of container instances you manage.
An Amazon ECS container instance is an Amazon EC2 instance that is running the
Amazon ECS container agent. Amazon ECS downloads your container images from a
registry that you specify, and runs those images within your cluster. When you
first use Amazon ECS, a default cluster is created for you, but you can create
multiple clusters in an account to keep your resources separate.

### Integrating with other Services ###

- AWS Fargate is a technology that you can use with Amazon ECS to run containers
without having to manage servers or clusters of Amazon EC2 instances. With AWS
Fargate, you no longer have to provision, configure, or scale clusters of virtual
machines to run containers. This removes the need to choose server types, decide
when to scale your clusters, or optimize cluster packing.

- In Amazon ECS, `IAM` can be used to control access at the container instance
level using IAM roles, and at the task level using IAM task roles.

- You can use `Auto Scaling` with a Fargate task within a service to scale in
response to a number of metrics or with an EC2 task to scale the container
instances within your cluster.

- You can use `Elastic Load Balancing` to create an endpoint that balances
traffic across services in a cluster.

- You can define clusters, task definitions, and services as entities in an
AWS `CloudFormation` script.

__AWS Fargate__

The following task definition parameters are not valid in Fargate tasks:

-    disableNetworking - Fargate require that the network mode is set to `awsvpc`.

-    dnsSearchDomains

-    dnsServers

-    dockerSecurityOptions

-    extraHosts

-    gpu

-    ipcMode

-    links

-    pidMode

-    placementConstraints

-    privileged

-    systemControls

The following task definition parameters are valid in Fargate tasks, but have limitations that should be noted:

-    `linuxParameters` – When specifying Linux-specific options that are applied to the container, for capabilities the add parameter is not supported. The devices, sharedMemorySize, and tmpfs parameters are not supported. For more information, see Linux Parameters.

-    `volumes` – Fargate tasks only support bind mount host volumes, so the dockerVolumeConfiguration parameter is not supported. For more information, see Volumes.

### Capacity Providers ###

Amazon ECS capacity providers enable you to manage the infrastructure the tasks in your clusters use. Each cluster can have one or more capacity providers and an optional default capacity provider strategy. The capacity provider strategy determines how the tasks are spread across the cluster's capacity providers. When you run a task or create a service, you may either use the cluster's default capacity provider strategy or specify a capacity provider strategy that overrides the cluster's default strategy.

- __Capacity Providers__

  * For `AWS Fargate` users, the FARGATE and FARGATE_SPOT capacity providers
  are reserved and available to be used without the need to create them. They can also not be deleted.

  * For `Amazon EC2` users, a capacity provider consists of a name, an Auto Scaling group, and the settings for managed scaling and managed termination protection. This type of capacity provider is used when enabling cluster auto scaling.

- __Capacity Provider Strategy__

  A capacity provider strategy gives you control
  over how your tasks use one or more capacity providers. When you run a task or
  create a service, you specify a capacity provider strategy. A capacity provider
  strategy consists of one or more capacity providers with an optional base and
  weight specified for each provider.

  For example, if you have a strategy that contains two capacity providers and
  you specify a weight of 1 for capacityProviderA and a weight of 4 for
  capacityProviderB, then for every one task that is run using capacityProviderA,
  four tasks would use capacityProviderB.

- 6 = Max capacity providers in a strategry  
- No mixing of capacity provider types in a strategy, but allowed in a cluster.
- Using capacity providers is not supported when using the blue/green deployment type for your services.
- Using capacity providers is not supported when using Classic Load Balancers for your services.

### Auto scaling ###

>Amazon ECS cluster auto scaling enables you to have more control over how you scale the Amazon EC2 instances within a cluster. When creating an Auto Scaling group capacity provider with managed scaling enabled, Amazon ECS manages the scale-in and scale-out actions of the Auto Scaling group used when creating the capacity provider. On your behalf, Amazon ECS creates an AWS Auto Scaling scaling plan with a target tracking scaling policy based on the target capacity value you specify. Amazon ECS then associates this scaling plan with your Auto Scaling group.

- The Amazon ECS service-linked IAM role is required to use cluster auto scaling.

- When using capacity providers with Auto Scaling groups, the   autoscaling:CreateOrUpdateTags   permission is needed on the IAM user creating the capacity provider. This is because Amazon ECS adds a tag to the Auto Scaling group when it associates it with the capacity provider.

- Ensure any tooling you use does not remove the `AmazonECSManaged` tag from the Auto Scaling group. If this tag is removed, Amazon ECS is not able to manage it when scaling your cluster.

### Cluster Management ###

__Updating Cluster Settings__

- `Only supported cluster setting is containerInsights which enable/disable CloudWatch Insights`
Currently, the only supported cluster setting is containerInsights, which allows you to enable or disable CloudWatch Container Insights for an existing cluster.

- `The state of this value for a deleted container will persist to a newly created container with the same name, if created within 7 days`
Currently, if you delete an existing cluster that does not have Container Insights enabled and then create a new cluster with the same name with Container Insights enabled, Container Insights will not actually be enabled. If you want to preserve the same name for your existing cluster and enable Container Insights, you must wait 7 days before you can re-create it.

__Deleting a Cluster__

If you are finished using a cluster, you can delete it. Once deleted, the cluster will transition to the INACTIVE state. Clusters with an INACTIVE status may remain discoverable in your account for a period of time. However, this behavior is subject to change in the future, so you should not rely on INACTIVE clusters persisting. `Deleted clusters may remain discoverable in your account for a period of time`

If your cluster was created with the AWS Management Console then the AWS CloudFormation stack that was created for your cluster is also deleted when you delete your cluster.

### Application Architecture ###

The launch type you are using is a key differentiator for application architecture.

__Fargate Launch Type__

You should put multiple containers in the same task definition if:

-    Containers share a common lifecycle (that is, they should be launched and terminated together).

-    Containers are required to be run on the same underlying host (that is, one container references the other on a localhost port).

-    You want your containers to share resources.

-    Your containers share data volumes.

__EC2 Launch Type__

You should create task definitions that group the containers that are used for a common purpose, and separate the different components into multiple task definitions. As an example, imagine an application that consists of the following components:

-    A frontend service that displays information on a webpage

-    A backend service that provides APIs for the frontend service

-    A data store

You should create three task definitions each specifying one container. However,
you could have three front-end service containers, two backend service containers,
and one data store service container distributed as shown in the following diagram.

__ECS - 3 tier application__
<br/>![ECS - 3 tier application](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/images/application.png)
<br/>_ECS - 3 tier application. Source: docs.aws.amzaon.com/AmazonECS__

### Working with Tasks ###

__Using Data Volumes in Tasks__

For Fargate tasks, the following data volume formats are supported:

-    Amazon EFS volumes for persistent storage. For more information, see Amazon EFS Volumes.

-    Ephemeral storage for nonpersistent storage. For more information, see Fargate Task Storage.

For EC2 tasks, use data volumes in the following common examples:

-    To provide persistent data volumes for use with a container

-    To define an empty, nonpersistent data volume and mount it on multiple containers

-    To share defined data volumes at different locations on different containers on the same container instance

-    To provide a data volume to your task that is managed by a third-party volume driver

The lifecycle of the volume can be tied to either a specific task or to the lifecycle of a specific container instance.

__Task Networking with the `awsvpc` Network Mode__

Every task that is launched from a task definition (with `awsvpc`) gets:

- Its own elastic network interface (ENI)

- A primary private IP address.

A task can only have one ENI associated with it at a given time.

- Fargate launch type, the task ENI that is created is fully managed by AWS Fargate.

- EC2 launch type, the task ENI that is created is fully managed by Amazon ECS.

__Task Placement__

A `task placement strategy` is an algorithm for selecting instances for task placement or tasks for termination. For example, Amazon ECS can select instances at random, or it can select instances such that tasks are distributed evenly across a group of instances.

- binbpack - Tasks are placed on container instances so as to leave the least
amount of unused CPU or memory. This strategy minimizes the number of container instances in use.

- random - Tasks are placed randomly.

- spread - Tasks are placed evenly based on the specified value. Accepted values are instanceId (or host, which has the same effect), or any platform or custom attribute that is applied to a container instance, such as attribute:ecs.availability-zone.

A `task placement constraint` is a rule that is considered during task placement. For example, you can use constraints to place tasks based on Availability Zone or instance type. You can also associate attributes, which are name/value pairs, with your container instances and then use a constraint to place tasks based on attribute.

- distinctInstance - Place each task on a different container instance.

- memberOf - Place tasks on container instances that satisfy an expression.

__Task Lifecycle__

Amazon ECS tracks tasks' `lastStatus` and `desiredStatus`

__Task Lifecycle__
<br/>![Task Lifecycle](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/images/task-lifecycle.png)
<br/>_Task Lifecycle. Source: docs.aws.azmaon.com/AmazonECS_

__Task Retirement__

A task can be scheduled for retirement in the following scenarios:

- Irreparable failure - AWS detects the irreparable failure of the underlying hardware hosting the task.

- Scurity vulnerability - Your task uses the Fargate launch type and is running on a platform version that has a security vulnerability that requires you to replace the tasks by launching new tasks using a patched platform version.

### Specifying Sensitive Data ###

Amazon ECS enables you to inject sensitive data into your containers by:

- __AWS Secrets Manager__

Storing your sensitive data in AWS Secrets Manager secrets and then referencing them in your container definition. Sensitive data stored in Secrets Manager secrets can be exposed to a container as environment variables or as part of the log configuration.

- __AWS Systems Manager__

Storing your sensitive data in AWS Systems Manager Parameter Store parameters and then referencing them in your container definition.

- __Specifying environment variables__

`For both Systems Manager and Secrets Manager container will not received updated
sensitive data automatically`. Sensitive data is injected into your container when the container is initially started. If the secret is subsequently updated or rotated, the container will not receive the updated value automatically. You must either launch a new task or if your task is part of a service you can update the service and use the Force new deployment option to force the service to launch a fresh task.

### Further Notes ###

`Use appropriate IAM role` - Because the Amazon ECS container agent makes calls to Amazon ECS on your behalf, you must launch container instances with an IAM role that authenticates to your account and provides the required resource permissions.
In most cases, the Amazon ECS instance role is automatically created for you in the console first-run experience.

`Container connection to ECS service endpoint` - Container instances need access to communicate with the Amazon ECS service endpoint. This can be through an `interface VPC endpoint` or through your container instances having `public IP addresses`, if your container does not have a public ip address then it must use `NAT`.

Because each container instance has unique state information that is stored locally on the container instance and within Amazon ECS:

- `You should not deregister an instance from one cluster and re-register it into another`. To relocate container instance resources, we recommend that you terminate container instances from one cluster and launch new container instances with the latest Amazon ECS-optimized Amazon Linux 2 AMI in the new cluster.

- `You cannot stop a container instance and change its instance type. Instead, terminate the container instance and launch a new container instance with the desired instance size` and the latest Amazon ECS-optimized Amazon Linux 2 AMI in your desired cluster.

- `If you have duplicate container instance IDs for the same Amazon EC2 instance ID, you can safely deregister the duplicates that are listed as ACTIVE with an agent connection status of FALSE.`
>If you stop and start a container instance, or reboot that instance, some older versions of the Amazon ECS container agent register the instance again without deregistering the original container instance ID. In this case, Amazon ECS lists more container instances in your cluster than you actually have. This issue is fixed in the current version of the Amazon ECS container agent.

- Amazon EC2 terminates, stops, or hibernates your Spot Instance when the Spot price exceeds the maximum price for your request or capacity is no longer available. Amazon EC2 provides a Spot Instance interruption notice, which gives the instance a two-minute warning before it is interrupted. If Amazon ECS Spot Instance draining is enabled on the instance, ECS receives the Spot Instance interruption notice and places the instance in `DRAINING` status.

- ECS Spot instance draining not supported If you specified either:

  * The `hibernate instance` interruption behavior

  * `Spot Fleet`

- Connect to your instance using SSH, to perform basic administrative tasks.

- You can configure your container instances to send log information to CloudWatch Logs.

- Remotely manage container instance configuration - You can use the Run Command capability in AWS Systems Manager to securely and
remotely manage the configuration of your Amazon ECS container instances. Run Command provides a simple way to perform common administrative tasks without logging on locally to the instance. You can manage configuration changes across your clusters by simultaneously executing commands on multiple container instances. Run Command reports the status and results of each command.

- Following deregistration, the container instance is no longer able to accept new tasks. If you have tasks running on the container instance when you deregister it, these tasks remain running until you terminate the instance or the tasks stop through some other means. However, these tasks are orphaned (no longer monitored or accounted for by Amazon ECS).

__Resources and Tags__

Amazon ECS resources, including task definitions, clusters, tasks, services, and container instances, are assigned an Amazon Resource Name (ARN) and a unique resource identifier (ID). These resources can be tagged with values that you define, to help you organize and identify them.

__Quotas__

100 - The maximum number of public IP addresses used by tasks using the Fargate launch type, per Region.

__Monitoring__

`CloudWatch alarms` – Watch a single metric over a time period that you specify, and perform one or more actions based on the value of the metric relative to a given threshold over a number of time periods.

`CloudWatch Logs` – Monitor, store, and access the log files from the containers in your Amazon ECS tasks by specifying the awslogs log driver in your task definitions.

`CloudWatch Events` – Match events and route them to one or more target functions or streams to make changes, capture state information, and take corrective action.

`CloudTrail log monitoring` – Share log files between accounts, monitor CloudTrail log files in real time by sending them to CloudWatch Logs

`Amazon ECS Events and EventBridge` - You can use Amazon ECS events for EventBridge to receive near real-time notifications regarding the current state of your Amazon ECS clusters. If your tasks are using the Fargate launch type, you can see the state of your tasks. If your tasks are using the EC2 launch type, you can see the state of both the container instances and the current state of all tasks running on those container instances. For services, you can see events related to the health of your service.

__Windows containers__

- Cannot run on Linux container instances and vice versa.

- Only supported for tasks that use the EC2 launch type.

- Cannot support all the task definition parameters that are available for Linux containers.

- Windows server Docker images are large (9 GiB), so your container instances require more storage space than Linux container instances, which typically have smaller image sizes.

### Takeaways ###

- ECS Launch Types: Fargate, EC2

- A task definition is a text file, in JSON format, that describes one or more
containers.

- `Maximum of 10 containers in a task definition`

- When you run tasks using Amazon ECS, you place them on a cluster, which is a
logical grouping of resources.

  * Fargate launch type - AWS manages cluster.
  * EC2 launch type - you manage cluster.

- In Amazon ECS, `IAM` can be used to control access at the container instance
level using IAM roles, and at the task level using IAM task roles.

- You can use `Auto Scaling` with a Fargate task within a service to scale in
response to a number of metrics or with an EC2 task to scale the container
instances within your cluster.

- You can use `Elastic Load Balancing` to create an endpoint that balances
traffic across services in a cluster.

- You can define clusters, task definitions, and services as entities in an
AWS `CloudFormation` script.

- The Amazon ECS service-linked IAM role is required to use cluster auto scaling.

- Ensure any tooling you use does not remove the `AmazonECSManaged` tag from the Auto Scaling group. If this tag is removed, Amazon ECS is not able to manage it when scaling your cluster.

- `Only supported cluster setting is containerInsights which enable/disable CloudWatch Insights`

- `The state of this value for a deleted container will persist to a newly created container with the same name, if created within 7 days`

- `Deleted clusters may remain discoverable in your account for a period of time`

- If your cluster was created with the AWS Management Console then the AWS
CloudFormation stack that was created for your cluster is also deleted when
you delete your cluster.

- Every task that is launched from a task definition (with `awsvpc`) gets:

  * Its own elastic network interface (ENI)

  * A primary private IP address.

- A task can only have one ENI associated with it at a given time.

  * Fargate launch type, the task ENI that is created is fully managed by AWS Fargate.

  * EC2 launch type, the task ENI that is created is fully managed by Amazon ECS.

A `task placement strategy` is an algorithm for selecting instances for task placement or tasks for termination.

- binbpack - Tasks are placed on container instances so as to leave the least
amount of unused CPU or memory. This strategy minimizes the number of container instances in use.

- random - Tasks are placed randomly.

- spread - Tasks are placed evenly based on the specified value.

A `task placement constraint` is a rule that is considered during task placement. For example, you can use constraints to place tasks based on Availability Zone or instance type.

- A task can be scheduled for retirement in the following scenarios:

- Irreparable failure - AWS detects the irreparable failure of the underlying hardware hosting the task.

- Scurity vulnerability - Your task uses the Fargate launch type and is running on a platform version that has a security vulnerability that requires you to replace the tasks by launching new tasks using a patched platform version.

- Amazon ECS enables you to inject sensitive data into your containers by:

  * __AWS Secrets Manager__ - Sensitive data stored in Secrets Manager secrets can be exposed to a container as environment variables or as part of the log configuration.

- __AWS Systems Manager__ - Sensitive data store in AWS Systems Manager Parameter Store parameters can be referenced in your container definition.

- __Specifying environment variables__

- `For both Systems Manager and Secrets Manager container will not received updated sensitive data automatically`.

`Container connection to ECS service endpoint` - Container instances need access to communicate with the Amazon ECS service endpoint. This can be through an `interface VPC endpoint` or through your container instances having `public IP addresses`, if your container does not have a public ip address then it must use `NAT`.

Because each container instance has unique state information that is stored locally on the container instance and within Amazon ECS:

- `You should not deregister an instance from one cluster and re-register it into another`.

- `You cannot stop a container instance and change its instance type. Instead, terminate the container instance and launch a new container instance with the desired instance size`

- `If you have duplicate container instance IDs for the same Amazon EC2 instance ID, you can safely deregister the duplicates that are listed as ACTIVE with an agent connection status of FALSE.`
>If you stop and start a container instance, or reboot that instance, some older versions of the Amazon ECS container agent register the instance again without deregistering the original container instance ID. In this case, Amazon ECS lists more container instances in your cluster than you actually have. This issue is fixed in the current version of the Amazon ECS container agent.

- ECS Spot instance draining not supported If you specified either:

  * The `hibernate instance` interruption behavior

  * `Spot Fleet`

- Connect to your instance using SSH, to perform basic administrative tasks.

- You can configure your container instances to send log information to CloudWatch Logs.

- Remotely manage container instance configuration - Use the Run Command capability in AWS Systems Manager.

- If you have tasks running on the container instance when you deregister it, these tasks remain running until you terminate the instance or the tasks stop through some other means. However, these tasks are orphaned (no longer monitored or accounted for by Amazon ECS).

- `100` - The maximum number of public IP addresses used by tasks using the Fargate launch type, per Region.

`CloudWatch alarms` – Watch a single metric over a time period that you specify, and perform one or more actions based on the value of the metric relative to a given threshold over a number of time periods.

`CloudWatch Logs` – Monitor, store, and access the log files from the containers in your Amazon ECS tasks by specifying the awslogs log driver in your task definitions.

`CloudWatch Events` – Match events and route them to one or more target functions or streams to make changes, capture state information, and take corrective action.

`CloudTrail log monitoring` – Share log files between accounts, monitor CloudTrail log files in real time by sending them to CloudWatch Logs

`Amazon ECS Events and EventBridge` - You can use Amazon ECS events for EventBridge to receive near real-time notifications regarding the current state of your Amazon ECS clusters. If your tasks are using the Fargate launch type, you can see the state of your tasks. If your tasks are using the EC2 launch type, you can see the state of both the container instances and the current state of all tasks running on those container instances. For services, you can see events related to the health of your service.

- Windows containers cannot run on Linux container instances and vice versa.

- Windows containers only supported for tasks that use the EC2 launch type.

- Windows containers cannot support all the task definition parameters that are available for Linux containers.
