#!/bin/bash -e -o pipefail

#"$VNC_PASSWORD" "$VNC_USER_PASSWORD"

#continue on error
set +e

VNC_PASSWORD=$1

for SCRIPT in ./config/*
do
if [ -f $SCRIPT -a -x $SCRIPT ]
then
$SCRIPT "$VNC_PASSWORD"
else
sh $SCRIPT "$VNC_PASSWORD"
fi
done