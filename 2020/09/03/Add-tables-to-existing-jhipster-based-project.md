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

- Run command `jhipster import-jdl <YOUR_JDL_FILE>.jdl`

- Respond to the prompt(s)

- Run command `mvnw`

- You may get the following error

```
Application run failed
org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'liquibase' defined in class path resource [com/myapplication/config/LiquibaseConfiguration.class]: Invocation of init method failed; nested exception is liquibase.exception.ValidationFailedException: Validation Failed:
     1 change sets check sum
          config/liquibase/changelog/20200808122400_added_entity_Tag.xml::20200808122400-1::jhipster was: 8:a970f5129cedf190a460aca4917f56c5 but is now: 8:13347cabb349df27960176ab29f30179
```

__Before we resolve the error, a few notes.__

- Note: Use `mvnw` for windows machines, and `./mvnw` for linux

- Jhipster uses [liquibase](https://www.liquibase.org/) to carryout and track
changes to the domain.

- Do not edit the entity files directly as the changes will confuse liquibase.

### Resolve errors which occured while modifying existing entities

__Problem__

When we use liquibase all entity changes that happen later should be captured
as separate changelogs. However, Jhipster overwrites the changelog files.
Therefore the entities liquibase file's checksum changes as it has new content
now. And in your database, there is a table called `DATABASECHANGELOG` which
stores which all changeLogs were applied and this has checksum data.

As a result of the foregoing, when you start your application you get a
`liquibase.exception.ValidationFailedException` because your latest liquibase
changeLog of modified entity's checksum is different from the last time
(database will have a checksum for this liquibase file for previous verison)
you ran.

Running command: `mvn liquibase:clearCheckSums` is not the right approach most
of the time. This actually clears all checksums in the database so that you
lose track of the changes that had happened which is usually not intended. This
feature of liquibase makes sense when for example you want to rollback the new
changes you applied. If you clear checksums and run the application it will
compute new checksums; you lose the track and can lead to problems, if care is
not taken.

__Solutions__

- Check the changelog file for the entity. In this case the entity we edited
was `Tag` and the liquibase file is located at:
`src/main/resources/config/liquibase/changelog/20200808122400_added_entity_Tag.xml`

- Revert the file back to before the changes were made. Git is helpful for
achieving this.

- Run `mvn compile liquibase:diff` to capture the change you made to the entity
in liquibase. Or you could add the changes manually.

- The command your ran i.e `liquibase:diff` generates a changelog file in folder
`src/main/resources/config/liquibase/changelog/`. Check that the changelog file
contains the change as is. You could also edit, this file manually.

- Add the changelog file to the master file located at `src/main/resources/config/liquibase/master.xml`

- Run your application
