#!/bin/sh -xe

# Install unsafe version of OpenSSL (both binaries and dev headers/libs), from binary packages

URL=https://github.com/gremwell/unsafeopenssl-pkg-debian/releases/download
VER=1.0.2i-2

IMAGE=$1
if [ x"$IMAGE" = x"ubuntu:xenial" ] ; then
	OS="ubuntu16.04"
elif [ x"$IMAGE" = x"ubuntu:bionic" ] ; then
	OS="ubuntu18.04"
else
	echo "ERROR: Unsupported image '$IMAGE'" >&2
	exit 1
fi

apt-get install -y wget

DEBS="libunsafessl1.0.2_${VER}_${OS}_amd64.deb libunsafessl-dev_${VER}_${OS}_amd64.deb openssl-unsafe_${VER}_${OS}_amd64.deb"
for deb in $DEBS ; do
	wget ${URL}/${VER}/$deb
	apt-get install -y ./$deb
	rm $deb
done

test -x `which openssl-unsafe`
