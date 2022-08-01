---
path: "./2021/02/05/SQL-JOINS-A-refresher.md"
date: "2021-02-05T19:22:37"
title: "Some common mistakes when developing java web applications"
description: "Quick guide to mitigating common mistakes when developing java web applications"
tags: ["Java application", "Common mistakes"]
lang: "en-us"
---

- __Fix probable synchronization issues with shared resource.__ Objects which may be accessed by multiple thread, need to be properly synchronized. Servlets, Spring Controllers/Services are examples of such objects.

- __Add support for multiple environments.__ Add support for development, staging and production environments. This will help improve security and productivity (flexibility in development and staging). Spring Profiles provide a way to segregate parts of your application configuration and make it only available in certain environments.

- __Add constraints to models.__ In the Java Persistence API (JPA), constraints are a way to enforce and document database rules. For example, if you want Pizza names to be unique to each record, then unique constraints should be added to the corresponding model object field. For example:

```java
@Entity
public class Employee{
  @Column(unique = true)
  private String username;
}
```

- __Use BigDecimal for money related variables.__ If the intention is to store the exact value of  money related variables, then use `java.math.BigDecimal` and not floating point numbers to represent such variables. This is because, under certain conditions floating point numbers suffer loss of significance leading to inaccurate scale (scale refers to digits after the decimal point). `java.math.BigDecimal`  should thus be used for money related fields.

- __Use Spring Boot derived query methods.__ Prefer derived query methods to hardcoded SQL queries. Whereas hardcoded SQL queries may be faster, derived query methods are standard, easier to maintain and implicitly documented. To use derived query methods in Spring Data JPA you simply follow the method naming convention and the query is derived for you.

- __Add support for pagination and sorting.__ Support should be added for paging and sorting to ensure results are returned in pages. This way results containing many records will be returned incrementally. Spring Data JPA supports pagination and sorting out of the box and it is quite easy to set up.

- __Standardize the API.__

  * __Version the API.__ Versioning the API enables us have different versions of our API if we’re making any changes to them that may break clients. This way, we can gradually phase out old endpoints instead of forcing everyone to move to the new API at the same time. To version the API, add a version number to its links for example use `/v1/books/1` rather than `/books/1`.

  * __Standardize API links.__ No need to use verbs (e.g `/createBook`) in endpoint paths. Rather, make use of the existing REST verbs. For example to:

    - Create a new pizza 			- POST /v1/pizzas
    - Edit an existing pizza (having id = 1) 	- PUT  /v1/pizzas/1
    - Delete an existing pizza (having id = 1)  - DELETE /v1/pizzas/1
    - Get an existing pizza (having id = 1) 	- GET /v1/pizzas/1
    - Get all pizzas having topping		- GET /v1/pizzas?topping=???

- __Use a data transfer layer between models and client.__ Use Data Transfer Objects (DTO) to define the data you want transferred. This is especially necessary when some domain objects load associated objects eagerly (as indicated by `FetchType.EAGER`). Using DTOs will prevent unnecessary data being transferred from the business layer to the client.

- __Use properties where necessary.__  Prefer properties to literal values. This makes code configurable and maintainable.

- __Use boxed types for Entity Ids.__ Prefer boxed types to primitives. Primitives have a default value of zero. This zero - value may lead to conflicts. For example, an entity with id of zero may be seen, as already existing.

- __Use proper generation type for auto generated values.__ Using `GenerationType.AUTO` leaves it to the JPA implementation to decide which generation strategy to use. Consider explicitly specifying a generation strategy.

- __Persist detached entities before using in relationships.__ When saving an entity to the database, make sure any of its detached relations are first persisted. If not `org.hibernate.PersistentObjectException` will be thrown. For example, an entity created with data passed from the client will be detached from the database. To ensure such entity is not detached:

  * If the pizza has an id which refers to an existing entity, then load that entity from the database.

  * If the pizza does not have an id, then save the pizza to the database and use the return value from the save method.

- __Use Optional when null may be returned from a method.__ Consider wrapping the return value in an Optional for methods whose return value may be null.

- __Use development database.__ Consider using a development database. For example, H2 is convenient to use during development and even has in-memory database mode.
