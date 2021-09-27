aws cloudformation deploy --template-file templates/createS3.yaml --stack-name ${PROJECT_NAME}-s3 --parameter-overrides S3BucketName=${S3_BUCKET} 
