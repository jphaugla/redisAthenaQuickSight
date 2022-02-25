CAP1=CAPABILITY_NAMED_IAM
CAP2=CAPABILITY_AUTO_EXPAND
CAP3=CAPABILITY_IAM
aws cloudformation deploy --template-file ./packaged-template.out --stack-name ${PROJECT_NAME} --capabilities $CAP1 $CAP2 $CAP3 --parameter-overrides ProjectName=$PROJECT_NAME S3BucketName=${S3_BUCKET} RedisDatabasePort=${REDISPORT} ClusterName=${CLUSTERNAME} HostedZoneName=${HOSTEDZONENAME} HostedZoneId=${HOSTEDZONEID} ClusterUserName=${CLUSTERUSERNAME} ClusterPassword=${CLUSTERPASSWORD} ClusterURL=${CLUSTERURL} LocalIp=${LOCAL_IP} CreateAdditional=${CREATE_ALL} CreateConnector=${CREATE_CONNECTOR} S3Bucket=${S3_BUCKET} KeyPair=${KEY_PAIR} RedisEC2InstanceType=${REDIS_EC2_INSTANCE_TYPE} NumberInstances=${NUMBER_INSTANCES} RedisVpcCIDR=${REDIS_VPC_CIDR} HaProxyVpcCIDR=${HAPROXY_VPC_CIDR} ClientVpcCIDR=${CLIENT_VPC_CIDR} CreateHaProxy=${CREATE_HA_PROXY} UseRedisElasticIP=${CREATE_ELASTIC_IPS} CreateRedis=${CREATE_REDIS}
