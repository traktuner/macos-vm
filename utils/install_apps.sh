#!/bin/bash -e -o pipefail

#continue on error
set +e

for SCRIPT in ./core/*
do
if [ -f $SCRIPT -a -x $SCRIPT ]
then
$SCRIPT
else
sh $SCRIPT
fi
done