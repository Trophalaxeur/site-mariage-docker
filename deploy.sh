#!/bin/bash

if [ -z $AWS_ACCOUNT_ID ] || [ -z $AWS_REGION ]; then
    echo "You need to export your account id in \$AWS_ACCOUNT_ID and your region in \$AWS_REGION"
    exit -1;
fi

BUILDARGS=""

if [ -n $GIT_ACCESS_KEY ]; then
    BUILDARGS="--build-arg repokey=$GIT_ACCESS_KEY"
fi

VERSION=`cat version`
NAME='sitemariage'

echo "Build and deploy image "$NAME":"$VERSION
echo

# Authent
eval $(aws ecr get-login --region $AWS_REGION)

# Build and push the image
docker build --no-cache=true $BUILDARGS -t $NAME:$VERSION .
docker tag $NAME:$VERSION $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$NAME:$VERSION
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$NAME:$VERSION
