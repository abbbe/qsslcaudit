#!/bin/sh -xe

# Install dependencies necessary to build QSSLCAUDIT from sources

usage() {
	echo "Usage: $0 MODE IMAGE" 2>&1
	echo "	MODE = (safe|unsafe)" 2>&1
	echo "	IMAGE = (ubuntu:xenial|ubuntu:bionic)" 2>&1
	exit 1
}

[ $# -eq 2 ] || usage
MODE=$1
IMAGE=$2
BASEDIR=`dirname $0`
[ "$MODE" = "safe" -o "$MODE" = "unsafe" ] || usage

apt-get update

if [ "$IMAGE" = "ubuntu:xenial" ] ; then
        # ubuntu16.04"
	apt-get install -y cmake qtbase5-dev libgnutls-dev
	[ "$MODE" = "safe" ] && apt-get install -y libssl-dev
elif [ "$IMAGE" = "ubuntu:bionic" ] ; then
        # ubuntu18.04"
	apt-get install -y cmake qtbase5-dev g++ libgnutls28-dev
	[ "$MODE" = "safe" ] && apt-get install -y libssl1.0-dev
else
        echo "ERROR: Unsupported image '$IMAGE'" >&2
        exit 1
fi

if [ "$MODE" = "unsafe" ] ; then
	$BASEDIR/install-unsafe-openssl.sh $IMAGE
else
	true
fi
