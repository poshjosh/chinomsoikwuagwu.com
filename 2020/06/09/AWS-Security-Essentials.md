---
path: "./2020/06/09/AWS-Security-Essentials.md"
date: "2020-06-09T20:49:00"
title: "AWS Security Essentials"
description: "AWS Security Essentials"
tags: ["AWS", "Security", "Identity and Access Management", "IAM", "Single Sign On", "SSO", "two-way trust", "AD connector", "signed URLs", "signed cookies", "Origin Access Identity", "OAI", "Vault lock policy", "vault access policy", "AWS Shield", "AWS Web Application Firewall", "WAF", "security token service", "AssumeRole", "AssumeRoleWithSAML", "AssumeRoleWithWebIdentity", "GetFederationToken", "GetSessionToken", "GetCallerIdentity", "GetAccessKeyInfo", "DecodeAuthorizationMessage"]
lang: "en-us"
---

### Identity and Access Management (IAM) ###

- An instance profile is a container for an IAM role that you can use to pass
role information to an EC2 instance when the instance starts.

  * If you use the AWS Management Console to create a role for Amazon EC2, an
  instance profile with same name as the role is automatically created.
  * An instance profile can contain only one IAM role.

- IAM Roles for ECS tasks functions similar to how EC2 instance profiles provide
credentials for EC2 instances.

- __Cross-account IAM roles__ allow customers to securely grant access to AWS
resources in their account to a third party like an APN Partner.

### Security Token Service ###

AWS Security Token Service (AWS STS) is a web service that enables you to request
temporary, limited-privilege credentials for AWS Identity and Access Management
(IAM) users or for users that you authenticate (federated users).

The following actions are supported:

-    `AssumeRole` - Returns a set of temporary security credentials that you can use to access AWS resources that you might not normally have access to.

-    `AssumeRoleWithSAML` - Returns a set of temporary security credentials for users who have been authenticated via a SAML authentication response.

-    `AssumeRoleWithWebIdentity` - Returns a set of temporary security credentials for users who have been authenticated in a mobile or web application with a web identity provider. Example providers include Amazon Cognito, Login with Amazon, Facebook, Google, or any OpenID Connect-compatible identity provider.

-    `DecodeAuthorizationMessage` - Decodes additional information about the authorization status of a request from an encoded message returned in response to an AWS request.

-    `GetAccessKeyInfo` - Returns the account identifier for the specified access key ID.

-    `GetCallerIdentity` - Returns details about the IAM user or role whose credentials are used to call the operation.

-    `GetFederationToken` - Returns a set of temporary security credentials (consisting of an access key ID, a secret access key, and a security token) for a federated user. A typical use is in a proxy application that gets temporary security credentials on behalf of distributed applications inside a corporate network

-    `GetSessionToken` - Returns a set of temporary credentials for an AWS account or IAM user. The credentials consist of an access key ID, a secret access key, and a security token. Typically, you use GetSessionToken if you want to use MFA to protect programmatic calls to specific AWS API operations like Amazon EC2 StopInstances.

For `AssumeRole`, `AssumeRoleWithSAML` and `AssumeRoleWithWebIdentity`:

- You cannot use AWS account root user credentials to call. You must use
credentials for an IAM user or an IAM role to call AssumeRole.

- `One hour` - default duration which the temporary credentials created lasts.

- The temporary security credentials created can be used to make API calls to
any AWS service with the following exception: You cannot call the AWS STS
`GetFederationToken` or `GetSessionToken` API operations.

### AWS Single Sign On (SSO) ###

Connect AWS SSO to an On-Premises Active Directory

Users in your on-premises Active Directory can also have SSO access to AWS accounts and cloud applications in the AWS SSO user portal. To do that, AWS Directory Service has the following two options available:

    Create a two-way trust relationship – When two-way trust relationships are created between AWS Managed Microsoft AD and an on-premises Active Directory, on-premises users can sign in with their corporate credentials to various AWS services and business applications. One-way trusts do not work with AWS SSO. For more information about setting up a two-way trust, see When to Create a Trust Relationship in the AWS Directory Service Administration Guide.

    Create an AD Connector – AD Connector is a directory gateway that can redirect directory requests to your on-premises Active Directory without caching any information in the cloud. For more information, see Connect to a Directory in the AWS Directory Service Administration Guide.

Note

If you are connecting AWS SSO to an AD Connector directory, any future user password resets must be done from within Active Directory. This means that users will not be able to reset their passwords from the user portal.
Note

AWS SSO does not work with SAMBA4-based Simple AD directories.

### S3 Security ###

- __Restrict access to content served from S3 buckets__ so that users can only
access your files through CloudFront, not directly from the S3 bucket.

  * Using either __signed URLs__ or __signed cookies__.

     - Only `RSA-SHA1` supported for signing URLs or cookies.

  * Using __origin access identity__

    - Create a special CloudFront user called an origin access identity (OAI)
    and associate it with your distribution.
    - Configure your S3 bucket permissions so that CloudFront can use the OAI
    to access the files in your bucket and serve them to our users.
    - `Not applicable` to Amazon S3 bucket configured as a website endpoint

- A presigned URL gives you access to the object identified in the URL, provided that the creator of the presigned URL has permissions to perform the operation that the URL is based upon. (REST API, CLI, SDK)

  * Enabled users upload a specific object to your bucket without having AWS credentials or permissions.
  * Time based access (e.g 1 week etc)

  Glacier Vault Lock allows you to easily deploy and enforce compliance controls for individual S3 Glacier vaults with a vault lock policy. You can specify controls such as “write once read many” (WORM) in a vault lock policy and lock the policy from future edits. Once locked, the policy can no longer be changed.

- __Vault lock vs Vault access policy__ Both policies govern access controls.

  * __Vault lock policy__ - can be locked to prevent future changes, providing strong enforcement for your compliance controls. You can use the vault lock policy to deploy regulatory and compliance controls, which typically require tight controls on data access.

  * __Vault access policy__ used to implement access controls that are not compliance related, temporary, and subject to frequent modification.

  * Both policy types can be used together. For example, vault lock policy (deny deletes), and vault access policy (grant read access) to designated third parties or your business partners (allow reads).

### Relational Database Service (RDS) Security ###

__Using Secure Sockets Layer (SSL)__

- RDS supports SSL connections from applications.
- At instance provision time, RDS creates and installs an SSL certificate
signed by a certificate authority.
- The SSL certificate includes the DB instance endpoint as the Common Name (CN)
to guard against spoofing attacks.
- As a result, you can only use the `DB cluster endpoint` to connect to a DB cluster
using SSL if your client supports Subject Alternative Names (SAN). Otherwise,
you must use the `instance endpoint of a writer instance`.

### Aurora Security ###

- __Identity and Access Management (IAM).__ To control who can perform Amazon
RDS management actions on Aurora DB clusters and DB instances, you use AWS IAM.

- __VPC security group__. Aurora DB clusters must be created in an Amazon
Virtual Private Cloud (VPC). To control which devices and Amazon EC2 instances
can open connections to the endpoint and port of the DB instance for Aurora DB
clusters in a VPC, you use a VPC security group

- __Authenticate logins and permissions__ for an Amazon Aurora DB cluster, you can:

  * Take the same approach as with a stand-alone DB instance of MySQL or
  PostgreSQL such as using SQL commands or modifying database schema tables.
  * Use IAM database authentication for Aurora MySQL. You authenticate to your
  Aurora MySQL DB cluster by using an IAM user or IAM role and an authentication
  token. IAM database authentication provides the following benefits:

    - Network traffic to and from the database is encrypted using Secure Sockets Layer (SSL).

    - You can use IAM to centrally manage access to your database resources, instead of managing access individually on each DB cluster.

    - For applications running on Amazon EC2, you can use profile credentials specific to your EC2 instance to access your database instead of a password, for greater security.

### Titbits ###

- An option in the answers could suggest using WAF against DDoS, or AWS Shield
mitigate SQL injection attacks - Wrong and wrong again.

  * AWS Shield - Provides protection against DDoS. Standard version of Shield
  implemented automatically on all AWS accounts.
  * Web Application Firewall - Sits in front of your website to provide additional
  protection against common attacks such as SQL injection and XSS.

- KMS master keys are region-specific

__Symmetric vs asymmetric encryption__

  Symmetric encryption, the message to be protected can be encrypted and decrypted using the same key.

  Asymmetric encryption, requires the use of two separate keys: a public key and private key. Data is encoded using the public key, and decoded using the private key.
