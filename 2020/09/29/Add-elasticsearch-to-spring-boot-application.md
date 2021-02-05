---
path: "./2020/09/29/Add-elasticsearch-to-spring-boot-application.md"
date: "2020-09-29T22:07:24"
title: "Add Elasticsearch to Spring Boot Application"
description: "Guide to quickly adding Elasticsearch to as Spring Boot application"
tags: ["elasticsearch", "spring boot", "spring-boot-starter-data-elasticsearch"]
lang: "en-us"
---

### Quick Intro

Spring Boot is an open source java based framework which makes it easy to
create stand-alone, production-grade java based applications that you can
"just run". Elasticsearch, on the other hand, is a distributed, RESTful search
and analytics engine capable of addressing a growing number of use cases
amongst which is providing full text search for a spring base web application.

### Add dependencies

Add to the following into the `<dependencies>` tag of your application's `pom.xml`

```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-elasticsearch</artifactId>
        </dependency>
        <!-- Spring Data Jest dependencies for Elasticsearch -->
        <dependency>
            <groupId>com.github.vanroy</groupId>
            <artifactId>spring-boot-starter-data-jest</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>commons-logging</groupId>
                    <artifactId>commons-logging</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <!-- log4j2-mock needed to create embedded elasticsearch instance with SLF4J -->
        <dependency>
            <groupId>de.dentrassi.elasticsearch</groupId>
            <artifactId>log4j2-mock</artifactId>
            <version>0.0.2</version>
            <scope>runtime</scope>
        </dependency>
```

### Add Elasticsearch configuration

Suppose your project root package is `com.springbootelasticsearchdemo.repository.search`,
add the following configuration class.

```java
@Configuration
@EnableConfigurationProperties(ElasticsearchProperties.class)
@EnableElasticsearchRepositories("com.springbootelasticsearchdemo.repository.search")
public class ElasticsearchConfiguration {

    private ObjectMapper mapper;

    public ElasticsearchConfiguration(ObjectMapper mapper) {
        this.mapper = mapper;
    }

    @Bean
    public EntityMapper getEntityMapper() {
        return new CustomEntityMapper(mapper);
    }

    @Bean
    @Primary
    public ElasticsearchOperations elasticsearchTemplate(final JestClient jestClient,
                                                         final ElasticsearchConverter elasticsearchConverter,
                                                         final SimpleElasticsearchMappingContext simpleElasticsearchMappingContext,
                                                         EntityMapper mapper) {
        return new JestElasticsearchTemplate(
            jestClient,
            elasticsearchConverter,
            new DefaultJestResultsMapper(simpleElasticsearchMappingContext, mapper));
    }

    public class CustomEntityMapper implements EntityMapper {

        private ObjectMapper objectMapper;

        public CustomEntityMapper(ObjectMapper objectMapper) {
            this.objectMapper = objectMapper;
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            objectMapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
            objectMapper.configure(SerializationFeature.WRITE_DATE_TIMESTAMPS_AS_NANOSECONDS, true);
            objectMapper.configure(SerializationFeature.INDENT_OUTPUT, false);
            objectMapper.configure(DeserializationFeature.READ_DATE_TIMESTAMPS_AS_NANOSECONDS, true);
        }

        @Override
        public String mapToString(Object object) throws IOException {
            return objectMapper.writeValueAsString(object);
        }

        @Override
        public <T> T mapToObject(String source, Class<T> clazz) throws IOException {
            return objectMapper.readValue(source, clazz);
        }

        @Override
        public Map<String, Object> mapObject(Object source) {
            try {
                return objectMapper.readValue(mapToString(source), HashMap.class);
            } catch (IOException e) {
                throw new MappingException(e.getMessage(), e);
            }
        }

        @Override
        public <T> T readObject (Map<String, Object> source, Class<T> targetType) {
            try {
                return mapToObject(mapToString(source), targetType);
            } catch (IOException e) {
                throw new MappingException(e.getMessage(), e);
            }
        }
    }
}
```

### Specify which entities to index

Add this annotation to the top of each Entity which you want to be index.

```java
@org.springframework.data.elasticsearch.annotations.Document(indexName = "blog")
```

What about Entity fields and Enums? __Taken care of__.

### Add repositories for accessing search indices

Add an `ElasticsearchRepository` for each entity which you want to be searchable

```java
public interface BlogSearchRepository extends ElasticsearchRepository<Blog, Long> {

}
```

Use the `ElasticsearchRepository` in your `Service` class

```java

import com.springbootelasticsearchdemo.repository.search.BlogSearchRepository;
import static org.elasticsearch.index.query.QueryBuilders.queryStringQuery;

public class BlogService{

    private final BlogSearchRepository blogSearchRepository;

    public BlogService(BlogSearchRepository blogSearchRepository) {
        this.blogSearchRepository = blogSearchRepository;
    }

    public Page<Blog> search(String query, Pageable pageable) {
        return this.blogSearchRepository.search(queryStringQuery(query), pageable);
    }
}
```

### Notes

Before you run your application in `dev` you should stand up an elasticsearch
server via the following command:

```sh
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.8.6
```

Make sure the elasticsearch version `(in this case 6.8.6)` is compatible with
that which comes with `spring-boot-starter-data-elasticsearch`

### References

- [Spring data elasticsearch reference document](https://docs.spring.io/spring-data/elasticsearch/docs/current/reference/html/#reference)

- [Elastic stack - get started](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-docker.html)

- [Elastic search - reference document](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)

- [Spinscale - introduction to elasticsearch](https://spinscale.de/posts/2020-08-06-introduction-into-spring-data-elasticsearch.html)
