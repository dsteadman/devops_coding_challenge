#!/bin/sh -ex

VERSION=$1

if [ -z "$VERSION" ]
then
  echo "Usage: $0 <version>"
  exit 1
fi

IMAGE_ID=ebb-staging-resources-lambda:${VERSION}

cp ../../../data/ebbcarbon.yaml dist
# docker build --no-cache --progress plain --platform linux/amd64 -t $IMAGE_ID .
cd dist
docker build --no-cache --platform linux/amd64 -t ${IMAGE_ID} .
rm ebbcarbon.yaml

aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 381422376610.dkr.ecr.us-west-2.amazonaws.com
docker tag ${IMAGE_ID} 381422376610.dkr.ecr.us-west-2.amazonaws.com/${IMAGE_ID}
docker push 381422376610.dkr.ecr.us-west-2.amazonaws.com/${IMAGE_ID}

# docker run --rm --platform linux/amd64 -p 9000:8080 $IMAGE_ID
