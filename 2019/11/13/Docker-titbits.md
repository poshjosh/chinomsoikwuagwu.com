---
path: "./2019/11/13/Docker-titbits.md"
date: "2019-11-13"
title: "Docker Titbits"
description: "Poshjoshs-Blog - Docker Titbits"
lang: "en-us"
---

### Image Names ###
- Docker container and image names should be alpha-numeric [A-Za-z_-].
The names are used to create files on the file system... some file systems don't
play well with non alpha-numeric characters in names.

### Useful Commands ###
- Host ip.
Host could be viewed by running the following command as root user:
```
C:\WINDOWS\system32>docker-machine ip default
192.168.99.100
```

- List machines
```
C:\WINDOWS\system32>docker-machine ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER     ERRORS
default   *        virtualbox   Running   tcp://192.168.99.100:2376           v18.09.7
```

- List processes
```
C:\WINDOWS\system32>docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                                              NAMES
52c60eacd03d        jenkinsci/blueocean   "/sbin/tini -- /usr/…"   About an hour ago   Up About an hour    0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp   jenkins-blueocean
```

- SSH into a Container
  * Use docker ps to get the name of the existing container.
  * Use the command docker exec -it <container name> /bin/bash to get a bash shell in the container.
  * Generically, use docker exec -it <container name> <command> to execute whatever command you specify in the container.
```
docker exec -u 0 -it <container_name_or_id> /bin/bash
```
Here, the -u 0 flag specifies that the root user with id 0 be used to run /bin/bash
