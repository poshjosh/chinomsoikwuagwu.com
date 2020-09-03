---
path: "./2020/09/03/Add-tables-to-existing-jhipster-based-project.md"
date: "2020-09-03T15:36:00"
title: "Add entities/tables to an existing Jhipster based project"
description: "Guide to quickly adding entities/tables to an existing Jhipster based project"
tags: ["jhipster", "jdl", "jh", "liquibase"]
lang: "en-us"
---

### What is Jhipster

Jhipster is a full stack application code generator. Simply put, use Jhipster
to generate application code for a Spring Boot (with Java or Kotlin), Micronaut,
Quarkus, Node.js, or .NET backend, as well as Angular, React or Vue front-end.

Part of the process of generating application code involves generating domain
logic including entity classes. The recommended way is to use a `.jdl` file.
JDL stands for JHipster Domain Language. It is a JHipster-specific domain
language where you can describe all your applications, deployments, entities
and their relationships in a single file (or more than one) with a user-friendly
syntax.

Here is an example of a jdl for a blog.

```
application {
  config {
    baseName blog,
    applicationType monolith,
    packageName com.jhipster.demo.blog,
    prodDatabaseType mysql,
    cacheProvider hazelcast,
    buildTool maven,
    clientFramework react,
    useSass true,
    testFrameworks [protractor]
  }
  entities *
}

entity Blog {
  name String required minlength(3)
  handle String required minlength(2)
}

entity Post {
  title String required
  content TextBlob required
  date Instant required
}

entity Tag {
  name String required minlength(2)
}

relationship ManyToOne {
  Blog{user(login)} to User
  Post{blog(name)} to Blog
}

relationship ManyToMany {
  Post{tag(name)} to Tag{entry}
}

paginate Post, Tag with infinite-scroll
```

[You can find samples of JDL here](https://github.com/jhipster/jdl-samples)

### Quickly get started with Jhipster

Although this post is not a get started guide, you can quickly get started
with Jhipster thus:

- Install Java, Git and Node.js, if not installed on you machine.

- Install JHipster by running the command: `npm install -g generator-jhipster`

- Create a new directory and go into it: `mkdir myApp && cd myApp`

- Run JHipster and follow instructions on screen: `jhipster`

- Model your entities with JDL Studio and download the resulting jhipster-jdl.jh file

- Generate your entities with jhipster import-jdl jhipster-jdl.jh

Yes we earlier said `.jdl` and now `.jh`. Well both are supported.

### Modify existing entities

Now suppose you want to modify

```
entity Tag {
  name String required minlength(2)
}
```

to

```
entity Tag {
  name String required minlength(3)
}
```

- Modify the `.jdl` file

- Run command `mvnw clean`

- Run command `jhipster import-jdl you-jdl-file.jdl`

- Run command `mvnw` to re-build your application.

__Notes:__

- Note: Use `mvnw` for windows machines, and `./mvnw` for linux

- Jhipster uses [liquibase](https://www.liquibase.org/) to carryout and track
changes to the domain.

- Do not edit the entity files directly as the changes will confuse liquibase.
