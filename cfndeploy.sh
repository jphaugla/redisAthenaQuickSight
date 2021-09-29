CAP1=CAPABILITY_NAMED_IAM
CAP2=CAPABILITY_AUTO_EXPAND
CAP3=CAPABILITY_IAM
aws cloudformation deploy --template-file ./packaged-template.out --stack-name ${PROJECT_NAME} --capabilities $CAP1 $CAP2 $CAP3 --parameter-overrides ProjectName=$PROJECT_NAME S3BucketName=${S3_BUCKET} RedisDatabasePort=${REDISPORT} ClusterName=${CLUSTERNAME} HostedZoneName=${HOSTEDZONENAME} HostedZoneId=${HOSTEDZONEID} ClusterUserName=${CLUSTERUSERNAME} ClusterPassword=${CLUSTERPASSWORD} ClusterURL=${CLUSTERURL} LocalIp=${LOCAL_IP} CreateAdditional=${CREATE_ALL} S3Bucket=${S3_BUCKET}
