# Notes

## Writable layer in container
The subvolume mount of the writable layer of the container is located at:
/var/lib/docker/image/btrfs/layerdb/mounts/{container-id}/mount-id
Which is located at /var/lib/docker/btrfs/

```bash
IMAGE=ubuntu
cd /var/lib/docker/btrfs/subvolumes/$(cat "/var/lib/docker/image/btrfs/layerdb/mounts/$(docker create $IMAGE)/mount-id")
```

## TODO 
Add in support to pass in version when creating volume.  Volumes are specified by name.


/VolumeDriver.Create
Request:

{
    "Name": "volume_name",
    "Opts": {}
}
Instruct the plugin that the user wants to create a volume, given a user specified volume name. The plugin does not need to actually manifest the volume on the filesystem yet (until Mount is called). Opts is a map of driver specific options passed through from the user request.

/VolumeDriver.Mount
Request:

{
    "Name": "volume_name",
    "ID": "b87d7442095999a92b65b3d9691e697b61713829cc0ffd1bb72e4ccd51aa4d6c"
}

Docker requires the plugin to provide a volume, given a user specified volume name. Mount is called once per container start. If the same volume_name is requested more than once, the plugin may need to keep track of each new mount request and provision at the first mount request and deprovision at the last corresponding unmount request.
