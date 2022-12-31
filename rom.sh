#!/bin/bash
#
# Copyright (C) 2019-2023 penglezos <panagiotisegl@gmail.com>
#
# Android Build script 
#

device='raphael'

echo -e "==============================================="
echo    "         Android Build script                  "
echo -e "==============================================="
echo -e
echo -e "Available options:\n1.Sync ROM\n2.Pick patches\n3.Build ROM\n4.Build Kernel"
echo -e
read -p "Your choice: " num
case $num in 
    1|2|3|4)
esac

if [ $num = '1' ]; then
    repo init -u https://github.com/LineageOS/android.git -b lineage-20.0
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    
    elif [ $num = '2' ]; then
    ./apply.sh
    
    elif [ $num = '3' ]; then
    export CCACHE_EXEC=$(command -v ccache)
    export CCACHE_DIR=$(pwd)/.ccache
    export USE_CCACHE=1
    ccache -M 50G
    export LC_ALL=C
    source build/envsetup.sh
    lunch lineage_${device}-userdebug
    make bacon
    cp out/target/product/"${device}"/lineage-*-"${device}".zip ~/
    cp out/target/product/"${device}"/recovery.img ~/
    
    elif [ $num = '4' ]; then
    source build/envsetup.sh
    lunch lineage_${device}-userdebug
    make bootimage
    cp out/target/product/"${device}"/boot.img ~/

    else echo "Invalid input, aborting!"
fi
