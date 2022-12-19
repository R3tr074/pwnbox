#!/bin/bash

yes | unminimize

dpkg --add-architecture i386

apt-get update && apt-get -y upgrade

apt-get install -y \
    sudo \
    apt-utils \
    locales \
    build-essential \
    gcc-multilib \
    g++-multilib \
    gdb \
    gdb-multiarch \
    python3-dev \
    python3-pip \
    ipython3 \
    man-db \
    manpages-posix \
    default-jdk \
    net-tools \
    nasm \
    cmake \
    rubygems \
    ruby-dev \
    vim \
    tmux \
    git \
    binwalk \
    strace \
    ltrace \
    autoconf \
    socat \
    netcat \
    nmap \
    wget \
    tcpdump \
    exiftool \
    squashfs-tools \
    unzip \
    upx-ucl \
    man-db \
    manpages-dev \
    libtool-bin \
    bison \
    gperf \
    libseccomp-dev \
    libini-config-dev \
    libssl-dev \
    libffi-dev \
    libc6-dbg \
    libglib2.0-dev \
    libc6:i386 \
    libc6-dbg:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    libc6-dev-i386

apt-get -y autoremove
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# locale-gen en_US.UTF-8
# update-locale

pip3 install r2pipe
pip3 install scapy
pip3 install python-constraint
pip3 install pycipher
pip3 install uncompyle6
pip3 install pipenv
pip3 install manticore[native]
pip3 install ropper
pip3 install meson
pip3 install ninja

python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools

python3 -m pip install xortool

git clone https://github.com/radareorg/radare2 /opt/radare2 && \
    cd /opt/radare2 && \
    ./sys/install.sh

git clone https://github.com/R3tr074/echeck /opt/echeck && \
    cd echeck && \
    make && mv build/linux/x86_64/release/echeck /usr/bin \
    ln -s /usr/bin/echeck /usr/bin/checksec

git clone https://github.com/0vercl0k/rp /opt/rp && \
    cd /opt/rp/src/build && \
    chmod u+x ./build-release.sh && ./build-release.sh

# install peda
git clone https://github.com/longld/peda.git /opt/peda

# install gef
git clone https://github.com/hugsy/gef.git /opt/gef

# install pwndbg
git clone https://github.com/pwndbg/pwndbg.git /opt/pwndbg && \
    cd /opt/pwndbg && \
    ./setup.sh

git clone https://github.com/seccomp/libseccomp.git /opt/libseccomp && \
    cd /opt/libseccomp && \
    ./autogen.sh && ./configure && make && make install

gem install one_gadget
gem install seccomp-tools

