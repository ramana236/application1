#This script will build docker image

version=$BUILD_ID
docker build -t apprepo:$version .
aws ecr get-login-password --region ap-south-1  | docker login --username AWS --password-stdin 202714190885.dkr.ecr.ap-south-1.amazonaws.com
docker tag apprepo:$version 202714190885.dkr.ecr.ap-south-1.amazonaws.com/apprepo:$version
docker push 202714190885.dkr.ecr.ap-south-1.amazonaws.com/apprepo:$version

echo "Image Successfully pushed to ecr"

#Create new task definition with new version of buildnumber

sed -i s#202714190885.dkr.ecr.ap-south-1.amazonaws.com/apprepo:20#202714190885.dkr.ecr.ap-south-1.amazonaws.com/apprepo:$version#g taskdef.json
aws ecs register-task-definition  --cli-input-json  file://taskdef.json --region ap-south-1

echo "New task revision created"
