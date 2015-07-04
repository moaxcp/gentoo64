#!/bin/bash
set -e
if [[ -z $STAGE3 ]]
then
  echo "STAGE3 environment variable must be set to a timestamp."
  exit 1
fi

echo "current directory"
pwd
ls -l

echo "scripts set to $SCRIPTS"

chmod -R +x *

echo "directory"
ls -l .

echo "files directory"
ls -l "files"

echo "prepare directory"
ls -l "prepare"

echo "install directory"
ls -l "install"

for script in prepare/*.sh
do
  echo "running $script"
  $script
done

install.sh

cp -r install /mnt/gentoo/root
cp install.sh /mnt/gentoo/root
chroot /mnt/gentoo /root/install.sh

echo "provision.sh complete"
