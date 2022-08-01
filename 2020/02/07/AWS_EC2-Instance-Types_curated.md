---
path: "./2020/02/07/AWS_EC2-Instance-Types_curated.md"
date: "2020-02-07T21:05:14"
title: "AWS EC2 Instance Types - Curated"
description: "Virtually the best, up-to-date summary of AWS EC2 instance types"
tags: ["AWS", "FAQ", "EC2", "instance type", "general purpose", "compute optimized", "memory optimized", "accelerated computing", "storage optimized", "SAP certified EC2 instances", "vCPU"]
lang: "en-us"
---

### Acronyms ###

- FPGAs - field programmable gate arrays
- HDD - Hard Disk Drive
- SSD - Solid State Drive
- NVMe - Non-Volatile Memory Express
- AVX - Advanced Vector Extensions
- MPP - Massively Parallel Processing

### Before we Set-off ###

- This article aims to be the best up-to-date summary of AWS EC2 instance types.

- At the end of this article you should have a coherent mental model comprising
of up-to-date info on AWS EC2 instance types.

- You should also refer to this article from time to time to refresh that
mental model.

- This article is an estimated 16 - minute read.

### TL;DR ###

Read the __Takeaways__ at the end of this article.

### Introduction ###

This is a gentle visual introduction. Start by glancing deliberately through
the table below.

Class                 | Types
----------------------|-------------------------
General Purpose       | A, T, M
Compute Optimized     | C
Memory Optimized      | R, X, High Memory, z
Accelerated Computing | P, Inf1, G, F
Storage Optimized     | I, D, H

__Memory Guide__

- `A`, `T` and `M` (ATM) - general purpose.
- `C` for compute
- `G` for graphics - accelerated computing
- `I` for I/O performance - storage optimized
- `D` for dense storage  - storage optimized
- `H` for HDD - storage optimized

### General Purpose ###

`General Purpose` instances provide a balance of compute, memory and networking
resources.. ideal for scale out workloads, `web servers and code repositories`.

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)    	
-----|------------------------------------------|-----------------------|---------------|----------|-------------
A1   | Save cost. For scale out arm workloads.	| EBS only 		          | Up to 10    	| 1 - 16   | 2 - 32
T    | Burstable CPU usage			                | EBS only		          | Up to 5 	    | 1 - 8    | 0.5 - 32  
M    | General purpose (M5n = network optimized)| EBS, m5?d? = NVMe SSD	| Up to 100	    | 1 - 96   | 4 - 384

- `a1.metal` provides 16 physical cores

- `T` provides burst performance. While your instance is idle, credits accrue.
When extra load comes the credits are used to burst performance.

- Enhanced Networking, AVX and AVX2  are only available on instances launched
with HVM AMIs.

### Compute Optimized ###

`Compute Optimized` instances are ideal for compute bound applications that
benefit from high performance processors.. ideal for `batch processing workloads,
media transcoding, high performance web servers, high performance computing (HPC),
scientific modeling, dedicated gaming servers and ad server engines, machine
learning inference` and other compute intensive applications.

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)
-----|------------------------------------------|-----------------------|---------------|----------|-------------
C    | Compute optimized (C5n=network optimized)| EBS, C5d.* = NVMe SSD	| Up to 100	    | 2 - 96   | 3.75 - 192

- Enhanced Networking, AVX and AVX2  are only available on instances launched
with HVM AMIs.

- `c4.8xlarge` instance type provides the ability for an operating system to
control processor C-states and P-states. This feature is currently available
only on Linux instances.

### Memory Optimized ###

`Memory optimized` instances provide fast performance for workloads that
process `large data sets in memory`.

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)    	
-----|------------------------------------------|-----------------------|---------------|----------|-------------
R    | Memory intensive workloads              	| EBS, R?d.* = NVMe SSD | Up to 100    	| 2 - 96   | 15.25 - 768
X    | High performance in-mem applications   	| SSD, EBS optimized    | Up to 25     	| 4 -128   | 122 - 3,904
High Memory | For large in-mem db e.g SAP HANA 	|                       | 100          	|          | 6144 - 24,576
z1d  | Compute + Memory + High frequency       	| NVMe SSD 		          | Up to 25     	| 2 - 48   | 16 - 384

- `r5.metal` and `r5d.metal` provide 96 logical processors on 48 physical
cores; they run on single servers with two physical Intel sockets.

- `X type` - Up to 3,904 of DRAM-based instance memory with SSD instance
storage for temporary block-level storage.

- `High Memory` - Names are of format u-`(\d{1,2})`tb1.metal (i.e u- followed
by 1 or 2 digits followed by tb1.metal)

- `High Memory` - 448 logical processors, each a hyperthread on 224 cores

- `z1d.metal` provides 48 logical processors on 24 physical cores

- `High frequency z1d instances` deliver the fastest of any cloud instance; a
sustained all core frequency of up to 4.0 GHz.

### Accelerated Computing ###

`Accelerated computing` instances use hardware accelerators, or co-processors,
to perform functions, such as `floating point number calculations, graphics
processing, or data pattern matching`, more efficiently than is possible in
software running on CPUs.

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)| GPU      | GPU Mem (GiB)
-----|------------------------------------------|-----------------------|---------------|----------|-------------|----------|--------------
P    | General Purpose GPU                      | EBS, p?d.* = NVMe SSD | Up to 100    	| 4 - 96   | 61 - 768    | 1 - 16   | 12 - 256
Inf1 | For machine learning inference           | EBS                   | Up to 100     | 4 - 96   | 8 - 192     |          |
G    | Graphics intensive and machine learning  |                       | Up to 100    	| 4 - 96   | 16 - 488    | 1 - 8    | 8 - 128
F    | Customizable hardware acceleration with FPGAs| SSD up to 4x950GiB| Up to 25      | 8 - 64   | 122 - 976   | 1 - 8 FPGAs |

- For peer-to-peer GPU Communications:

  * `P3 type` supports NVLink

  * `P2 type` supports GPUDirect

### Storage Optimized ###

`Storage optimized` instances provide high, sequential read and write access
to very large data sets on local storage. They are optimized to deliver tens
of thousands of low-latency, random I/O operations per second (IOPS) to
applications.

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)    	
-----|------------------------------------------|-----------------------|---------------|----------|-------------
I    | Low latency, high random I/O and sequential disk throughput| NVMe SSD | Up to 25 | 2 - 72   | 15.25 - 512
D    | MPP data warehouse, distributed computing| HDD up to 24 x 2000   | Up to 10     	| 4 - 36   | 30.5 - 244
H    | high disk throughput, balance of compute & memory| HDD up to 8 x 2000 | Up to 25	| 8 - 64   | 32 - 256

- Enhanced networking, AVX, AVX2, and AVX-512 are only available on instances
launched with HVM AMIs.

- There is an overlap of the use cases of memory optimized and storage
optimized. You can choose a memory optimized instance type and impl an EBS
volume that gives storage optimization

### Curated Use Cases ###

- __Micro services__ - `A`, `T`, `M`
- __Small and mid-sized database__ - `A`, `T`, `M`
- __Development environments__ - `A`, `T`
- __Web servers__ - `A`
- __Test and staging environments__ - `T2`
- __High performance web servers__ - `C`
- __Distributed analytics__ - `C`
- __Distributed web scale in-memory caches__ - `R`
- __Mid sized in-memory databases__ - `R`
- __Real time big data__ - `R`
- __Graphics-intensive workloads__ - `G`
- __In-memory databases__ - `X`, `I`
- __NoSQL databases (e.g. Cassandra, MongoDB, Redis)__ - `I`
- __Distributed computing__ - `D2`
- __Distributed file systems__ - `I3en`, `D2`, `H1`

### Specialized Instances ###

- `z1d` - Ideal for electronic design automation (EDA) and certain relational
database workloads with high per-core licensing costs.
- `Inf1` - Built from the ground up to support machine learning inference applications.
- `G3` - 3D visualizations and rendering in addition to other graphics - intensive workloads.
- `F1` - Offers customizable hardware acceleration with field programmable gate arrays (FPGAs).

__Network and Storage Specialized__

- n variants (e.g m5n, c5n, R5n) are network optimized.
- d variants (e.g m5d, c5d, R5ad) use NVMe SSD storage.
- `I` and `F` instance types use NVMe SSD storage

__SAP Certified__

- `x1e.32xlarge` - certified by SAP to run next-generation Business Suite S/4HANA, Business Suite on HANA (SoH), Business Warehouse on HANA (BW), and Data Mart Solutions on HANA on the AWS cloud.

- `X1` - Certified by SAP to run Business Warehouse on HANA (BW), Data Mart Solutions on HANA, Business Suite on HANA (SoH), Business Suite S/4HANA.

- `High Memory` - Certified by SAP for running Business Suite on HANA, the next-generation Business Suite S/4HANA, Data Mart Solutions on HANA, Business Warehouse on HANA, and SAP BW/4HANA in production environments.

### Use Cases ###

__General Purpose__

Types | Use cases
------|----------
A1 | Scale-out workloads such as web servers, containerized microservices, caching fleets, and distributed data stores, as well as development environments
T3,T3a | Micro-services, low-latency interactive applications, small and medium databases, virtual desktops, development environments, code repositories, and business-critical applications
T2 | Websites and web applications, development environments, build servers, code repositories, micro services, test and staging environments, and line of business applications.  
M6g | Applications built on open-source software such as application servers, microservices, gaming servers, mid-size data stores, and caching fleets.
M5,M5a | Small and mid-size databases, data processing tasks that require additional memory, caching fleets, and for running backend servers for SAP, Microsoft SharePoint, cluster computing, and other enterprise applications
M5n | Web and application servers, small and mid-sized databases, cluster computing, gaming servers, caching fleets, and other enterprise applications
M4 | Small and mid-size databases, data processing tasks that require additional memory, caching fleets, and for running backend servers for SAP, Microsoft SharePoint, cluster computing, and other enterprise applications.

__Compute Optimized__

Types | Use cases
------|----------
C5,C5n | High performance web servers, scientific modelling, batch processing, distributed analytics, high-performance computing (HPC), machine/deep learning inference, ad serving, highly scalable multiplayer gaming, and video encoding.
C4 | High performance front-end fleets, web-servers, batch processing, distributed analytics, high performance science and engineering applications, ad serving, MMO gaming, and video-encoding.

__Memory Optimized__

Types | Use cases
------|----------
R5,R5a | Memory intensive applications such as high performance databases, distributed web scale in-memory caches, mid-size in-memory databases, real time big data analytics, and other enterprise applications.
R5n |                                          High performance databases, distributed web scale in-memory caches, mid-sized in-memory database, real time big data analytics, and other enterprise applications
R4 | High performance databases, data mining & analysis, in-memory databases, distributed web scale in-memory caches, applications performing real-time processing of unstructured big data, Hadoop/Spark clusters, and other enterprise applications.
X1e | High performance databases, in-memory databases (e.g. SAP HANA) and memory intensive applications. `x1e.32xlarge` instance certified by SAP to run next-generation Business Suite S/4HANA, Business Suite on HANA (SoH), Business Warehouse on HANA (BW), and Data Mart Solutions on HANA on the AWS cloud.
X1 | In-memory databases (e.g. SAP HANA), big data processing engines (e.g. Apache Spark or Presto), high performance computing (HPC). Certified by SAP to run Business Warehouse on HANA (BW), Data Mart Solutions on HANA, Business Suite on HANA (SoH), Business Suite S/4HANA.
High Memory | Large enterprise databases, including production installations of SAP HANA in-memory database in the cloud. Certified by SAP for running Business Suite on HANA, the next-generation Business Suite S/4HANA, Data Mart Solutions on HANA, Business Warehouse on HANA, and SAP BW/4HANA in production environments.
z1d | Ideal for electronic design automation (EDA) and certain relational database workloads with high per-core licensing costs.

__Accelerated computing__

Types | Use cases
------|----------
P3 | Machine/Deep learning, high performance computing, computational fluid dynamics, computational finance, seismic analysis, speech recognition, autonomous vehicles, drug discovery.
P2 | Machine learning, high performance databases, computational fluid dynamics, computational finance, seismic analysis, molecular modeling, genomics, rendering, and other server-side GPU compute workloads.
Inf1 | Recommendation engines, forecasting, image and video analysis, advanced text analytics, document analysis, voice, conversational agents, translation, transcription, and fraud detection.
G4 | Machine learning inference for applications like adding metadata to an image, object detection, recommender systems, automated speech recognition, and language translation. G4 instances also provide a very cost-effective platform for building and running graphics-intensive applications, such as remote graphics workstations, video transcoding, photo-realistic design, and game streaming in the cloud.  
G3 | 3D visualizations, graphics-intensive remote workstation, 3D rendering, application streaming, video encoding, and other server-side graphics workloads.
F1 | Genomics research, financial analytics, real-time video processing, big data search and analysis, and security.

__Storage Optimized__

Types | Use cases
------|----------
I3 | NoSQL databases (e.g. Cassandra, MongoDB, Redis), in-memory databases (e.g. Aerospike), scale-out transactional databases, data warehousing, Elasticsearch, analytics workloads.
I3en|NoSQL databases (e.g. Cassandra, MongoDB, Redis), in-memory databases (e.g. SAP HANA, Aerospike), scale-out transactional databases, distributed file systems, data warehousing, Elasticsearch, analytics workloads.
D2 | Massively Parallel Processing (MPP) data warehousing, MapReduce and Hadoop distributed computing, distributed file systems, network file systems, log or data-processing applications.
H1 | MapReduce-based workloads, distributed file systems such as HDFS and MapR-FS, network file systems, log or data processing applications such as Apache Kafka, and big data workload clusters.

### Instance Features ###

__Burstable Performance__

Amazon EC2 allows you to choose between Fixed Performance Instances (e.g. M5,
C5, and R5) and Burstable Performance Instances (T instances). Many applications
such as web servers, developer environments and small databases don’t need
consistently high levels of CPU, but benefit significantly from having full
access to very fast CPUs when the need arises. T instances are engineered
specifically for these use cases. While your T instance is idle, credits accrue.
On occasion of extra load, the credits are used to burst performance.

T Unlimited instances can sustain high CPU performance for as long as a
workload needs it. For most general-purpose workloads, T Unlimited instances
will provide ample performance without any additional charges. The hourly T
instance price automatically covers all interim spikes in usage when the
average CPU utilization of a T instance is at or less than the baseline over
a 24-hour window. If the instance needs to run at higher CPU utilization for a
prolonged period, it can do so at a flat additional charge of 5 cents per vCPU-hour.

Also, with T Unlimited enabled, a T instance can burst above the baseline
even after its CPU Credit balance is drawn down to zero.

__Storage Options__

Amazon EC2 allows you to choose between multiple storage options based on your
requirements.

- EBS - Block-level storage volume that you can attach to a single, running
Amazon EC2 instance.

- Instance Stores - Block level storage from disks that are physically attached
to the host computer. Data persists only during the life of the associated
EC2 instance.

- S3 - Amazon managed highly durable, highly available object storage.

__EBS-optimized Instances__

For an additional, low, hourly fee, customers can launch selected Amazon EC2
instances types as EBS-optimized instances. For C5, C4, M5, M4, P3, P2, G3, and
D2 instances, this feature is enabled by default at no additional cost.
EBS-optimized instances enable EC2 instances to fully use the IOPS provisioned
on an EBS volume.

AWS recommends using Provisioned IOPS volumes with EBS-optimized instances or
instances that support cluster networking for applications with high storage
I/O requirements.

__Cluster Networking__

Select EC2 instances support cluster networking when launched into a common
cluster placement group. A cluster placement group provides low-latency
networking between all instances in the cluster. The bandwidth an EC2 instance
can utilize depends on the instance type and its networking performance specification

### Virtual CPUs per Instance Type ###

Instance Size | 	vCPUs
--------------|--------
nano |	1
micro |	1
small |	1
medium |	1
large |	2
xlarge |	4
2xlarge |	8
3xlarge |	12
4xlarge |	16
8xlarge |	32
9xlarge |	36
10xlarge |	40
12xlarge |	48
16xlarge |	64
18xlarge |	72
24xlarge |	96
32xlarge |	128

### Takeaways ###

Type |    Description				                    |    Storage 		        | Network Gbps	| vCPU	   | Memory (GiB)| GPU      | GPU Mem (GiB)    	
-----|------------------------------------------|-----------------------|---------------|----------|-------------|----------|--------------
A1   | Save cost. For scale out arm workloads.	| EBS only 		          | Up to 10    	| 1 - 16   | 2 - 32      
T    | Burstable CPU usage			                | EBS only		          | Up to 5 	    | 1 - 8    | 0.5 - 32  
M    | General purpose (M5n = network optimized)| EBS, m5?d? = NVMe SSD	| Up to 100	    | 1 - 96   | 4 - 384
C    | Compute optimized (C5n=network optimized)| EBS, C5d.* = NVMe SSD	| Up to 100	    | 2 - 96   | 3.75 - 192
R    | Memory intensive workloads              	| EBS, R?d.* = NVMe SSD | Up to 100    	| 2 - 96   | 15.25 - 768
X    | High performance in-mem applications   	| SSD, EBS optimized    | Up to 25     	| 4 -128   | 122 - 3,904
High Memory | For large in-mem db e.g SAP HANA 	|                       | 100          	|          | 6144 - 24,576
z1d  | Compute + Memory + High frequency       	| NVMe SSD 		          | Up to 25     	| 2 - 48   | 16 - 384
P    | General Purpose GPU                      | EBS, p?d.* = NVMe SSD | Up to 100    	| 4 - 96   | 61 - 768    | 1 - 16   | 12 - 256
Inf1 | For machine learning inference           | EBS                   | Up to 100     | 4 - 96   | 8 - 192     |          |
G    | Graphics intensive and machine learning  |                       | Up to 100    	| 4 - 96   | 16 - 488    | 1 - 8    | 8 - 128
F    | Customizable hardware acceleration with FPGAs| SSD up to 4x950GiB| Up to 25      | 8 - 64   | 122 - 976   | 1 - 8 FPGAs |
I    | Low latency, high random I/O and sequential disk throughput| NVMe SSD | Up to 25 | 2 - 72   | 15.25 - 512
D    | MPP data warehouse, distributed computing| HDD up to 24 x 2000   | Up to 10     	| 4 - 36   | 30.5 - 244
H    | high disk throughput, balance of compute & memory| HDD up to 8 x 2000 | Up to 25	| 8 - 64   | 32 - 256

- While your `T` instance is idle, credits accrue. On occasion of extra load,
the credits are used to burst performance.

- Also, with T Unlimited enabled, a T instance can burst above the baseline
even after its CPU Credit balance is drawn down to zero.

- EBS-optimized instances enable EC2 instances to fully use the IOPS provisioned
on an EBS volume.

- EBS-optimization enabled by default at no additional cost for
C5, C4, M5, M4, P3, P2, G3, and D2 instance types.

- D2 instance type offers  the lowest price per disk throughput

- Curated Use Cases

  - __Micro services__ - `A`, `T`, `M`
  - __Small and mid-sized database__ - `A`, `T`, `M`
  - __Development environments__ - `A`, `T`
  - __Web servers__ - `A`
  - __Test and staging environments__ - `T2`
  - __High performance web servers__ - `C`
  - __Distributed analytics__ - `C`
  - __Distributed web scale in-memory caches__ - `R`
  - __Mid sized in-memory databases__ - `R`
  - __Real time big data__ - `R`
  - __Graphics-intensive workloads__ - `G`
  - __In-memory databases__ - `X`, `I`
  - __NoSQL databases (e.g. Cassandra, MongoDB, Redis)__ - `I`
  - __Distributed computing__ - `D2`
  - __Distributed file systems__ - `I3en`, `D2`, `H1`

### References ###

- [AWS EC2 FAQs](https://aws.amazon.com/ec2/faqs/)

- [AWS EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/)
