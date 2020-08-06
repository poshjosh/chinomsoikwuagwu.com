---
path: "./2020/07/13/Add-SSL-Certificate-to-S3-hosted-website.md"
date: "2020-07-13T03:54:00"
title: "Add SSL Certificate to an S3 hosted website"
description: "How to add SSL Certificate to an S3 hosted website"
tags: ["SSL", "s3 website"]
lang: "en-us"
---

### A work in progress ###

Login to AWS management console

Search for `Certificate Manager` it is under `Security, Identity, & Compliance `

Click the `Certificate Manager` link.

Click `Provision Certificate(s)`

Click `Request a public certificate`

You will be required to add domain names.

If your website is `www.example.com` enter it that way.

Conversely you could enter `*.example.com` to protect multiple subdomains under
the example.com domain. The `*` is called a wild card and in this case it matches,
and thus protects `blog.example.com`, `cart.example.com` etc

You will be asked to select a validation method

DNS validation

Email validation

Request in progress

Export DNS configuration

Domain name: `www.example.com`

Record name: `_15d544ba3ab7f3f2d53a628ee80776d0.www.example.com.`

Record type: `CNAME`

Record value: `_y955eCC11735e5bcee54445f783f67de.kfruftwnjs.acm-validations.aws.`

My Name servers were with AWS hence it took just a few minutes to be issued
the certificate.

After you are issued the certificate browse to the AWS Management Console

Under `Networking & Content Deliver` click on CloudFront
