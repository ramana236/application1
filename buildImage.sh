#This script will build docker image

version=$BUILD_ID
sudo bash
docker build -t apprepo:$version .
aws ecr get-login-password --region ap-south-1  | docker login --username AWS --password-stdin 202714190885.dkr.ecr.ap-south-1.amazonaws.com
docker tag apprepo:$version 202714190885.dkr.ecr.ap-south-1.amazonaws.com/apprepo:$version
docker push 202714190885.dkr.ecr.ap-south-1.amazonaws.com/apprepo:$version

echo "Image Successfully pushed to ecr"
