#!/bin/sh 

set -e

# called by uscan with '--upstream-version' <version> <file>
echo "version $2"
package=`dpkg-parsechangelog | sed -n 's/^Source: //p'`
debian_version=`dpkg-parsechangelog | sed -ne 's/^Version: \(.*+dfsg\)-.*/\1/p'`
TAR=../"$package"_${debian_version}.orig.tar.gz
DIR=$package-${debian_version}.orig

# clean up the upstream tarball
unzip -d $DIR $3
GZIP=--best tar -c -z -f $TAR --exclude 'lib/*'  --exclude 'docs/api/*' $DIR
rm -rf $3 ./$DIR
