. lib/file_exists.sh

LINUX_VER=$(docker run --platform linux/amd64 --rm archlinux /bin/bash -c 'echo -e "[core]\nServer = http://mirror.archlinuxarm.org/aarch64/core" > /tmp/pacman-alarm.conf && pacman --config /tmp/pacman-alarm.conf --arch aarch64 -Sys "^linux-aarch64$" | grep core/linux-aarch64 | cut -f 2 -d " "')

git clone https://aur.archlinux.org/zfs-linux.git
pushd zfs-linux
sed -i -e '/^arch=/s/)/ "aarch64")/' PKGBUILD
sed -i -e "/^_kernelver=/s/=.*/=\"$LINUX_VER\"/" PKGBUILD
sed -i -e '/^_extramodules=/s/"$/-ARCH"/' PKGBUILD
file_exists
FILE_EXISTS=$?
popd

rm -rf zfs-linux

if [[ "$FILE_EXISTS" -eq 0 ]]
then
    echo "ZFS package exists, exiting with non-zero code so we don't build"
    exit 255
else
    echo "ZFS package does not exist, we need to build"
fi
