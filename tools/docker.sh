#!/bin/sh -xe

# Build and run QSSLCAUDIT in local docker

usage() {
        echo "Usage: $0 MODE IMAGE" 2>&1
        echo "  MODE = (safe|unsafe)" 2>&1
        echo "  IMAGE = (ubuntu:xenial|ubuntu:bionic)" 2>&1
        exit 1
}

[ $# -eq 2 ] || usage
MODE=$1
IMAGE=$2
BASEDIR=`dirname $0`
[ "$MODE" = "safe" -o "$MODE" = "unsafe" ] || usage

NAME=qs-${MODE}-${IMAGE}

docker build -t $NAME -f Dockerfile.$NAME .
docker run --rm -it $NAME
