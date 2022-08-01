---
path: "./2020/02/14/AWS-Load-Balancers_How-they-work-and-differences-between-them.md"
date: "2020-02-14T22:19:43"
title: "AWS Load Balancers - How they work and differences between them"
description: "AWS Load Balancers - everything you need to know about them"
tags: ["AWS", "Elastic Load Balancing (ELB)", "Classic Load Balancer", "Application Load Balancer", "Network Load Balancer", "target group", "load balancer listener", "target type", "load balancer node", "cross-zone node balancing", "load balancer scheme"]
lang: "en-us"
---

### Introduction ###

Elastic Load Balancing automatically distributes your incoming application traffic across multiple targets, such as EC2 instances. It monitors the health of registered targets and routes traffic only to the healthy targets. Elastic Load Balancing supports three types of load balancers: Classic, Application and Network Load Balancers.

This article will focus on both application and network load balancers, but
will begin with a note on classic load balancers.

The article is an estimated 30 minute read.

### A Note on Classic Load Balancers ###

Classic load balancers are the legacy load balancers and should be avoided
where possible. However, using a Classic Load Balancer instead of an
Application Load Balancer has the following benefits:

- Support for EC2-Classic
- Support for TCP and SSL listeners
- Support for sticky sessions using application-generated cookies

### Load Balancer Components common to Application and Network Load Balancers ###

- Each __target group__ routes requests to one or more registered targets, such as EC2 instances, using the TCP protocol and the port number that you specify.

  * You can register a target with multiple target groups.
  * You can configure health checks on a per target group basis.
  * Health checks are performed on all targets registered to a target group that is specified in a listener rule for your load balancer.

- A __listener__ checks for connection requests from clients, using the protocol and port that you configure, and forwards requests to a target group.

  * You add one or more listeners to your load balancer.

- __Target type__ of the target group determines whether you register targets by instance ID or IP address.

  * `Instance ID`  - The source IP addresses of the clients are preserved and provided to your applications.
  * `IP address` - The source IP addresses are the private IP addresses of the load balancer nodes. However for Network Load Balancers, If your applications need the IP addresses of the clients, enable Proxy Protocol and get the client IP addresses from the Proxy Protocol header.

__Increase Fault Tolerance for your Application__

Enable multiple Availability Zones for your load balancer and ensure that each target group has at least one target in each enabled Availability Zone.

### Application Load Balancer ###

An Application Load Balancer functions at the application layer, the seventh layer of the Open Systems Interconnection (OSI) model. After the load balancer receives a request, it evaluates the listener rules in priority order to determine which rule to apply, and then selects a target from the target group for the rule action.

- You can configure listener rules to route requests to different target groups based on the content of the application traffic.
- Routing is performed independently for each target group, even when a target is registered with multiple target groups.
- You can configure the routing algorithm used at the target group level.
- The default routing algorithm is round robin; alternatively, you can specify the least outstanding requests routing algorithm.

__Additional Notes on Application Load Balancer Components__

- A __listener__ checks for connection requests from clients, using the protocol and port that you configure.

  * Support for `HTTP`, `HTTPS`, `WebSockets` as well as `HTTP/2 with HTTPS listeners`.
  * You can use an HTTPS listener to offload the work of encryption and decryption to your load balancer so that your applications can focus on their business logic.
  * If the listener protocol is HTTPS, you must deploy at least one SSL server certificate on the listener
  * __Listener Rules___ - The rules that you define for a listener determine how the load balancer routes requests to its registered targets.

    - Each rule consists of a priority (lowest to highest), one or more actions, and one or more conditions.
    - When you create a listener, you must define actions for the default rule.
    - Default rules can't have conditions.

- __Target type__ In addition to instance ID and IP address, application load
balancer supports lamda functions as targets.

  * `Lambda Function` - You can register a `single` lambda function

__More on Application Load Balancers__  

__Load Balancer Security Groups__ - The rules for the security groups associated with your load balancer security group must allow traffic in both directions on both the listener and the health check ports. Whenever you add a listener to a load balancer or update the health check port for a target group, you must review your security group rules to ensure that they allow traffic on the new port in both directions.

__Load Balancer States__ - `provisioning`, `active`, `failed`

__IP Address Types__ - `ipv4`, `dual-stack` (ipv4 or ipv6) - Elastic Load
    Balancing provides an AAAA DNS record for the load balancer (for the ipv6)

__Connection Idle Timeout__ - `60 seconds` is the default idle timeout for load balancers. For each request that a client makes through a load balancer, the load balancer maintains two connections.

- `The front-end connection` is between a client and the load balancer.
- `The back-end connection` is between the load balancer and a target.

To ensure that lengthy operations such as file uploads have time to complete, send at least 1 byte of data before each idle timeout period elapses, and increase the length of the idle timeout period as needed.

For back-end connections, Amazon recommends that you:

- `Enable the HTTP keep-alive option for your EC2 instances.` You can enable HTTP keep-alive in the web server settings for your EC2 instances. If you enable HTTP keep-alive, the load balancer can reuse back-end connections until the keep-alive timeout expires.
- `Configure the idle timeout of your application to be larger than the idle timeout configured for the load balancer.`

### Application Load Balancer Target Groups ###

- __Target__ in a target group.

  * You cannot specify publicly routable IP addresses.
  * You cannot register the IP addresses of another Application Load Balancer in the same VPC.
  * If the other Application Load Balancer is in a VPC that is peered to the load balancer VPC, you can register its IP addresses.

- __Routing Algorithm__ `Round robin` (default), `least outstanding requests`
You can compare the effect of both algorithms using the following CloudWatch
metrics: RequestCount, TargetConnectionErrorCount, and TargetResponseTime.

  Considerations:

  * You cannot enable both least outstanding requests and slow start mode.

  * If you enable sticky sessions, this overrides the routing algorithm of the target group after the initial target selection.

  * With HTTP/2, the load balancer converts the request to multiple HTTP/1.1 requests, so least outstanding request treats each HTTP/2 request as multiple requests.

  * When you use least outstanding requests with WebSockets, the target is selected using least outstanding requests. The load balancer creates a connection to this target and sends all messages over this connection.

- __Deregistration Delay__ `300 seconds` is the default value for: length of
time to wait for deregistration to complete. Once deregistration begins, no new
connections are accepted. However ELB waits `deregistration delay` seconds
for in-flight requests to complete and then moves from the `draining` state to
the `unused` state.

  * If a deregistering target has no in-flight requests and no active connections, Elastic Load Balancing immediately completes the deregistration process, without waiting for the deregistration delay to elapse. However, even though target deregistration is complete, the status of the target will be displayed as draining until the deregistration delay elapses.

  * If a deregistering target terminates the connection before the deregistration delay elapses, the client receives a 500-level error response.

- __Slow Start Mode__ Can be enabled on a target group. By default, a target starts to receive its full share of requests as soon as it is registered with a target group and passes an initial health check. Using slow start mode gives targets time to warm up before the load balancer sends them a full share of requests.

  Considerations:

  * You cannot enable both slow start mode and least outstanding requests.
  * When you enable slow start for an empty target group and then register targets using a single registration operation, these targets do not enter slow start mode. Newly registered targets enter slow start mode only when there is at least one healthy target that is not in slow start mode.
  * de-registration -> re-registration as well as exiting -> re-entering does not remove slow start mode.

- __Sticky Sessions__ - Sticky sessions are a mechanism to route requests to the same target in a target group. To use sticky sessions,
the client must support cookies.

  * Enabled at the target group level
  * Elastic load balancing uses a cookie named `AWSALB` to maintain session
  * You can set the duration for the stickiness of the load balancer-generated cookie, in seconds
  * With CORS (cross-origin resource sharing) requests, some browsers require SameSite=None; Secure to enable stickiness. In this case, Elastic Load Balancing generates a second stickiness cookie, AWSALBCORS, which includes the same information as the original stickiness cookie plus this SameSite attribute. Clients receive both cookies.
  * Application Load Balancers support load balancer-generated cookies only

  __Considerations:__

  * The clients must support cookies.
  * If you are using multiple layers of Application Load Balancers, you can enable sticky sessions on one layer only, because the load balancers would use the same cookie name.
  * WebSockets connections are inherently sticky. If the client requests a connection upgrade to WebSockets, the target that returns an HTTP 101 status code to accept the connection upgrade is the target used in the WebSockets connection. After the WebSockets upgrade is complete, cookie-based stickiness is not used.
  * Application Load Balancers use the Expires attribute in the cookie header instead of the Max-Age header.
  * Application Load Balancers do not support cookie values that are URL encoded.

### Monitoring Application Load Balancers ###

You can use the following features to monitor your load balancers, analyze traffic patterns, and troubleshoot issues with your load balancers and targets.

__CloudWatch metrics__

    >You can use Amazon CloudWatch to retrieve statistics about data points for your load balancers and targets as an ordered set of time-series data, known as metrics. You can use these metrics to verify that your system is performing as expected. For more information, see [CloudWatch Metrics for Your Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html).

- For example: Metric for total number of healthy targets for a load balancer over a specified time period
- For example: CloudWatch alarm to monitor a specified metric and initiate an action (such as sending a notification to an email address) if the metric goes outside what you consider an acceptable range.
- The AWS/ApplicationELB namespace includes the following metrics for load balancers:
`ActiveConnectionCount`, `ClientTLSNegotiationErrorCount`, `HealthyHostCount`, `LambdaInternalError`, `ELBAuthError`
- To filter the metrics for your Application Load Balancer, use the following dimensions.
`AvailabilityZone`, `LoadBalancer`, `TargetGroup`

__Access logs__

>You can use access logs to capture detailed information about the requests made to your load balancer and store them as log files in Amazon S3. You can use these access logs to analyze traffic patterns and to troubleshoot issues with your targets. For more information, see [Access Logs for Your Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html).

- `Disabled by default`.
- Logs `encrypted`.
- Logs `stored in S3 bucket you specify`.
- Each log contains information such as the time the request was received, the client's IP address, latencies, request paths, and server responses.
- You are charged storage costs for Amazon S3, but not charged for the bandwidth used by Elastic Load Balancing to send log files to Amazon S3.
- __Elastic Load Balancing logs requests on a best-effort basis. Amazon recommends that you use access logs to understand the nature of the requests, not as a complete accounting of all requests__
- S3 Bucket Requirements

  * The bucket must be located in the same Region as the load balancer.
  * Amazon S3-Managed Encryption Keys (SSE-S3) is required. No other encryption options are supported.
  * The bucket must have a bucket policy that grants Elastic Load Balancing permission to write the access logs to your bucket.

__Request tracing__

>You can use request tracing to track HTTP requests. The load balancer adds a header with a trace identifier to each request it receives. For more information, see [Request Tracing for Your Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-request-tracing.html).

__CloudTrail logs__

>You can use AWS CloudTrail to capture detailed information about the calls made to the Elastic Load Balancing API and store them as log files in Amazon S3. You can use these CloudTrail logs to determine which calls were made, the source IP address where the call came from, who made the call, when the call was made, and so on. For more information, see [Logging API Calls for Your Application Load Balancer Using AWS CloudTrail](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudtrail-logs.html).

- If you create a trail, you can enable continuous delivery of CloudTrail events to an Amazon S3 bucket, including events for Elastic Load Balancing.
- Clould trail is enabled by default on your AWS account. Hence, if you don't configure a trail, you can still view the most recent events in the CloudTrail console in Event history. Using the information collected by CloudTrail, you can determine, _what_, _where_, _who_, _when_ and more:

  * the request that was made to Elastic Load Balancing
  * the IP address from which the request was made  
  * who made the request  
  * when it was made  
  * additional details.

-  By default, when you create a trail in the console, the trail applies to all AWS Regions.
- To monitor other actions for your load balancer, such as when a client makes a request to your load balancer, use access logs.

### Benefits of Migrating from a Classic Load Balancer to an Application Load Balancer ###

Using an Application Load Balancer instead of a Classic Load Balancer has the following benefits:

- `Improved load balancer performance.`
- `Support for path-based routing.` - You can configure rules for your listener that forward requests based on the URL in the request. This enables you to structure your application as smaller services, and route requests to the correct service based on the content of the URL.
- `Support for host-based routing.` - You can configure rules for your listener that forward requests based on the host field in the HTTP header. This enables you to route requests to - multiple domains using a single load balancer.
- `Support for routing based on fields in the request`, such as standard and custom HTTP headers and methods, query parameters, and source IP addresses.
- `Support for routing requests to multiple applications on a single EC2 instance.` - You can register each instance or IP address with the same target group using multiple ports.
- `Support for redirecting requests from one URL to another.`
- `Support for returning a custom HTTP response.`
- `Support for registering targets by IP address, including targets outside the VPC for the load balancer.`
- `Support for registering Lambda functions as targets.`
- `Support for open authentication` - Support for the load balancer to authenticate users of your applications through their corporate or social identities before routing requests.
- `ECS support` - Support for containerized applications. Amazon Elastic Container Service (Amazon ECS) can select an unused port when scheduling a task and register the task with a target group using this port. This enables you to make efficient use of your clusters.
- `Independent health monitoring` - Support for monitoring the health of each service independently, as health checks are defined at the target group level and many CloudWatch metrics are reported at the target group level. Attaching a target group to an Auto Scaling group enables you to scale each service dynamically based on demand.
Access logs contain additional information and are stored in compressed format.

### Network Load Balancer ###

A Network Load Balancer functions at the fourth layer of the Open Systems Interconnection (OSI) model.

__Additional Notes on Network Load Balancer Components__

- A __listener__ checks for connection requests from clients, using the protocol and port that you configure.

  * Support for `TCP`, `TLS`, `UDP`, `TCP_UDP` as well as WebSockets.
  * You can use an TLS listener to offload the work of encryption and decryption to your load balancer so that your applications can focus on their business logic.
  * If the listener protocol is TLS, you must deploy `exactly one` SSL server certificate on the listener

__More Notes on Network Load Balancers__

- Elastic Load Balancing creates a network interface for each AZ you enable. Each load balancer node in the AZ uses this network interface to get a static IP address.

- When you create the load balancer, you can optionally associate one Elastic IP address with each network interface.

- When you create an Internet-facing load balancer, you can optionally associate one Elastic IP address per subnet.

- Does not support custom security policy

- Security policy should comprise protocols and ciphers

- Does not support certificates with RSA bits higher than 2048 bits

### Monitoring your Network Load Balancers ###

You can use the following features to monitor your load balancers, analyze traffic patterns, and troubleshoot issues with your load balancers and targets.

__CloudWatch metrics__

>You can use Amazon CloudWatch to retrieve statistics about data points for your load balancers and targets as an ordered set of time-series data, known as metrics. You can use these metrics to verify that your system is performing as expected. For more information, see CloudWatch Metrics for Your Network Load Balancer.

- The AWS/NeworkELB namespace includes the following metrics for load balancers:
`ActiveFlowCount`
- To filter the metrics for your Application Load Balancer, use the following dimensions.
`AvailabilityZone`, `LoadBalancer`, `TargetGroup`

__VPC Flow Logs__

>You can use VPC Flow Logs to capture detailed information about the traffic going to and from your Network Load Balancer. For more information, see VPC Flow Logs in the Amazon VPC User Guide.

>Create a flow log for each network interface for your load balancer. There is one network interface per load balancer subnet. To identify the network interfaces for a Network Load Balancer, look for the name of the load balancer in the description field of the network interface.

>There are two entries for each connection through your Network Load Balancer, one for the frontend connection between the client and the load balancer and the other for the backend connection between the load balancer and the target. If the target is registered by instance ID, the connection appears to the instance as a connection from the client. If the security group of the instance doesn't allow connections from the client but the network ACLs for the load balancer subnet allow them, the logs for the network interface for the load balancer show "ACCEPT OK" for the frontend and backend connections, while the logs for the network interface for the instance show "REJECT OK" for the connection.
Access logs

__Access logs__

>You can use access logs to capture detailed information about TLS requests made to your load balancer. The log files are stored in Amazon S3. You can use these access logs to analyze traffic patterns and to troubleshoot issues with your targets. For more information, see Access Logs for Your Network Load Balancer.

- `Disabled by default`.
- Logs `encrypted`.
- Logs `stored in S3 bucket you specify`.
- You are charged storage costs for Amazon S3, but not charged for the bandwidth used by Elastic Load Balancing to send log files to Amazon S3.
- __Elastic Load Balancing logs requests on a best-effort basis. Amazon recommends that you use access logs to understand the nature of the requests, not as a complete accounting of all requests__
- S3 Bucket Requirements

  * The bucket must be located in the same Region as the load balancer.
  * Amazon S3-Managed Encryption Keys (SSE-S3) is required. No other encryption options are supported.
  * The bucket must have a bucket policy that grants Elastic Load Balancing permission to write the access logs to your bucket.

- __Access logs are created only if the load balancer has a TLS listener and they contain information only about TLS requests.__

__CloudTrail logs__

>You can use AWS CloudTrail to capture detailed information about the calls made to the Elastic Load Balancing API and store them as log files in Amazon S3. You can use these CloudTrail logs to determine which calls were made, the source IP address where the call came from, who made the call, when the call was made, and so on. For more information, see Logging API Calls for Your Network Load Balancer Using AWS CloudTrail.

- If you create a trail, you can enable continuous delivery of CloudTrail events to an Amazon S3 bucket, including events for Elastic Load Balancing.
- Clould trail is enabled by default on your AWS account. Hence, if you don't configure a trail, you can still view the most recent events in the CloudTrail console in Event history. Using the information collected by CloudTrail, you can determine, _what_, _where_, _who_, _when_ and more:

  * the request that was made to Elastic Load Balancing
  * the IP address from which the request was made  
  * who made the request  
  * when it was made  
  * additional details.

-  By default, when you create a trail in the console, the trail applies to all AWS Regions.
- To monitor other actions for your load balancer, such as when a client makes a request to your load balancer, use access logs.

### Network Load Balancer Target Groups ###

- When you create a listener, you specify a target group for its default action. Traffic is forwarded to the target group specified in the listener rule. You define health check settings for your load balancer on a per target group basis.

- __Target__ in a target group.

  * You cannot specify publicly routable IP addresses.
  * You cannot register by `Instance ID`:

    - For the following instance types: C1, CC1, CC2, CG1, CG2, CR1, G1, G2, HI1, HS1, M1, M2, M3, and T1
    - If the instance is in a VPC that is peered to the load balancer VPC.

  * You cannot register by `IP Address`:

    - If the target group protocol is UDP or TCP_UDP  
    - If you intend to use an Auto Scaling Group.
    >If you are registering targets by instance ID, you can use your load balancer with an Auto Scaling group [10](#network-load-balancer-instance-id-asg)

  *  After you attach a target group to an Auto Scaling group, Auto Scaling registers your targets with the target group for you when it launches them.

  * If you have micro services on instances registered with a Network Load Balancer, you cannot use the load balancer to provide communication between them unless the load balancer is internet-facing or the instances are registered by IP address.

- __Proxy Protocol__ - Network Load Balancers use Proxy Protocol version 2 to send additional connection information such as the source and destination.

  * If you specify target type of `IP address`, or traffic is from a `VPC endpoint service`, the source IP addresses sent to your application are the private IP addresses of the load balancer nodes. However for Network Load Balancers, If your applications need the IP addresses of the clients, enable Proxy Protocol and get the client IP addresses from the Proxy Protocol header.

- __Sticky Sessions__ - Sticky sessions are a mechanism to route requests to the same target in a target group. To use sticky sessions,
the client must support cookies.

  __Considerations:__

  * Can lead to an uneven distribution of connections and flows, which might impact the availability of your targets. For example, all clients behind the same NAT device have the same source IP address. Therefore, all traffic from these clients is routed to the same target.

  * The load balancer might reset the sticky sessions for a target group if the health state of any of its targets changes or if you register or deregister targets with the target group.

  * Not supported with TLS listeners and TLS target groups.

- Network Load Balancers do not support certificates with RSA bits higher than 2048 bits
- Network Load Balancers do not support custom security policies. [20](#network-load-balancer-custom-security-policy)
- Security policy should comprise protocols and ciphers

__Benefits of Migrating from a Classic Load Balancer to a Network Load Balancer__

  Using a Network Load Balancer instead of a Classic Load Balancer has the following benefits:

  - `Improved load balancer performance.` - Ability to handle volatile workloads and scale to millions of requests per second.
  - `Support for static IP addresses for the load balancer`. You can also assign `one Elastic IP address per subnet enabled for the load balancer`.
  - `Support for registering targets by IP address, including targets outside the VPC for the load balancer.`
  - `Support for routing requests to multiple applications on a single EC2 instance.` - You can register each instance or IP address with the same target group using multiple ports.
  - `ECS support` - Support for containerized applications. Amazon Elastic Container Service (Amazon ECS) can select an unused port when scheduling a task and register the task with a target group using this port. This enables you to make efficient use of your clusters.
  - `Independent health monitoring` - Support for monitoring the health of each service independently, as health checks are defined at the target group level and many Amazon CloudWatch metrics are reported at the target group level. Attaching a target group to an Auto Scaling group enables you to scale each service dynamically based on demand.

### Differences between Network and Application Load Balancers ###

The primary between network and application load balancers is that Network
Load Balancers functions at the fourth (4) layer of the Open Systems
Interconnection (OSI) model, whereas, Application Load Balancers function
at the seventh (7) layer. This difference may seem trivial but it has implications:

Property                    | Network                               | Application                     | Implication
----------------------------|---------------------------------------|---------------------------------|-------------------------------------------------------               
Requests directed based on  | Network and transport layer variables | HTTP request headers/content    | More informed decisions by application load balancer.
App availability based on   | ICMP ping/3 way TCP handshake         | Success and content of response | Network load balancing cannot assure availability of the application            
Multiple apps share one ip  | Can't differentiate apps unless they use different ports | Can differentiate between apps by examining application layer data |

A summary of all the differences for clarity and ease of references is as follows:

Property                  | Network                | Application
--------------------------|------------------------|------------              
Layer of OSI model        | 4                      | 7
IP                        | Static                 | Flexible
Supported protocols       | TCP, TLS, UDP, TCP_UDP | HTTP, HTTPS
Support for lamda targets | No                     | Yes
SSL server certificate    | Exactly One            | At least one
Web access via            | fixed IP               | DNS (URL)

Network Load Balancers expose a fixed IP to the public web, therefore allowing
your application to be predictably reached using these IPs, while allowing you
to scale your application behind the Network Load Balancer using an ASG.

Application and Classic Load Balancers expose a fixed DNS (=URL) rather than
the IP address. So these are incorrect options for the given use-case.

### Load Balancing and Availability Zones ###

- A __load balancer node__ is created in an Availability Zone (AZ) when you enable that AZ for the load balancer.

- By default, each load balancer node distributes traffic across the registered targets in its AZ only.

- If you register targets in an AZ but do not enable the AZ, the registered targets do not receive traffic

- After you disable an Availability Zone, the targets in that Availability Zone remain registered with the load balancer.

- With an Application Load Balancer, you are required by Amazon to enable multiple Availability Zones.

__Cross-Zone Load Balancing__

Enabled by default via the API, CLI and management console. However, via the
management console, you can de - select the option in order to disable.

When cross-zone load balancing is:

- Enabled - each load balancer node distributes traffic across the registered targets in all enabled Availability Zones.

- Disabled - each load balancer node distributes traffic only across the registered targets in its Availability Zone.

The following diagrams demonstrate the effect of cross-zone load balancing. There are two enabled Availability Zones, with two targets in Availability Zone A and eight targets in Availability Zone B. Clients send requests, and Amazon Route 53 responds to each request with the IP address of one of the load balancer nodes. This distributes traffic such that each load balancer node receives 50% of the traffic from the clients. Each load balancer node distributes its share of the traffic across the registered targets in its scope.

If cross-zone load balancing is enabled, each of the 10 targets receives 10% of the traffic. This is because each load balancer node can route its 50% of the client traffic to all 10 targets.

__ELB with Cross-Zone Load Balancing Enabled__
<br/>![ELB with Cross-Zone Load Balancing Enabled](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/images/cross_zone_load_balancing_enabled.png)
<br/>_ELB with Cross-Zone Load Balancing Enabled. Source: docs.aws.amazon.com_

If cross-zone load balancing is disabled:

- Each of the two targets in Availability Zone A receives 25% of the traffic.

- Each of the eight targets in Availability Zone B receives 6.25% of the traffic.

This is because each load balancer node can route its 50% of the client traffic only to targets in its Availability Zone.

__ELB with Cross-Zone Load Balancing Disabled__
<br/>![ELB with Cross-Zone Load Balancing Disabled](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/images/cross_zone_load_balancing_disabled.png)
<br/>_ELB with Cross-Zone Load Balancing Disabled. Source: docs.aws.amazon.com_

### Load Balancer Scheme ###

When you create a load balancer, you must choose whether to make it an internal load balancer or an internet-facing load balancer. Note that when you create a Classic Load Balancer in EC2-Classic, it must be an internet-facing load balancer.

The nodes of an internet-facing load balancer have public IP addresses. The DNS name of an internet-facing load balancer is publicly resolvable to the public IP addresses of the nodes. Therefore, internet-facing load balancers can route requests from clients over the internet.

The nodes of an internal load balancer have only private IP addresses. The DNS name of an internal load balancer is publicly resolvable to the private IP addresses of the nodes. Therefore, internal load balancers can only route requests from clients with access to the VPC for the load balancer.

Both internet-facing and internal load balancers route requests to your targets using private IP addresses. Therefore, your targets do not need public IP addresses to receive requests from an internal or an internet-facing load balancer.

If your application has multiple tiers, you can design an architecture that uses both internal and internet-facing load balancers. For example, this is true if your application uses web servers that must be connected to the internet, and application servers that are only connected to the web servers. Create an internet-facing load balancer and register the web servers with it. Create an internal load balancer and register the application servers with it. The web servers receive requests from the internet-facing load balancer and send requests for the application servers to the internal load balancer. The application servers receive requests from the internal load balancer.

__Internet Facing and Internal Load Balancer__
<br/>![Internet Facing and Internal Load Balancer](https://miro.medium.com/max/1000/1*S1_KaLSMqVkE-WNsBwe9pA.jpeg)
<br/>_Internet Facing and Internal Load Balancer. Source: miro.medium.com_

### Takeaways ###

- __Target type__ of the target group determines whether you register targets
by `instance ID`, `IP address` or `Lamda Function` (single function, application load balancer only)

- Client IP address is not preserved for targets registered by `IP address`.
The source IP addresses are the private IP addresses of the load balancer nodes.

- __Increase Fault Tolerance for your Application__ by enabling multiple AZs
for your load balancer and ensure that each target group has at least one target
in each enabled Availability Zone.

- If the listener protocol is HTTPS (i.e application load balancer), you must
deploy `at least one` SSL server certificate on the listener.

- If the listener protocol is TLS (i.e network load balancer), you must deploy
`exactly one` SSL server certificate on the listener.

- Each rule consists of a priority (lowest to highest), one or more actions, and one or more conditions.

- Default rules can't have conditions.

- You cannot enable both `least outstanding requests` routing algorithm and
`slow start mode`.

- __Deregistration Delay__ `300 seconds` is the default value for: length of
time to wait for deregistration to complete. Once deregistration begins, no new
connections are accepted. However ELB waits `deregistration delay` seconds
for in-flight requests to complete and then moves from the `draining` state to
the `unused` state.

- __Slow Start Mode__ Can be enabled on a target group. Slow start mode gives
targets time to warm up before the load balancer sends the target a full share
of requests.

- __Sticky sessions__ are a mechanism to route requests to
the same target in a target group.

- WebSockets connections are inherently sticky.

- Sticky sessions can lead to an uneven distribution of connections and flows,
which might impact the availability of your targets.

- Monitor you load balancers
  * CloudWatch Metrics -
  * VPC flow logs
  * Access Logs -
  * Request Tracing -
  * CloudTrail logs -

- Access Logs are `encrypted` and `stored in S3 bucket you specify`.

- You are charged storage costs for Amazon S3, but not charged for the
bandwidth used by Elastic Load Balancing to send log files to Amazon S3.

- Do not rely on logs for complete accounting of all requests as elastic Load
Balancing logs requests on a best-effort basis.

- S3 Bucket Requirements for Access Logs
  * The bucket must be located in the same Region as the load balancer.
  * Amazon S3-Managed Encryption Keys (SSE-S3) is required. No other encryption
  options are supported.
  * The bucket must have a bucket policy that grants Elastic Load Balancing
  permission to write the access logs to your bucket.

- Clould trail:
  * Enabled by default on your AWS account but not delivered to an S3 bucket.
  * Using the information collected by CloudTrail, you can determine,
  _what_, _where_, _who_, _when_ and more:
    - The request that was made to Elastic Load Balancing
    - The IP address from which the request was made  
    - Who made the request  
    - When it was made  
    - Additional details.
  * By default, when you create a trail in the console, the trail applies to all AWS Regions  
  * To monitor other actions for your load balancer, such as when a client makes
  a request to your load balancer, use access logs.

__Application Load Balancer__

__Connection Idle Timeout__ - `60 seconds` is the default idle timeout for load balancers.

- For back-end connections (between load balancer and target server), Amazon recommends that you:
  * `Enable the HTTP keep-alive option for your EC2 instances.`
  * `Configure the idle timeout of your application to be larger than the idle timeout configured for the load balancer.`

- __Target__ in a target group for application load balancer.

  * You cannot specify publicly routable IP addresses.
  * You cannot register the IP addresses of another Application Load Balancer in the same VPC.
  * You can register its IP addresses, if the other Application Load Balancer is in a VPC that is peered to the load balancer VPC

- To use sticky sessions for application load balancers, the client must support cookies.
- For multiple layers of Application Load Balancers, you can enable sticky
sessions on one layer only, because the load balancers would use the same cookie name.
- Application Load Balancers do not support cookie values that are URL encoded.
- Each access log contains information such as the time the request was received,
the client's IP address, latencies, request paths, and server responses.

__Network Load Balancer__

- Elastic Load Balancing creates a network interface for each AZ you enable.
Each load balancer node in the AZ uses this network interface to get a static IP address.

- When you create the load balancer, you can optionally associate one Elastic
IP address with each network interface.

- When you create an Internet-facing load balancer, you can optionally
associate one Elastic IP address per subnet.

- Access logs are created only if the load balancer has a TLS listener and
they contain information only about TLS requests.

- __Target__ in a target group of network load balancer.

  * You cannot specify publicly routable IP addresses.
  * You cannot register by `Instance ID`:
    - For the following instance types: C1, CC1, CC2, CG1, CG2, CR1, G1, G2, HI1, HS1, M1, M2, M3, and T1
    - If the instance is in a VPC that is peered to the load balancer VPC.
  * You cannot register by `IP Address`:
    - If the target group protocol is UDP or TCP_UDP  
    - If you intend to use an Auto Scaling Group.
    >If you are registering targets by instance ID, you can use your load balancer with an Auto Scaling group [10](#network-load-balancer-instance-id-asg)

- If you have micro services on instances registered with a Network Load Balancer,
you cannot use the load balancer to provide communication between them unless
the load balancer is internet-facing or the instances are registered by IP address.

- Network Load Balancers do not support custom security policies. [20](#network-load-balancer-custom-security-policy)

- __Sticky Sessions__ are not supported with TLS listeners and TLS target groups.

- Monitoring Application Load Balancers:
Cloudwatch metrics, Access logs, Request tracing, CloudTrail logs

- Monitoring Network Load Balancers:
Cloudwatch metrics, VPC flow logs, Access logs, Cloudtrail logs

__Differences between Network and Application Load Balancers__

Property                    | Network                        | Application                   | Implication
----------------------------|--------------------------------|-------------------------------|-------------------------------------------------------               
Layer of OSI model          | 4                              | 7                             | Application load balancer has access to more info
App availability based on   | ICMP ping/3 way TCP handshake  | Success and content of response  | Network load balancing cannot assure availability of the application            
Multiple apps share one ip  | Can't differentiate apps unless they use different ports | Can differentiate between apps by examining application layer data |
IP                          | Static                         | Flexible
Supported protocols         | TCP, TLS, UDP, TCP_UDP         | HTTP, HTTPS
Support for lamda targets   | No                             | Yes
SSL server certificate      | Exactly One                    | At least one
Monitoring                  | VPC flow logs                  | Request tracing | Applicable to both: CloudWatch, CloudTrail, Access logs

- A __load balancer node__ is created in an Availability Zone (AZ) when you enable that AZ for the load balancer.

- You must enable an AZ before targets registered in that AZ can receive traffic.

- After you disable an Availability Zone, the targets in that Availability Zone
remain registered with the load balancer.

- __Cross-Zone Load Balancing__ is enabled by default via the API, CLI and
management console. However, via the management console, you can de - select
the option in order to disable.

- Both internet-facing and internal load balancers route requests to your
targets using private IP addresses. Therefore, your targets do not need
public IP addresses to receive requests from an internal or an internet-facing load balancer.

__Benefits of Application and Network over Classic Load Balancer__
- `Improved load balancer performance.`
- `ECS support`
- `Independent health monitoring`

__Additional Benefits of Application over Classic Load Balancer__
- Support for `path-based`, `host-based` as well as `routing based on fields in the request`.
- `Support for routing requests to multiple applications on a single EC2 instance.`
- `Support for redirecting requests from one URL to another.`
- `Support for returning a custom HTTP response.`
- `Support for registering targets by IP address, including targets outside the VPC for the load balancer.`
- `Support for registering Lambda functions as targets.`
- `Support for open authentication`

__Additional Benefits of Network over Classic Load Balancer__
- `Improved load balancer performance.`
- `ECS support`
- `Independent health monitoring`
- `Support for static IP addresses for the load balancer`. You can also assign `one Elastic IP address per subnet enabled for the load balancer`.
- `Support for registering targets by IP address, including targets outside the VPC for the load balancer.`
- `Support for routing requests to multiple applications on a single EC2 instance.`

### References ###

- [AWS - Elastic Load Balancing - Application](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)

- [AWS - Elastic Load Balancing - Network](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html)

- [Medium - Difference between application and network load balancer](https://medium.com/awesome-cloud/aws-difference-between-application-load-balancer-and-network-load-balancer-cb8b6cd296a4)

- [AWS - How elastic load balancing works](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/how-elastic-load-balancing-works.html)

### End Notes ###

- <a name="network-load-balancer-instance-id-asg">10</a> - [AWS Network Load Balancer Target Groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html)

- <a name="network-load-balancer-custom-security-policy">20</a> - [AWS Docs - TLS listener for Network Load Balacers](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/create-tls-listener.html)
