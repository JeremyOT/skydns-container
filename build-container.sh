#!/bin/sh
docker build -t skydns-build - < ./build-container/Dockerfile
docker images
echo "Starting container"
CID=$(docker run -d skydns-build)
echo "Started $CID. Copying skydns to local directory"
docker cp $CID:/usr/local/skydns/skydns .
echo "Removing $CID."
docker rm -f $CID
echo "Building production container."
docker build -t skydns .
