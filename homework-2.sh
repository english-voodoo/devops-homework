#!/bin/bash

REMOTE_SRV_IP="172.31.44.196"
REMOTE_DIR="/home/ubuntu/test2"
REMOTE_USER="ubuntu"

LOCAL_DIR="/home/ubuntu/test"

FILENAME="file-`date +%F_%H.%M.%S`.txt"

echo "Starting"
cd $LOCAL_DIR

echo "Creating $FILENAME"
touch $FILENAME
echo "Hello World!" > $FILENAME

echo "Copying $FILENAME to $REMOTE_SRV_IP:$REMOTE_DIR"
scp $FILENAME $REMOTE_USER@$REMOTE_SRV_IP:$REMOTE_DIR

echo "Deleting old files"
ssh -i ~/.ssh/id_rsa $REMOTE_USER@$REMOTE_SRV_IP "cd $REMOTE_DIR; find . -maxdepth 1 -mtime +7 -type f -exec rm -f {} \;"

echo "Finished"
