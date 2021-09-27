# redisAthenaQuickSight - Redis Enterprise integrated with AWS Athena and Quicksight

## Purpose

Demo integrating Redis Enterprise with Amazon Athena and Amazon QuickSight



&nbsp;

## Outline

- [Overview](#overview)
- [AWS Services Used](#aws-services-used)
- [Technical Overview](#technical-overview)
- [Instructions](#instructions)
  - [Create Environment](#create-environment)
  - [Edit Security Group Settings](#edit-security-group-settings)
- [Cleaning up](#cleaning-up)


&nbsp;

## Overview

Initially started with a CloudFormation template from [Amazon Athena Workship](https://athena-in-action.workshop.aws/40-federatedquery.html).  This template has been modified to use Redis Enterprise instead of AWS ElasticCache.  Redis Enterprise offers lower TCO with horizontal and vertical scaling as well as improved developer experience with Redis modules.  

## AWS Services Used

* [Amazon Athena ](https://aws.amazon.com/athena/)
* [Amazon QuickSight ](https://aws.amazon.com/quicksight/)
* [AWS Cloudformation](https://aws.amazon.com/cloudformation/)
* [Amazon RDS](https://aws.amazon.com/rds/)

## Important links
* [Athena Redis connector](https://github.com/awslabs/aws-athena-query-federation/tree/master/athena-redis)
* [Athena/QuickSight federated query blog](https://awsfeed.com/whats-new/big-data/accessing-and-visualizing-data-from-multiple-data-sources-with-amazon-athena-and-amazon-quicksight)
* [Athena/QuickSight federated query lab session](https://awsfeed.com/whats-new/big-data/accessing-and-visualizing-data-from-multiple-data-sources-with-amazon-athena-and-amazon-quicksight)
* [Redis Enterprise Route53 DNS Management](https://docs.redis.com/latest/rs/installing-upgrading/configuring/configuring-aws-route53-dns-redis-enterprise/)

## Technical Overview

* Create S3 bucket using provided Cloudformation yaml file and script.   Optionally, can use existing S3 bucket
* Bring up Athena Federated Query environment using provided scripts and cloud formation yaml files.
* Run through federated query exercises

&nbsp;

---

&nbsp;

## Instructions

***IMPORTANT NOTE**: Creating this demo application in your AWS account will create and consume AWS resources, which **will cost money**.  Costing information is available at [AWS DMS Pricing](https://aws.amazon.com/dms/pricing/)   The template will cost money for the other resources as well.

&nbsp;

### Prepare the repository working directory
* Clone the repository
```bash
git clone https://github.com/jphaugla/redisAthenaQuickSight.git
```
* Set up the environment file for use case
Most of the current environment variable values will work for most use cases but careful consideration must be made for the DNS entries. The subsequent cloudformation scripts will set up DNS but a hosted zone name must be selected and put in to the environment script for this to be successful.  Careful consideration of the cluster name should also be made.   Use the following link for a full explanation of [AWS Route53 DNS management with Redis Enterprise](https://docs.redis.com/latest/rs/installing-upgrading/configuring/configuring-aws-route53-dns-redis-enterprise/) 
Edit setEnvironment.sh file for your environment

### Create Environment
* Some tips on creating an AWS account with [AWS Account instructions](https://athena-in-action.workshop.aws/20-howtostart/201-self-paced.html)
* After reviewing  "Introduction" and "Getting Started", proceed to run the Athena Basic Stack from the workshop Template.
* However, stop before running the "Labs Fedrated Queries, User DEined Functions, Custom Connector & Machine Learning".  Instead, use these steps:
```bash
#  sets up the envrionment
source setEnvironment.sh
# deploy an s3 bucket
# this can be skipped if already have an S3 bucket to use
./cfns3deploy.sh
# package the nested stack up to the S3 bucket 
./cfnpackage.sh
# deploy the stack
./cfndeploy.sh
```

