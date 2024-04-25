#!/bin/sh -ex

VERSION=${1:-0.0.0}
ENVIRONMENT=${2:-staging}
AWS_ACCOUNT=${3:-1234567890}

IMAGE_ID=ebb-${ENVIRONMENT}-resources-lambda:${VERSION}

cp data/ebbcarbon.yaml dist
# docker build --no-cache --progress plain --platform linux/amd64 -t $IMAGE_ID .
docker build --platform linux/amd64 -t ${IMAGE_ID} dist
rm dist/ebbcarbon.yaml

# aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.us-west-2.amazonaws.com
docker tag ${IMAGE_ID} ${AWS_ACCOUNT}.dkr.ecr.us-west-2.amazonaws.com/${IMAGE_ID}
# docker push ${AWS_ACCOUNT}.dkr.ecr.us-west-2.amazonaws.com/${IMAGE_ID}

docker run --rm --platform linux/amd64 -p 9000:8080 $IMAGE_ID
