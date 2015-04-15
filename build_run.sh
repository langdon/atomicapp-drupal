#!/bin/bash

if [ -z "$USERNAME" ]; then
    echo "setting USERNAME to " `whoami` 
    USERNAME=`whoami`
fi

if [ -z "$DOCKER_REGISTRY" ]; then
    echo "setting DOCKER_REGISTRY to localhost:5000" 
    DOCKER_REGISTRY=localhost:5000
fi

BASE_DIR=`pwd`
cd mariadb-app/mariadb
#docker build --rm -t $USERNAME/maria --file="docker-artifacts/Dockerfile" .
docker build -t $USERNAME/maria --file="docker-artifacts/Dockerfile" .
docker tag $USERNAME/maria $DOCKER_REGISTRY/maria
docker push $DOCKER_REGISTRY/maria
#docker rmi $USERNAME/maria
cd $BASE_DIR

#echo docker build --rm -t $USERNAME/atomicapp-run .
#docker build --rm -t $USERNAME/atomicapp-run .

#doesn't really make sense to run it
#test
#docker run -it --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run /bin/bash
#run
#docker run -dt --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run
#
