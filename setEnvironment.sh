#!/bin/bash
#  this project name is used in many of the object names for several of the cloudformation stacks
export PREFIX=xxx
#  get current region 
export FULL_REGION=`aws configure get region`
#  this removes the dashes from region name
export REGION=`sed 's/-//g' <<<"$FULL_REGION"`
export PROJECT_NAME=${PREFIX}-${REGION}
#  staging bucket name to initially hold code uploaded from this github
export S3_BUCKET=${PROJECT_NAME}-s3-temp-bucket
# local ip to limit the opening of the firewall 
export LOCAL_IP=`curl http://checkip.amazonaws.com/`
#  Redis port for the database
export REDISPORT=12000
#  DNS cluster prefix within the Hosted Zone Name
export CLUSTERNAME=${REGION}.${PREFIX}
#  This must already exist-not created with these scripts
export HOSTEDZONENAME=xxxx-rlec.xxxxxxxx.com
#  Zone names can be duplicate, add the specific zone id
export HOSTEDZONEID=xxxxxxxxxx
#  User name and password for Redis Cluster login
export CLUSTERUSERNAME=xxxxxxxxxx@xxxxxx.com
export CLUSTERPASSWORD=xxxxxxxxxx
export CLUSTERURL=${CLUSTERUSERNAME}:${CLUSTERPASSWORD}
#  controls if additional components such as EMR, Hbase and Aurora are created
export CREATE_ALL=false
#  controls if redis connector is created
export CREATE_CONNECTOR=false
#  ec2 instance type for Redis instances
export EC2_INSTANCE_TYPE=r4.2xlarge
#  key pair for redis ec2 instances
export KEY_PAIR=${PREFIX}_${REGION}
# number of instances between 1 and 3
export NUMBER_INSTANCES=2
