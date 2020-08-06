---
path: "./2020/08/06/maven-dependency-convergence-quick-reference.md"
date: "2020-08-06T18:41:00"
title: "Maven Dependency Conversion - quick reference"
description: "Quick Reference - Maven dependency convergene, Cheat sheet"
tags: ["Maven", "depencency convergence", "nested dependencies"]
lang: "en-us"
---

### What exactly? ###

__is Dependency convergence__. Ha what a way to put it. Yes we know applications
have dependencies, but what about their convergence? Also why am I getting
a dependency convergence error? Well grope no further... light is here, I mean
in the following paragraphs, we explain enough to extinguish any doubts about
Maven Dependency Convergence.

Consider the following dependency:

`Board Game v 1.0` -depends-on-> `Fast Graphics v 1.0` -depends-on-> `Open-utility v 1.2.0`

But what if the following dependency also exists for `Board Game v 1.0`

`Board Game v 1.0` -depends-on-> `Laws of Physics v 1.0` -depends-on-> `Open-utility v 1.2.1`

Then we would have 2 versions of `Open-utility` in the dependency tree.
There is a conflict.

`Board Game v 1.0` should use just one version of the `Open-utility` library at
runtime. If an incompatible version of a library is used with another library,
the application could end up producing errors and crashing.

__Maven has a dependency convergence rule__

Maven has a rule to flag this conflict. The rule is
termed `dependency convergence` and to enforce this rule you add the following
to your `pom.xml` file:

```xml
<project>
  ...
  <build>
    <plugins>
      ...
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-enforcer-plugin</artifactId>
        <version>3.0.0-M3</version>
        <executions>
          <execution>
            <id>enforce</id>
            <configuration>
              <rules>
                <dependencyConvergence/>
              </rules>
            </configuration>
            <goals>
              <goal>enforce</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
      ...
    </plugins>
  </build>
  ...
</project>
```

### Problem Solving ###

With the dependency convergence rule emplaced, the following dependencies:

```xml
<dependencies>
  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-jdk14</artifactId>
    <version>1.6.1</version>
  </dependency>
  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-nop</artifactId>
    <version>1.6.0</version>
  </dependency>
</dependencies>  
```

will lead to this error:

```
Dependency convergence error for org.slf4j:slf4j-api1.6.1 paths to dependency are:

[ERROR]
Dependency convergence error for org.slf4j:slf4j-api:1.6.1 paths to dependency are:
+-org.myorg:my-project:1.0.0-SNAPSHOT
  +-org.slf4j:slf4j-jdk14:1.6.1
    +-org.slf4j:slf4j-api:1.6.1
and
+-org.myorg:my-project:1.0.0-SNAPSHOT
  +-org.slf4j:slf4j-nop:1.6.0
    +-org.slf4j:slf4j-api:1.6.0
```    

One dependency branch leads to `org.slf4j:slf4j-api:1.6.1`, whereas another
branch leads to `org.slf4j:slf4j-api:1.6.0`.

We solve this by excluding one of the conflicting dependencies as follows:

```xml
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-jdk14</artifactId>
  <version>1.6.1</version>
</dependency>
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-nop</artifactId>
  <version>1.6.0</version>
  <exclusions>
    <exclusion>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-api</artifactId>
    </exclusion>
  </exclusions>
</dependency>
```

### A more complex problem ###

Here we solve a dependency convergence error with nested dependencies. First,
the error stack trace:

```
[WARNING]
Dependency convergence error for org.apiguardian:apiguardian-api:1.1.0 paths to dependency are:
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.springframework.boot:spring-boot-starter-test:2.2.5.RELEASE
    +-org.junit.jupiter:junit-jupiter:5.5.2
      +-org.junit.jupiter:junit-jupiter-api:5.5.2
        +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.springframework.boot:spring-boot-starter-test:2.2.5.RELEASE
    +-org.junit.jupiter:junit-jupiter:5.5.2
      +-org.junit.jupiter:junit-jupiter-api:5.5.2
        +-org.junit.platform:junit-platform-commons:1.5.2
          +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.springframework.boot:spring-boot-starter-test:2.2.5.RELEASE
    +-org.junit.jupiter:junit-jupiter:5.5.2
      +-org.junit.jupiter:junit-jupiter-params:5.5.2
        +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.springframework.boot:spring-boot-starter-test:2.2.5.RELEASE
    +-org.junit.jupiter:junit-jupiter:5.5.2
      +-org.junit.jupiter:junit-jupiter-engine:5.5.2
        +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.springframework.boot:spring-boot-starter-test:2.2.5.RELEASE
    +-org.junit.vintage:junit-vintage-engine:5.5.2
      +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.springframework.boot:spring-boot-starter-test:2.2.5.RELEASE
    +-org.junit.vintage:junit-vintage-engine:5.5.2
      +-org.junit.platform:junit-platform-engine:1.5.2
        +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.zalando:problem-spring-web:0.25.2
    +-org.zalando:problem-violations:0.25.2
      +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.zalando:problem-spring-web:0.25.2
    +-org.zalando:problem-spring-common:0.25.2
      +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.zalando:problem-spring-web:0.25.2
    +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.zalando:problem-spring-web:0.25.2
    +-org.zalando:problem:0.23.0
      +-org.apiguardian:apiguardian-api:1.0.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.zalando:problem-spring-web:0.25.2
    +-org.zalando:jackson-datatype-problem:0.23.0
      +-org.apiguardian:apiguardian-api:1.0.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-org.zalando:problem-spring-web:0.25.2
    +-org.zalando:faux-pas:0.8.0
      +-org.apiguardian:apiguardian-api:1.0.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-io.cucumber:cucumber-junit:4.8.1
    +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-io.cucumber:cucumber-junit:4.8.1
    +-io.cucumber:cucumber-core:4.8.1
      +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-io.cucumber:cucumber-spring:4.8.1
    +-io.cucumber:cucumber-java:4.8.1
      +-org.apiguardian:apiguardian-api:1.1.0
and
+-com.looseboxes:webstore:0.0.1-SNAPSHOT
  +-io.cucumber:cucumber-spring:4.8.1
    +-org.apiguardian:apiguardian-api:1.1.0
```    

That's quite some eye full. At the bottom of each section we see
the conflicting dependency, in this case `org.apiguardian:apiguardian-api`
with version `1.1.0` appearing in some branches and version `1.0.0` in others.

__So how do we resolve this?__

Let's use with the latest version of `org.apiguardian:apiguardian-api` i.e `1.1.0`

Observe that all the branches with version `1.0.0` stem from the library
`org.zalando:problem-spring-web:0.25.2`

Here is `org.zalando:problem-spring-web:0.25.2` in the `pom.xml` file:

```xml
<dependency>
    <groupId>org.zalando</groupId>
    <artifactId>problem-spring-web</artifactId>
    <version>0.25.2</version>
</dependency>
```

Now we see that we cannot exclude `apiguardian-api` directly from `problem-spring-web`
because it is nested i.e `problem-spring-web` does not depend directly on it.

__Here is what we do to resolve this__

Here is the problem tree:

`webstore` -> `problem-sring-web` -> `problem` -> `apiguardian`

- We exclude `problem` from `problem-spring-web`

- We then declare `problem` as a separate dependency since we have excluded it.

- In the declaration of the `problem` dependency we exclude `apiguardian`

...Oh don't bother, here is the complete solutions:

```xml
<dependency>
    <groupId>org.zalando</groupId>
    <artifactId>problem-spring-web</artifactId>
    <exclusions>
        <exclusion>
            <groupId>org.zalando</groupId>
            <artifactId>problem</artifactId>
        </exclusion>
        <exclusion>
            <groupId>org.zalando</groupId>
            <artifactId>jackson-datatype-problem</artifactId>
        </exclusion>
        <exclusion>
            <groupId>org.zalando</groupId>
            <artifactId>faux-pas</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>org.zalando</groupId>
    <artifactId>problem</artifactId>
    <version>0.23.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.apiguardian</groupId>
            <artifactId>apiguardian-api</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>org.zalando</groupId>
    <artifactId>jackson-datatype-problem</artifactId>
    <version>0.23.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.apiguardian</groupId>
            <artifactId>apiguardian-api</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>org.zalando</groupId>
    <artifactId>faux-pas</artifactId>
    <version>0.8.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.apiguardian</groupId>
            <artifactId>apiguardian-api</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

I know what you are thinking... ok I don't. Just, ...just take it and if not
...just

### Reference ###

- [Maven - dependency convergence](https://maven.apache.org/enforcer/enforcer-rules/dependencyConvergence.html)
