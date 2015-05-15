#!/bin/bash
echo "Note: you may need to add your docker-registry to /etc/sysconfig/docker "
echo "(on CentOS/RHEL/Fedora) for this to push to the registries correctly"


if [ -z "$USERNAME" ]; then
    echo "setting USERNAME to " `whoami`
    USERNAME=`whoami`
fi
exit()
if [ -z "$DOCKER_REGISTRY" ]; then
    echo "setting DOCKER_REGISTRY to localhost:5000"
    DOCKER_REGISTRY=localhost:5000
fi
echo "using USERNAME=$USERNAME"
echo "using DOCKER_REGISTRY=$DOCKER_REGISTRY"

BASE_DIR=`pwd`
echo "building mariadb"
#build mariadb docker container
cd drupal-app/graph/mariadb-app/graph/mariadb
#docker build --rm -t $USERNAME/maria --file="docker-artifacts/Dockerfile" .
docker build -t $USERNAME/mariadb --file="Dockerfile" .
docker tag -f $USERNAME/mariadb $DOCKER_REGISTRY/mariadb$TAG
echo "pushing to $DOCKER_REGISTRY/mariadb$TAG"
docker push $DOCKER_REGISTRY/mariadb$TAG
#docker rmi $USERNAME/maria
echo "build complete: mariadb"
cd $BASE_DIR

#build mariadb-atomicapp  docker container
echo "building mariadb-atomicapp"
cd drupal-app/graph/mariadb-app
docker build -t $USERNAME/mariadb-atomicapp --file="docker-artifacts/Dockerfile" .
#docker build --no-cache -t $USERNAME/mariadb-atomicapp  --file="docker-artifacts/Dockerfile" .
docker tag -f $USERNAME/mariadb-atomicapp $DOCKER_REGISTRY/mariadb-atomicapp$TAG
echo "pushing to $DOCKER_REGISTRY/mariadb$TAG"
echo "y" | docker push $DOCKER_REGISTRY/mariadb-atomicapp$TAG
#docker rmi $USERNAME/mariadb-atomicapp
echo "build complete: mariadb-atomicapp"
cd $BASE_DIR

#build drupal docker container
echo "building drupal"
cd drupal-app/graph/drupal
docker build -t $USERNAME/drupal --file="Dockerfile" .
docker tag -f $USERNAME/drupal $DOCKER_REGISTRY/drupal$TAG
echo "pushing to $DOCKER_REGISTRY/mariadb$TAG"
echo "y" | docker push $DOCKER_REGISTRY/drupal$TAG
echo "build complete: drupal"
cd $BASE_DIR

#build drupal-atomicapp  docker container
echo "building drupal-atomicapp"
cd drupal-app/
docker build -t $USERNAME/drupal-atomicapp  --file="docker-artifacts/Dockerfile" .
docker tag -f $USERNAME/drupal-atomicapp  $DOCKER_REGISTRY/drupal-atomicapp$TAG
echo "pushing to $DOCKER_REGISTRY/mariadb$TAG"
echo "y" | docker push $DOCKER_REGISTRY/drupal-atomicapp$TAG
echo "build complete: drupal-atomicapp"
cd $BASE_DIR

#echo docker build --rm -t $USERNAME/atomicapp-run .
#docker build --rm -t $USERNAME/atomicapp-run .

#doesn't really make sense to run it
#test
#docker run -it --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run /bin/bash
#run
#docker run -dt --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run
#
