aws cloudformation package --template templates/AWSFederatedRedis.yaml --s3-bucket $S3_BUCKET --force-upload --output-template-file packaged-template.out 
