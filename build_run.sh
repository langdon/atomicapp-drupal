#!/bin/bash
echo "Note: you may need to add your docker-registry to /etc/sysconfig/docker "
echo "(on CentOS/RHEL/Fedora) for this to push to the registries correctly"

if [ -z "$USERNAME" ]; then
    echo "setting USERNAME to " `whoami`
    USERNAME=`whoami`
fi

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
docker tag -f $USERNAME/mariadb $DOCKER_REGISTRY/mariadb
docker push $DOCKER_REGISTRY/mariadb
#docker rmi $USERNAME/maria
echo "build complete: mariadb"
cd $BASE_DIR

#build mariadb-app docker container
echo "building mariadb-app"
cd drupal-app/graph/mariadb-app
docker build -t $USERNAME/mariadb-app --file="docker-artifacts/Dockerfile" .
#docker build --no-cache -t $USERNAME/mariadb-app --file="docker-artifacts/Dockerfile" .
docker tag -f $USERNAME/mariadb-app $DOCKER_REGISTRY/mariadb-app
docker push $DOCKER_REGISTRY/mariadb-app
#docker rmi $USERNAME/mariadb-app
echo "build complete: mariadb-app"
cd $BASE_DIR

#build drupal docker container
echo "building drupal"
cd drupal-app/graph/drupal
docker build -t $USERNAME/drupal --file="Dockerfile" .
docker tag -f $USERNAME/drupal $DOCKER_REGISTRY/drupal
docker push $DOCKER_REGISTRY/drupal
echo "build complete: drupal"
cd $BASE_DIR

#build drupal-app docker container
echo "building drupal-app"
cd drupal-app/
docker build -t $USERNAME/drupal-app --file="docker-artifacts/Dockerfile" .
docker tag -f $USERNAME/drupal-app $DOCKER_REGISTRY/drupal-app
docker push $DOCKER_REGISTRY/drupal-app
echo "build complete: drupal-app"
cd $BASE_DIR

#echo docker build --rm -t $USERNAME/atomicapp-run .
#docker build --rm -t $USERNAME/atomicapp-run .

#doesn't really make sense to run it
#test
#docker run -it --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run /bin/bash
#run
#docker run -dt --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run
#
