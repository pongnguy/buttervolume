#!/bin/bash

# Usage: start.sh image volume
IMAGE=$1
VOLUME=$2

if [ -z "$IMAGE" ]
then
      echo "\$IMAGE is empty"
      exit 1
fi

if [ -z "$VOLUME" ]
then
      echo "\$VOLUME is empty"
      exit 1
fi

CONTAINER_ID=$(docker create $IMAGE)
SUBVOLUME_ID=$(cat /var/lib/docker/image/btrfs/layerdb/mounts/$CONTAINER_ID/mount-id)
DIRECTORY="/var/lib/docker/btrfs/subvolumes/$SUBVOLUME_ID"
mkdir -p $DIRECTORY/volume-data
# in case local volume directory not created yet
mkdir -p volumes/$VOLUME
mount --bind $DIRECTORY/volume-data volumes/$VOLUME
#mount -t btrfs -o loop /var/lib/docker/btrfs/subvolumes/$(sudo cat "/var/lib/docker/image/btrfs/layerdb/mounts/$(docker create $IMAGE)/mount-id") volumes/$VOLUME