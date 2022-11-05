#!/bin/bash
#
# Copyright (C) 2019-2022 penglezos <panagiotisegl@gmail.com    >
#
# Android Build script 
#

echo -e "==============================================="
echo    "         Android Build script                  "
echo -e "==============================================="
echo -e
echo -e "Available options:\n1.Sync ROM\n2.Pick gerrit changes\n3.Sync device trees\n4.Build ROM\n5.Build Kernel"
read -p "Your choice: " num
case $num in 
    1|2|3|4|5)
esac

if [ $num = '1' ]; then
    repo init -u https://github.com/LineageOS/android.git -b lineage-20.0
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    
    elif [ $num = '2' ]; then
    source build/envsetup.sh
    repopick 342236
    repopick 343780
    repopick 343784
    
    elif [ $num = '3' ]; then
    rm -rf device/xiaomi/
    rm -rf vendor/xiaomi/
    rm -rf kernel/xiaomi/
    git clone https://github.com/penglezos/device_xiaomi_raphael device/xiaomi/raphael
    git clone https://github.com/penglezos/vendor_xiaomi_raphael vendor/xiaomi/raphael
    git clone https://github.com/penglezos/kernel_xiaomi_raphael kernel/xiaomi/raphael
    
    elif [ $num = '4' ]; then
    #ccache -M 50G
    export USE_CCACHE=1
    #export CCACHE_EXEC=$(command -v ccache)
    export LC_ALL=C
    #export SELINUX_IGNORE_NEVERALLOWS=true
    source build/envsetup.sh
    lunch lineage_raphael-userdebug
    make bacon
    
    elif [ $num = '5' ]; then
    source build/envsetup.sh
    lunch lineage_raphael-userdebug
    make bootimage
    
    else echo "Invalid input, aborting!"
fi
