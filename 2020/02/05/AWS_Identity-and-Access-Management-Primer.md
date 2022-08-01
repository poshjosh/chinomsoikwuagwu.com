---
path: "./2020/02/05/AWS_Identity-and-Access-Management-Primer.md"
date: "2020-02-05"
title: "Amazon Web Services - Identity and Access Management Primer"
description: "Primer on AWS Identity and Access Management (IAM)"
lang: "en-us"
---

### Identity and Access Management (IAM) Primer ###

You can access AWS as any of the following types of identities:

- __AWS account root user__ – This is the sign-in identity you create when you first create our AWS account.

  * Has complete access to all AWS services and resources in the account.
  * Is accessed by signing in with the email address and password that you used to create the account.
  * Do not use the root user for your everyday tasks, even the administrative ones. Instead, adhere to the best practice of using the root user only to create your first IAM user. Then securely lock away the root user credentials and use them to perform only a few account and service management tasks.

- __IAM User__ – An IAM user is an identity within your AWS account that has specific custom permissions (for example, permissions to create a table in DynamoDB). You can:

  * Use an IAM user name and password to sign in to secure AWS webpages.
  * Generate access keys for each user. You can use these keys when you access AWS services programmatically through
  AWS SDKs or AWS CLI.

- __IAM role__ – An IAM role is an IAM identity that you can create in your account that has specific permissions. An IAM role is similar to an IAM user in that it is an AWS identity with permissions policies that determine what the identity can and cannot do in AWS.

  * Instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it.
  * Does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with temporary security credentials for your role session. IAM roles with temporary credentials are useful in the following situations:

    - `Federated user access` – Instead of creating an IAM user, you can use existing identities from AWS Directory Service, your enterprise user directory, or a web identity provider. These are known as federated users. AWS assigns a role to a federated user when access is requested through an identity provider.

    - `AWS service access` – A service role is an IAM role that a service assumes to perform actions in your account on your behalf. When you set up some AWS service environments, you must define a role for the service to assume. This service role must include all the permissions that are required for the service to access the AWS resources that it needs. Service roles vary from service to service, but many allow you to choose your permissions as long as you meet the documented requirements for that service. Service roles provide access only within your account and cannot be used to grant access to services in other accounts. You can create, modify, and delete a service role from within IAM. For example, you can create a role that allows Amazon Redshift to access an Amazon S3 bucket on your behalf and then load data from that bucket into an Amazon Redshift cluster.

    - `Applications running on Amazon EC2` – You can use an IAM role to manage temporary credentials for applications that are running on an EC2 instance and making AWS CLI or AWS API requests. This is preferable to storing access keys within the EC2 instance. To assign an AWS role to an EC2 instance and make it available to all of its applications, you create an instance profile that is attached to the instance. An instance profile contains the role and enables programs that are running on the EC2 instance to get temporary credentials.

### Using Web Identity Federation ###

If you are writing an application targeted at large numbers of users, you can optionally use web identity federation for authentication and authorization. Web identity federation removes the need for creating individual IAM users. Instead, users can sign in to an identity provider and then obtain temporary security credentials from AWS Security Token Service (AWS STS). The app can then use these credentials to access AWS services. Web identity federation supports the following identity providers:

- Login with Amazon

- Facebook

- Google

__Web Identity Federation Overview__

Suppose your mobile app needs to provide access to AWS resources to thousands or millions of users?

- Your app calls a third-party identity provider to authenticate a user and the app. The identity provider returns a web identity token to the app.

- Your app calls AWS STS and passes the web identity token as input. AWS STS authorizes your app and gives it temporary AWS access credentials. Your app is allowed to assume an IAM role and access AWS resources in accordance with the role's security policy.

### Create IAM User ###

You must activate IAM user and role access to Billing before you can use the AdministratorAccess permissions to access the AWS Billing and Cost Management console. To do this, follow the instructions in:

Step 1 of the tutorial: [Delegating access to the billing console](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_billing/)

1. Sign in to AWS

2. In the navigation pane, choose Users and then choose Add user.

3. For User name, enter Administrator.

4. Select the check box next to AWS Management Console access. Then select Custom password, and then enter your new password in the text box.

5. (Optional) By default, AWS requires the new user to create a new password when first signing in. You can clear the check box next to User must create a new password at next sign-in to allow the new user to reset their password after they sign in.

6. Choose Next: Permissions.

7. Under Set permissions, choose Add user to group.

8. Choose Create group.

9. In the Create group dialog box, for Group name enter Administrators.

10. Choose Filter policies, and then select AWS managed -job function to filter the table contents.

11. In the policy list, select the check box for AdministratorAccess. Then choose Create group.

12. Back in the list of groups, select the check box for your new group. Choose Refresh if necessary to see the group in the list.

13. Choose Next: Tags.

14. (Optional) Add metadata to the user by attaching tags as key-value pairs. For more information about using tags in IAM, see Tagging IAM Entities in the IAM User Guide.

15. Choose Next: Review to see the list of group memberships to be added to the new user. When you are ready to proceed, choose Create user.

To sign in as the new IAM user, first sign out of the AWS Management Console. Then use the following URL, where your_aws_account_id is your AWS account number without the hyphens. For example, if your AWS account number is 1234-5678-9012, your AWS account ID is 123456789012.

```
https://your_aws_account_id.signin.aws.amazon.com/console/
```

Type the IAM user name and password that you just created. When you're signed in, the navigation bar displays "your_user_name @ your_aws_account_id".
