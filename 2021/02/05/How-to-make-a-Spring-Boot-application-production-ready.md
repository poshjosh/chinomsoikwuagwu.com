---
path: "./2021/02/05/SQL-JOINS-A-refresher.md"
date: "2021-02-05T08:41:18"
title: "How to make a Spring Boot application production ready"
description: "Steps to making your Spring Boot application production ready."
tags: ["Production ready", "Web Application", "Spring Boot"]
lang: "en-us"
---

### REQUIREMENTS TO MAKE A SPRING BOOT APPLICATION PRODUCTION READY

It is important to ensure that an application is usable, secure, scalable, and resilient to failure before sending it to production. This part provides an overview of steps required to make your Spring Boot application production ready.

- __Use Spring Boot Starter Actuator’s production ready features__ The spring-boot-actuator module provides all of Spring Boot’s production-ready features. The recommended way to enable these features is to add a dependency on the spring-boot-starter-actuator ‘Starter’. With Spring Boot’s production-ready features you could:

  * Access application health or other information via JMX or HTTP.
  * Configure log levels at runtime.
  * Monitor JVM, CPU, File descriptor, Kafka, Log4j, Logback, Uptime, Tomcat and Sprint integration, amongst other metrics, using various systems monitoring systems, including: JMX, Elastic and Prometheus.
  * Publish audit events to database, in-memory or custom repositories.
  * Store traces of request/response exchanges to database, in-memory or custom repositories.
  * Monitor the application process or running web servers.

- __Write more tests and use code quality tools__ Write more tests and use static code analysis as well as code coverage tools to check code quality.

- __Force the use of HTTPS__ HTTPS is a secure version of HTTP designed to provide Transport Layer Security (TLS) that establishes an encrypted connection between a web server and a browser. This way, every data packet is encrypted before transmission, for greater security. HTTPS could be implemented by installing an SSL certificate on your web application. You could use either a certificate issued by a trusted Certificate Authority (CA), or a self-signed certificate. To force the use of HTTPS, you should:

  * Install a certificate issued by a trusted CA on your web application.
  * Configure the Spring Boot application to only allow HTTPS.
  * Redirect all HTTP links to the HTTPS variant.

- __Remove secrets from the source code__ The source code contains a reference to the password in the application properties file located in the resources folder. Secrets should not be located outside the source code that is checked into version control. One way to achieve this is to use externalized configuration. This means maintaining a separate server for application config. It is best practice, and Spring Cloud Config is the Spring module designed for that purpose.

- __Configure Jackson__ Jackson should be configured to speed up serialization and deserialization using the afterburner module. Depending on your use case, Jackson should also be configured to for proper serialization/deserialization of Java date and time API types, Hibernate5 types and JDK8 types.

- __Configure time zone__ Ensure database and application server time zones are the same and preferably UTC.

- __Add data validation__  Add data-validation to protect the application from faulty data. Without proper validation, incorrect or faulty data could make its way into your application and create unexpected issues. For example, the length of passwords and usernames should be specified, and corresponding data should be validated to meet the specifications. Also, an alphabet should not be accepted where a number is required (e.g a product ID).

- __Improve Exception Handling__ The application correctly makes use of exceptions to fail gracefully. After each such failure, the application should send an error response that clearly communicates its current state and makes the user take appropriate action. To improve exception handling, error messages should be clear and customized for each use case. Such improvement to exception handling will ensure the user experience is not compromized. Spring Framework provides various exception handing mechanizms. Improving exception handling will include the following:

  *	Extend PizzeriaException to create Exception sub classes customized for particular use cases.
  *	Add exception messages customized for specific failures.
  *	Make use of Spring exception handling mechanisms.

- __Rate-limit API calls__ Rate limiting is the process of restricting traffic to a server based on IP addresses, geolocation, and other factors. For example, you could limit an individual user to a maximum of 100 requests within a 60 second period. Therefore consider using a rate-limiting library like Bucket4j.

- __Configure alerting__ The application is already configured to send emails. Whenever it experiences specific problems, it should alert a human. At a minimum, it should alert a human if: it is down or if latency/error rates rise above a specified threshold.

- __Manage database schema changes__ Since the application makes use of a database, it is important to use tools to document (track, version and deploy) database schema changes over time. This allows the database designer to specify changes in schema & enables programmatic upgrade or downgrade of the schema on demand.

- __Document the API__ The API has been well designed and implemented. It should therefore be well documented. Without proper documentation, consumers may not be willing to use your APIs. It is also important to maintain documentation across changes in the interface. Tools like Swagger could be used to document APIs. Swagger integrates seamlessly with Spring Boot. Moreover, as you update your API, the Swagger documentation is automatically updated.

- __Use Spring template engines for text content__ Use Spring templates to define text with dynamic content. `com.graphaware.pizzeria.service.EmailService` contains hardcoded text content. Rather than have string literals in various parts of the application, it is beneficial to define them in separate and well-structured files, often as text with dynamic content. This will make such content easy to maintain and scale to support other languages.

- __Maintain an audit log__ In a typical production ready application, we often need to maintain an audit log of our tables. Information such as last-updated-timestamp or the last-updated-user-id could be quite important in certain situations. With the AuditorAware interface that comes along with Java Persistence API, it is quite easy to build such a setup in a Spring Boot application.

- __Maintain a history table__ In addition to an audit log, we often need to maintain a history table. This could be important for compliance, audit, or analytics as well as the ability to trace issues by looking into the history of records.

### FRAMEWORKS, LIBRARIES, TOOLS THAT COULD BENEFIT SPRING BOOT APPLICATIONS

- EhCache/Redis
- Spring boot starter thymeleaf as template engine.
- Sonarqube for static code analysis.
- JaCoCo for code coverage.
- Spring Cloud Config for externalized configuration.
- Liquibase or Flyway for managing database schema changes.
- Swagger for documenting API
- Bucket4j for rate-limiting API calls.
- Hibernate Envers for maintaining a history table.
- JIB could be used via the jib-maven-plugin to simplify building of docker image.
- Spring Session module for Redis or Redission.
- Elastic / Prometheus for monitoring.
- SLF4J and logback libraries are already included with the application.
- Jackson module after burner
- Jenkins for CI/CD
- Terraform and Packer for IaC
- Zalando Problem for RFC7807 Problem support if required.
- Mapstruct, if using DTOs, to convert between DTOs and Entities.
