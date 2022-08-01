---
path: "./2019/08/05/Versioning-REST-Resources-with-Spring-Data-REST.md"
date: "2019-08-05T23:46:08"
title: "Versioning REST Resources with Spring Data REST"
description: "Versioning REST Resources with Spring Data REST"
tags: ["Spring", "REST", "Spring Boot", "Spring Data REST", "Versioning", "Versioning REST Resources"]
lang: "en-us"
---

### What is REST ###

`REST`: Representational State Transfer. REST is an architectural style, or
design pattern.

The aim of REST is stateless interaction between the service provider and consumer.

In practice, given the URL of a RESTful service, you would be able to interact
with that service to create, read, update or delete resources based on
REST standards. You would not need to know any other information apart from
those provided by the RESTful API.

For example, A RESTful web application exposes information about its resources and
also enables the client to take actions on those resources, such as create new
resources or change existing resources.

If well implemented. REST is intended to provide interoperability between
computer systems on the internet.

>Representational state transfer (REST) is a software architectural style that
defines a set of constraints to be used for creating Web services. Web services
that conform to the REST architectural style, called RESTful Web services, provide
interoperability between computer systems on the Internet. RESTful Web services
allow the requesting systems to access and manipulate textual representations
of Web resources by using a uniform and predefined set of stateless operations.
Other kinds of Web services, such as SOAP Web services, expose their own
arbitrary sets of operations.

### What is Spring Data REST ###

>Spring Data REST is part of the umbrella Spring Data project and makes it easy
to build hypermedia-driven REST web services on top of Spring Data repositories.

>Spring Data REST builds on top of Spring Data repositories, analyzes your
application’s domain model and exposes hypermedia-driven HTTP resources for
aggregates contained in the model.

__Features__

- Exposes a discoverable REST API for your domain model using HAL as media type.
- Exposes collection, item and association resources representing your model.
- Supports pagination via navigational links.
- Allows to dynamically filter collection resources.
- Exposes dedicated search resources for query methods defined in your repositories.
- Allows to hook into the handling of REST requests by handling Spring ApplicationEvents.
- Exposes metadata about the model discovered as ALPS and JSON Schema.
- Allows to define client specific representations through projections.
- Ships a customized variant of the HAL Browser to leverage the exposed metadata.
- Currently supports JPA, MongoDB, Neo4j, Solr, Cassandra, Gemfire.
- Allows advanced customizations of the default resources exposed.

### Versioning REST Resources with Spring Data REST ###

To support versioning of resources, define a `version` attribute for your domain
objects that need this type of protection. For example:

```java
@Entity
public class BlogPost {

	private @Id @GeneratedValue Long id;
	private String title;
	private String content;
	private Date dateCreated;

	private @Version @JsonIgnore Long version;

	private BlogPost() {}

	public BlogPost(id) {
		this.id = id;
	}
}  
```

- The version field is annotated with `javax.persistence.Version`. It causes a
value to be automatically stored and updated every time a row is inserted and
updated.

- When fetching an individual resource (not a collection resource), Spring Data
REST automatically adds an [ETag response header](https://tools.ietf.org/html/rfc7232#section-2.3)
with the value of this field.

- A `PUT` with an `If-Match` request header causes Spring Data REST to check the
value against the current version. If the incoming `If-Match` value does not match
the data store’s version value, Spring Data REST will fail with an `HTTP 412
Precondition Failed`.

- When someone else updates the data after you have loaded it. The update will
lead to a new `version`, causing the version to be different from that you
loaded. When you try to update the same data, the `If-Match` condition will fail.

### References ###

- [Web Services Architecture](https://www.w3.org/TR/2004/NOTE-ws-arch-20040211/#relwwwrest).
World Wide Web Consortium. 11 February 2004. 3.1.3 Relationship to the World
Wide Web and REST Architectures. Retrieved 29 September 2016.

- [Spring.io - Spring Data Rest](https://spring.io/projects/spring-data-rest)
