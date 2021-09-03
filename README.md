# zfs-alarm

## Build the container

```
docker build -t zfs-alarm .
```

## Build ZFS for Arch Linux ARM

```
docker run -v "${PWD}:/aurutils" -v "${PWD}/output:/output:rw" --rm zfs-alarm /aurutils/buildzfs.sh
```
