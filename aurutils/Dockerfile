FROM --platform=linux/arm64/v8 lopsided/archlinux AS build

RUN pacman --noconfirm -Sy git signify jq pacutils devtools fakeroot binutils gcc make expect patch perl-json-xs
RUN useradd -m builder
RUN cd /home/builder && su builder -c '/usr/sbin/git clone https://aur.archlinux.org/aurutils.git'
RUN cd /home/builder/aurutils && su builder makepkg

FROM --platform=linux/arm64/v8 lopsided/archlinux
RUN mkdir /tmp/pkgs
COPY --from=build /home/builder/aurutils/*pkg* /tmp/pkgs/
RUN pacman --noconfirm -Sy shadow sudo signify rsync openssh fakeroot binutils gcc make diffutils gawk autoconf automake linux-aarch64 linux-aarch64-headers
RUN useradd -u 1000 -m builder && mkdir /home/builder/.ssh && chown builder:builder /home/builder/.ssh && chmod 700 /home/builder/.ssh && echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder
RUN pacman --noconfirm -U /tmp/pkgs/*pkg*
RUN rm -rf /tmp/pkgs && rm -rf /var/lib/pacman/sync/* && rm -rf /var/cache/pacman/pkg/*
COPY vond-aur.conf /tmp/vond-aur.conf
RUN cat /tmp/vond-aur.conf >> /etc/pacman.conf && rm /tmp/vond-aur.conf
USER 1000
WORKDIR /home/builder
