#!/bin/sh

if [ -z "$1" ]; then
  echo "Missing SBT_VERSION."
  echo "Usage: build.sh 0.13.13"
  exit 1
fi

SBT_VERSION=$1

docker build --build-arg SBT_VERSION=$SBT_VERSION -t fravega/alpine-sbt:latest -t fravega/alpine-sbt:$1 .

docker push fravega/alpine-sbt:$SBT_VERSION
docker push fravega/alpine-sbt:latest