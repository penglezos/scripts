#!/bin/bash
#
# Copyright (C) 2019-2023 penglezos <panagiotisegl@gmail.com>
#
# Android Build script 
#

device='raphael'
build_type='userdebug'

sync () {
    repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
    rm -rf .repo/local_manifests && mkdir -p .repo/local_manifests
    curl https://raw.githubusercontent.com/penglezos/android/main/lineage-21-raphael.xml -o .repo/local_manifests/lineage-21-raphael.xml
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
}

setup () {
    sudo swapoff --all
    sudo bash -c "echo 32G > /sys/block/zram0/disksize"
    sudo mkswap --label zram0 /dev/zram0
    sudo swapon --priority 32767 /dev/zram0
    export CCACHE_EXEC=$(command -v ccache)
    export CCACHE_DIR=$(pwd)/.ccache
    export USE_CCACHE=1
    ccache -M 50G
    export LC_ALL=C
}

build () {
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make bacon
}

kernel () {
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make bootimage
}

recovery () {
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make recoveryimage
}

echo -e "\n1.Sync sources\n2.Apply patches\n3.Setup build enviroment\n4.Build ROM\n5.Build Kernel\n6.Build recovery"
echo -e
read -p "Your choice: " num
case $num in 
    1|2|3|4|5|6)
esac

if [ $num = '1' ]; then
    sync
elif [ $num = '2' ]; then
    chmod +x apply_patches.sh
    ./apply_patches.sh
elif [ $num = '3' ]; then
    setup
elif [ $num = '4' ]; then
    build
elif [ $num = '5' ]; then
    kernel
elif [ $num = '6' ]; then
    recovery
else echo "Invalid input, aborting!"
fi
