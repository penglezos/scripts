#!/bin/bash
#
# Copyright (C) 2019-2023 penglezos <panagiotisegl@gmail.com>
#
# Android Build script 
#

device='raphael'
build_type='userdebug'
date=`date +"%Y%m%d"`

echo -e "==============================================="
echo    "         Android Build script                  "
echo -e "==============================================="
echo -e
echo -e "Available options:\n1.Sync ROM\n2.Pick patches\n3.Set zram\n4.Build ROM\n5.Build Kernel\n6.Build recovery"
echo -e
read -p "Your choice: " num
case $num in 
    1|2|3|4|5|6)
esac

if [ $num = '1' ]; then
    repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs
    rm -rf .repo/local_manifests
    mkdir -p .repo/local_manifests
    curl https://raw.githubusercontent.com/penglezos/local_manifests/lineage-20/raphael.xml -o .repo/local_manifests/lineage.xml
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

    elif [ $num = '2' ]; then
    ./apply.sh

    elif [ $num = '3' ]; then
    sudo swapoff --all
    sudo bash -c "echo 32G > /sys/block/zram0/disksize"
    sudo mkswap --label zram0 /dev/zram0
    sudo swapon --priority 32767 /dev/zram0

    elif [ $num = '4' ]; then
    export CCACHE_EXEC=$(command -v ccache)
    export CCACHE_DIR=$(pwd)/.ccache
    export USE_CCACHE=1
    ccache -M 50G
    export LC_ALL=C
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make bacon
    
    elif [ $num = '5' ]; then
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make bootimage
    mv boot.img englezos-${date}-kernel-${device}.img

    elif [ $num = '6' ]; then
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make recoveryimage
    mv recovery.img lineage-20.0-${date}-recovery-${device}.img

    else echo "Invalid input, aborting!"
fi
