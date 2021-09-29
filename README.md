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
* A parameter is provided to choose to bring up the full AWS federated query lab environment or only the resources needed for the redis athena query
* The required DNS entries for Redis Enterprise are included in the cloudformation script
* The RedisEnterprise EC2 resource uses the marketplace AMI with the Redis Enterprise Software pre-installed
* This RE EC2 resource has UserData entries to create the Redis Cluster, create a redis database, and load a very small amount of sample redis data using the github after also installing git
* The redis connector is also in a nested cloudformation script called *RedisConnector.yaml*.  This connector allows athena to access Redis.

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
  * Most of the current environment variable values will work for most use cases but careful consideration must be made for the DNS entries. The subsequent cloudformation scripts will set up DNS but a hosted zone name must be selected and put in to the environment script for this to be successful.  Careful consideration of the cluster name should also be made.   Use the following link for a full explanation of [AWS Route53 DNS management with Redis Enterprise](https://docs.redis.com/latest/rs/installing-upgrading/configuring/configuring-aws-route53-dns-redis-enterprise/) 
Edit setEnvironment.sh file for your environment.  Some notes on the setEnvironment script...
  * The LocalIp is used to limit ssh access to AWS resources.  The AWS checkip URL is used.  If you want this wide open, comment out this line and replace with "0.0.0.0/0"
  * A DNS hosted zone must be used for this cloudformation script to work because the additional DNS name space record and DNS Address record(s)
 are added in this cloudformation script

### Create Environment
* Some tips on creating an AWS account with [AWS Account instructions](https://athena-in-action.workshop.aws/20-howtostart/201-self-paced.html)
* After reviewing  "Introduction" and "Getting Started", proceed to run the Athena Basic Stack from the workshop Template.  This is not needed if only proving out the redis part.
* However, stop before running the "Labs Federated Queries, User Defined Functions, Custom Connector & Machine Learning".  Instead, use these steps:
```bash
#  sets up the environment
source setEnvironment.sh
# deploy an s3 bucket
# this can be skipped if already have an S3 bucket to use
./cfns3deploy.sh
# package the nested stack up to the S3 bucket 
./cfnpackage.sh
# deploy the stack
./cfndeploy.sh
```

### Fix data load to Redis
This is no longer necessary as this has been put into the userdata section of the Redis EC2 instance.  Since the connection to EMR is hardcoded in an S3 bucket, the redis load fails when running in EMR.  The rest of the Federated sources load successfully.  Run the following steps to load the nation and active_orders tables into Redis Enterprise
* Use aws s3 cli to get the two needed data files  (these actually are also available in the github under data)
```bash
./downloadFiles.sh
```
* transfer files to the redis instance
```bash
scp -i <path to your private key>  loadscripts.sh ec2-user@<redisPublicIP>:/home/ec2-user
scp -i <path to your private key>  data ec2-user@<redisPublicIP>:/home/ec2-user
```
*  load 2 data files using the load script
```bash
sudo bash
./loadscripts.sh
```

### Continue with the workshop
The [Labs - Athena Basics](https://athena-in-action.workshop.aws/30-basics.html) section does not use the Redis connector but does have the section on "Visualize with QuickSight".  The important part for the Redis Connector is [Labs - Federated Queries](https://athena-in-action.workshop.aws/40-federatedquery.html).  

### Cleanup
Also important is the [cleanup section](https://athena-in-action.workshop.aws/100-cleanups.html) as the cloudformation scripts can't delete some of the resources created.
