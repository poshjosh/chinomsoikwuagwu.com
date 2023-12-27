---
path: "./2023/11/03/limited-conversations-with-distributed-systems.md"
date: "2023-11-03T02:13:58"
title: "Limited conversations with distributed systems."
description: "Rate limiting distributed systems for resiliency"
tags: ["rate limiting", "distributed systems", "resiliency"]
lang: "en-us"
---

By the way, ChatGPT suggested the title: **The Art of Balancing Control
and Accessibility**

## Background

Houston Airport had this really big problem. Passengers complained about
the time it took for luggage to arrive at the terminal building after
the airplane had landed. The Airport invested millions to solve this
pain point. They improved the process, hired more people, and introduced
new technology. They eventually succeeded in reducing the wait time to 7
minutes. However, users still complained. The Airport realized that they
had reached a point where optimizing the process/design was no longer
optimal. So they did something different. They reframed the problem. By
reframing the problem, they discovered that it was not the time it took
to get the luggage to the terminal building that was the problem. It was
the time the passengers had to wait for the luggage that was the
problem. The Airport decided to park the airplanes further away from the
terminal building. Consequently, it took some time for passengers to
arrive at the terminal building, thus reducing the wait time for
luggage, and voila! Complaints dropped drastically.

One lesson that could be learned from this story is that speed could
have unintended consequences, especially when granted to the wrong
client or in the wrong context. Therefore, it makes sense to control
which and how much traffic accesses our resources. Whenever such control
is lacking or ineffective, developer productivity suffers, as engineers
spend more time responding to platform incidences (PIs). Existing
controls could benefit from an additional dimension as long as such a
dimension does not introduce unnecessary complexity or increase response
time noticeably. This article will explore rate-limiting as an
additional dimension of controlling access to our resources. 

## What Is Rate Limiting?

[Rate limiting](https://dzone.com/articles/basic-api-rate-limiting) is a
mechanism used to control consumption over time. This consumption over
time is known as the rate. Hence, the term rate limiting. The goal of a
rate-limiting system is to work well when the system is under heavy
load. It needs to be built for the worst 1%, not the good 99%.

### More Than Limiting

Rate limiting is more than limiting. It could also be used to shape
traffic in various ways. For example, smoothing of bursts in traffic. We
increase the resiliency of the system by smoothing bursts in traffic.
See diagram below:

## Why Limit Rates?

It is easy to design a system that is 95% resilient. However, moving the
resiliency dial to 99.99% requires a well-architected system. This is
where rare-limiting, amongst other resiliency mechanisms, comes in.
These mechanisms are gaining traction for the following reasons:

-   Growth often happens during periods of high load.
-   It is increasingly easier to exploit public resources due to the
    advent of AI and related tools.

With rate-limiting, we could achieve the following:

-   Traffic shaping
-   Prevent attacks — e.g., DDoS/brute force attacks.
-   Prevent resource starvation — Some unusual traffic is caused by
    bots, errors in software, or configurations in some other part of
    the system, not malicious attacks.
-   Improve developer productivity
-   Save cost. 

## Common Rate-Limiting Algorithms (Optional Section)

Some common rate-limiting algorithms are:

-   Token bucket
-   Leaky bucket
-   Fixed window counter
-   Sliding window counter
-   Sliding window logs

### **Token Bucket**

A token bucket is a container that has a pre-defined capacity. Tokens
are put in the bucket at preset rates periodically. Once the bucket is
full, no more tokens are added. When a request arrives, we check if
there is at least one token left in the bucket. If there is, we take one
token out of the bucket, and the request goes through. If the bucket is
empty, the request is dropped.

#### Pros

-   Memory efficient.
-   Accommodates burst/spike in traffic. 
-   Easy to implement.

#### Cons

-   Needs to be adapted for the distributed system by achieving some
    atomicity when accessing the shared state of buckets.

### **Leaky Bucket**

A leaky bucket is a container that has a pre-defined capacity. Tokens
are put in the bucket, one for each request from the client. Requests
are taken out of the bucket and processed at a constant rate. If the
rate at which requests arrive is greater than the rate at which requests
are processed, the bucket will fill up, and further requests will be
dropped until there is space in the bucket.

#### Pros

-   Memory efficient.
-   Suitable for use cases where a stable outflow rate is required.

#### Cons

-   Not Accommodating of burst/spike in traffic, as some recent requests
    may be dropped in such cases. 
-   Needs to be adapted for a distributed system by achieving some
                                     atomicity when accessing the shared state of buckets.

<table data-macro-body-type="RICH_TEXT"
data-macro-id="46e78652-23e7-42b8-b11d-1ac78da5e51e"
data-macro-name="expand"
data-macro-parameters="title=Optional section. Click here to expand..."
data-macro-schema-version="1" data-mce-resize="false"
style="max-width: 100%; width: auto; table-layout: fixed; display: table;"
width="auto">
<tbody>
<tr class="header" width="auto"
style="overflow-wrap: break-word; width: auto;">
</tr>
&#10;</tbody>
</table>

## Rate Limiting at Scale

### **Desired**

Here are some requirements for rate limiting at scale. Rate limiting
should:

-   Be very easy to set up.
-   Support dynamic rate limiting on the fly. For example, conditional
    rate limiting based on both server states (e.g., `jvm memory`) and
    request details (e.g `ip address, user agent`).
-   Does not decrease response times.
-   Support distributed systems. 
-   Be easy to maintain and evolve.

### **Needs Rate Limiting**

Public facing pages, for example:

-   Contact us and other such forms.
-   Pages where users provide inputs that may need to be processed.

Background services which may suffer from traffic bursts:

-   Image upload.
-   Catalog upload.

Heavy lifting services:

-   Order archive download.
-   Other file download services.

Other public-facing pages, for example:

-   Home page.
-   Search page.
-   Article details page.

## Rate-Limiting Libraries

The following rate-limiting libraries can do the heavy lifting of
rate-limiting. 

-   [guava
                  ratelimiter](https://github.com/google/guava/blob/master/guava/src/com/google/common/util/concurrent/RateLimiter.java)
-   [bucket4j](https://github.com/bucket4j/bucket4j)
-   [resilience4j-ratelimiter](https://github.com/resilience4j/resilience4j/tree/master/resilience4j-ratelimiter)
-   [Flex rate
    limiter](https://github.com/poshjosh/rate-limiter-web-core)

<table
style="max-width: 100%; width: auto; table-layout: fixed; display: table;"
width="auto">
<colgroup>
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
</colgroup>
<thead>
<tr class="header" style="overflow-wrap: break-word; width: auto;"
width="auto">
<th style="overflow-wrap: break-word; width: auto" width="auto"><br />
</th>
<th style="overflow-wrap: break-word; width: auto"
width="auto">guava</th>
<th style="overflow-wrap: break-word; width: auto"
width="auto">bucket4j</th>
<th style="overflow-wrap: break-word; width: auto"
width="auto">resilience4j</th>
<th style="overflow-wrap: break-word; width: auto"
width="auto">flex</th>
<th style="overflow-wrap: break-word; width: auto"
width="auto">remarks</th>
</tr>
</thead>
<tbody>
<tr class="odd" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Easy to
setup</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
<tr class="even" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Dynamic
rate limiting on the fly</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
<tr class="odd" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Decrease
to response times</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
<tr class="even" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Supports
distributed systems</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
<tr class="odd" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Easy to
maintain and evolve</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
</tbody>
</table>


From the above list of rate limiters, only the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** allows
developers to express various conditions for rate limiting. Fluent
expression of such conditions would look like this:

* *

    IF jvm.memory.available < 5G AND user.role = guest THEN 20 requests / second

    ELSE IF jvm.memory.available < 3G THEN 10 requests / second

    ELSE IF jvm.memory.available < 2G THEN 5 requests / second



Expressive conditions such as those displayed above allow the rate
limiter to change the shape of traffic dynamically.

### Flex Rate Limiter

**[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core) **enables
engineers to fluently express rate conditions. The rate limiter is then
able to dynamically respond to changes in traffic. The flex**[ rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** is based
on google-guava. However, rate limiting is not locked into the in-built
rate limiter. Third-party rate limiters could be used and still enjoy
the power and simplicity provided by the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core). **

### Example Usage of Flex Rate Limiter

The flex**[ rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** allows for
<a href="https://github.com/poshjosh/rate-limiter-spring"
rel="noopener noreferrer" target="_blank">limits</a> to be specified
using annotations. For example, *two permits per second when the user is
not logged in AND
the *[*JVM*](https://dzone.com/articles/jvm-architecture-explained)* available
memory is less than 1.5GB.*

Java

* *

    @Controller
    @RequestMapping("/api")
    class GreetingResource {

        @Rate(permits = 2, condition = "web.request.user.role=GUEST & jvm.memory.available<1.7GB")
        @GetMapping("/smile")
        String smile() {
            return ":)";
        }
    }



### A More Contrived Example of Flex Rate Limiter

Unlike other rate limiters, the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core) **allows
<a href="https://github.com/poshjosh/rate-limiter-spring"
rel="noopener noreferrer" target="_blank">rate limiting</a> based on
complex conditions. For example:

* *

    IF jvm.memory.available < 5G AND user.role = guest THEN 20 requests / second

    ELSE IF jvm.memory.available < 3G THEN 10 requests / second

    ELSE IF jvm.memory.available < 2G THEN 5 requests / second



The above could be expressed as:

<table data-macro-body-type="PLAIN_TEXT"
data-macro-id="2fec7832-988b-4af4-a2af-9cf0f27e580e"
data-macro-name="code" data-macro-parameters="language=py"
data-macro-schema-version="1" data-mce-resize="false"
style="max-width: 100%; width: auto; table-layout: fixed; display: table;"
width="auto">
<tbody>
<tr class="header" style="overflow-wrap: break-word; width: auto;"
width="auto">
</tr>
&#10;</tbody>
</table>

Java

* *

    @Controller
    @RequestMapping("/api")
    class GreetingResource {

        @Rate(permits = 20, condition = "jvm.memory.available < 5G & web.request.user.role = GUEST")
        @Rate(permits = 10, condition = "jvm.memory.available < 3G")
        @Rate(permits = 5,  condition = "jvm.memory.available < 1G")
        @GetMapping("/smile")
        public String smile() {
            return ":)";
        }
    }



## Flex Rate Limiter Is Based on Three Major Pillars

-   **Flexibility:** Use of annotations as well as a
    <a href="https://github.com/poshjosh/rate-limiter-web-core"
    rel="noopener noreferrer" target="_blank">flexible</a> and
    expressive language for rate conditions.
-   **Evolvability: **Modular design and non-exposure of implementation
    details. 
-   **Ease of use: **Minimum setup.

### Flexibility

Multiple rates may be specified per class or method. The rates at the
class level applies to all methods in the class. Using multiple rate
conditions, such as displayed below, allows the rate limiter to
dynamically change the shape of traffic. As a result, rate limiting is
more responsive, easier to maintain, and boosts developer productivity. 

Java

* *

    @Rate(10) // 10 permits per second for all methods in this class
    @Controller
    @RequestMapping("/api/v1")
    public class GreetingResource {

        @Rate(permits=1, condition="web.request.user.role=GUEST")
        @Rate(permits=5, condition="web.request.user.role=USER")
        @GetMapping("/smile")
        public String smile() {
            return ":)";
        }

        @Rate(permits=5, timeUnit=TimeUnit.MINUTES, condition="sys.memory.available<1gb")
        @Rate(permits=2, condition="web.request.parameter={viewOptions$#/profile/}")
        @GetMapping("/greet")
        public String greet(@RequestParam("who") String who) {
            return "Hello " + who;
        }
    }



Composite rates could be built and re-used multiple times. For example,
the conditional limit below (i.e., `LimitIfNotGermany`) may be used
multiple times on different classes/methods. 

Java

* *

    @Rate(condition = "web.request.locale != [de_DE|de]", permits = 5)
    @RateGroup("not-germany")
    @Retention(RetentionPolicy.RUNTIME)
    @Target({ ElementType.TYPE, ElementType.METHOD, ElementType.ANNOTATION_TYPE})
    @interface LimitIfNotGermany{ }

    @Controller
    @RequestMapping("/api")
    class GreetingResource {

        @LimitIfNotGermany
        @GetMapping("/smile")
        String smile() {
            return ":)";
        }
    }



The flexibility offered by the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** is made
possible by its **[Rate Condition Expression
Language](https://github.com/poshjosh/rate-limiter-web-core/blob/master/docs/RATE-CONDITION-EXPRESSION-LANGUAGE.md),**
which supports conditions like **`web.request.cookie=<cookie-name>`** 
using the following tokens and operators:

#### **Tokens**

-   `web.request`: attribute, auth.scheme, cookie, header, locale,
    parameter, remote.address, uri, user.principal, user.role
-   `web.session`: id
-   `jvm.memory`: available, free, max, total, used
-   `jvm.thread.count`: daemon, deadlocked, deadlocked.monitor, peak,
    started
-   `jvm.thread.current`: count.blocked, count.waited, state, suspended,
    time.blocked, time.cpu, time.user, time.waited
-   sys.environment
-   sys.property
-   sys.time - current, elapsed

#### **Operators**

=       EQUALS

&gt;       GREATER

&gt;=     GREATER\_OR\_EQUALS

&lt;       LESS

&lt;=     LESS\_OR\_EQUALS

%      LIKE

^       STARTS\_WITH

$       ENDS\_WITH

!        NOT (Negates other operators e.g != or !%)

### Evolvability

**[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** has a
modular design, which includes the following modules:

-   [rate-limiter](https://github.com/poshjosh/rate-limiter): Core
    module. *Inspired by guava rate-limiter. Adapted for distributed
    systems.*
-   [rate-limiter-annotation](https://github.com/poshjosh/rate-limiter-annotation):
    Annotation module. *Built on the core module to support
    annotations. *
-   [rate-limiter-web-core](https://github.com/poshjosh/rate-limiter-web-core):
    Web module. *Built on the annotation module to support Java
    web-based systems.*
-   [rate-limiter-spring](https://github.com/poshjosh/rate-limiter-spring):
    Spring module. *Built on web module, based on Spring framework. *
-   [rate-limiter-javaee](https://github.com/poshjosh/rate-limiter-javaee):
    Javaee module. *Built on web module, based on javaee specs.*

Rate limiting is not locked into the in-built rate limiter. Third-party
rate limiters could be used and still enjoy the power and simplicity
provided by annotations and **[Rate Condition Expression
Language](https://github.com/poshjosh/rate-limiter-web-core/blob/master/docs/RATE-CONDITION-EXPRESSION-LANGUAGE.md)**.

In addition, to prevent tight coupling. The core modules (i.e.,
rate-limiter, rate-limiter-annotation, and rate-limiter-web-core) do not
expose implementation details.

### Ease of Use

Here is how a spring boot application could easily set up rate limiting
using the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core).**

Java

* *

    @SpringBootApplication
    @EnableConfigurationProperties(MyApp.MyRateLimitProperties.class)
    public class MyApp {

        public static void main(String[] args) {
            SpringApplication.run(MyApp.class, args);
        }

        @ConfigurationProperties(prefix = "rate-limiter", ignoreUnknownFields = false)
        public class MyRateLimitProperties extends RateLimitPropertiesSpring { }

        @Component
        public static class MyAppFilter extends ResourceLimitingFilter {
            public MyAppFilter(RateLimitProperties properties) {
                super(properties);
            }
            @Override
            protected void onLimitExceeded(
                    HttpServletRequest request, HttpServletResponse response, FilterChain chain) {
                response.sendError(429, "Too many requests");
            }
        }
    }



Here are example rate-limit properties:

Java

* *

    rate-limiter:
      resource-packages: com.myapplicatioon.web.rest
      rate-limit-configs:
        task_queue: # Accept only 2 tasks per second
          permits: 2
          duration: PT1S
        video_download: # Cap streaming of video to 5kb per second
          permits: 5000
          duration: PT1S
        com.myapplicatioon.web.rest.MyResource: # Limit requests to this resource to 10 per minute
          permits: 10
          duration: PT1M 



## Putting It All Together

Bot control mechanisms and
[CAPTCHA](https://dzone.com/articles/captcha-implementation) are often
used to protect resources. This section will re-imagine such systems
with rate-limiting introduced. The aim of introducing rate limiting in
general and a dynamic rate limiter, in particular, is to stay ahead of
the curve. Instead of spending valuable man-hours fire fighting,
developers can focus on what they love doing.

## Staying Ahead of the Curve

Today, bots have a variety of tricks up their sleeves, including using
multiple user agents, IP addresses, rate-limiting detection, etc. Rate
limiting detection often involves sending packets as fast as possible
for long enough to trigger rate limiting. Thereafter, requests are sent
just under the limit to evade detection as a bot. To counter these
tricks, we could use dynamic rate limiting provided by the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** as well as
a bot trap.

## **Dynamic Rate Limiting**

Dynamic rate limiting involves triggering rate-limiting conditionally.
Using conditions like the client's IP address is not effective. **[Flex
rate limiter](https://github.com/poshjosh/rate-limiter-web-core)**
allows rate limiting based on conditions which the client is not privy
to, for example, JVM memory state. This prevents the client from
detecting rate limiting because the condition for rate limiting changes
arbitrarily based on factors outside the client's control.  

## **Bot-Trap**

A bot trap is a link with text hidden from human vision that only bots
are able to click/follow. The text could be hidden by giving it the same
color as the web page's background color. Any user who follows the human
invisible link is marked as a bot.

## Custom Solutions per Use Case

### **Public Facing Pages**

A robust solution would involve dynamic rate limiting to evade rate
limiting detection. All requests which exceed the limit (probably bots)
are redirected to a CAPTCHA page. The CAPTCHA page contains the bot trap
at the very top. Bots click the trap without even attempting the CAPTCHA
challenge. This means humans may not need to solve the challenge. Anyone
who does not click the bot trap is probably human and is redirected to
the desired resource. 

-   Home page.
-   Search page.
-   Article details page.

### Background Services May Suffer From Traffic Bursts

Rate limiting with traffic smoothing. In this case, requests are not
dropped but delayed depending on various conditions. This acts like a
queue that is privy to the server memory/responsiveness state.

-   Catalog upload.
-   Order upload.

### Heavy Lifting Services

Plain old vanilla rate limiting. The user gets a limit exceeded when
there are too many requests. This should not be surprising to the user
as the requested resource in such cases is of a large size.

-   Order archive download.
-   Other file download services.

### Architecture

### **Comparison**

<table
style="max-width: 100%; width: auto; table-layout: fixed; display: table;"
width="auto">
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header" style="overflow-wrap: break-word; width: auto;"
width="auto">
<th style="overflow-wrap: break-word; width: auto"
width="auto">Property</th>
<th style="overflow-wrap: break-word; width: auto" width="auto">Central
control</th>
<th style="overflow-wrap: break-word; width: auto" width="auto">Side
car</th>
<th style="overflow-wrap: break-word; width: auto"
width="auto">Remarks</th>
</tr>
</thead>
<tbody>
<tr class="odd" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Can
access state of target server (e.g jvm memory)</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto"
width="auto">Accessing state of target server allows for conditional
rate limiting based on important metrics like jvm memory</td>
</tr>
<tr class="even" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Rate
limiter may serve applications written in other languages</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
<tr class="odd" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Rate
limiter may be scaled independent of application</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
<tr class="even" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Ease of
implementation and maintenance</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto">Once a
filter is setup any application that imports that filter, inherits
automatic rate limiting. All that is need is to add annotations and/or
properties specifying rates and conditions for limiting resources.</td>
</tr>
<tr class="odd" style="overflow-wrap: break-word; width: auto;"
width="auto">
<td style="overflow-wrap: break-word; width: auto" width="auto">Low
latency</td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"></td>
<td style="overflow-wrap: break-word; width: auto" width="auto"><br />
</td>
</tr>
</tbody>
</table>



Whereas central control is the more advantageous of the two patterns
compared above, its implementation requires the setup of a control
plane. A control plane is not trivial to set up. On the other hand, the
possible latency issue of the "quasi" sidecar pattern (due to the shared
cache) could be mitigated by asynchronous-eventual-rate-limiting.

### Improving Latency

Asynchronous-eventual-rate-limiting means the following:

-   The call to the shared rate limit cache is made asynchronously. This
    way, requests are not blocked by the same process (rate-limiting)
    that was intended to increase latency.
-   A major implication of the asynchronous call is that rate-of-use
    data will not be strongly consistent but rather eventually
    consistent. 

## Conclusion

It is easy to design a system that is 95% resilient. However, moving the
resiliency dial to 99.99% requires a well-architected system. There are
various resiliency mechanisms that control and shape traffic. Whenever
such control is lacking or ineffective, developer productivity suffers,
as engineers spend more time responding to platform incidences. Existing
controls could benefit from rate limiting, as long as rate limiting does
not introduce unnecessary complexity or increase response time
noticeably. Accordingly, the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** was
presented as a suitable option for improving the resilience of
distributed systems. Using the **[Flex rate
limiter](https://github.com/poshjosh/rate-limiter-web-core)** and the
"quasi" sidecar pattern, rate-limiting could be easily set up to protect
vulnerable resources. In addition, asynchronous-eventual-rare-limiting
could be used to ensure low latency when rate-limiting distributed
systems with a shared cache.

> Let us drink to the day when this kind of response will be no more,
> knowing that day may never come, and we may forever be hungover.

### References

-   **[Flex rate
    limiter](https://github.com/poshjosh/rate-limiter-web-core)**
-   Rate condition expression language: [web
    specification](https://github.com/poshjosh/rate-limiter-web-core/blob/master/docs/RATE-CONDITION-EXPRESSION-LANGUAGE.md)
    and [core
    specification](https://github.com/poshjosh/rate-limiter-annotation/blob/main/docs/RATE-CONDITION-EXPRESSION-LANGUAGE.md)
-   [Systems
    Design](https://systemsdesign.cloud/SystemDesign/RateLimiter)
