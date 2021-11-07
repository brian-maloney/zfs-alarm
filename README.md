# zfs-alarm

## Build the container

```
docker build -t aurutils aurutils
```

## Build ZFS for Arch Linux ARM

```
docker run -v "${PWD}:/zfs-alarm:ro" -v "${PWD}/output:/output:rw" --rm aurutils /zfs-alarm/buildzfs.sh
```
