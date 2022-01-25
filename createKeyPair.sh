aws ec2 create-key-pair --key-name ${KEY_PAIR} --query 'KeyMaterial' --output text > ${KEY_PAIR}.pem 
