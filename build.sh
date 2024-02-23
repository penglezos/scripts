#!/bin/bash
#
# Copyright (C) 2019-2024 penglezos <panagiotisegl@gmail.com>
#
# Android Build script 
#

device='raphael'
build_type='userdebug'

sync () {
    repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
    rm -rf .repo/local_manifests && mkdir -p .repo/local_manifests
    curl https://raw.githubusercontent.com/penglezos/local_manifests/lineage-21/lineage-21-raphael.xml
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
}

zram () {
    sudo swapoff --all
    sudo bash -c "echo 32G > /sys/block/zram0/disksize"
    sudo mkswap --label zram0 /dev/zram0
    sudo swapon --priority 32767 /dev/zram0
}

patches () {
    . build/envsetup.sh
    croot
    
    PATCHES_PATH=$PWD/patches

    for project_name in $(cd "${PATCHES_PATH}"; echo */); do
        project_path="$(tr _ / <<<$project_name)"

        cd $(gettop)/${project_path}
        git am "${PATCHES_PATH}"/${project_name}/*.patch --no-gpg-sign
        git am --abort &> /dev/null
    done

    croot
}

build () {
    export CCACHE_EXEC=$(command -v ccache)
    export CCACHE_DIR=$(pwd)/.ccache
    export USE_CCACHE=1
    ccache -M 50G
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make bacon
}

kernel () {
    export CCACHE_EXEC=$(command -v ccache)
    export CCACHE_DIR=$(pwd)/.ccache
    export USE_CCACHE=1
    ccache -M 50G
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make bootimage
}

recovery () {
    export CCACHE_EXEC=$(command -v ccache)
    export CCACHE_DIR=$(pwd)/.ccache
    export USE_CCACHE=1
    ccache -M 50G
    source build/envsetup.sh
    lunch lineage_${device}-${build_type}
    make recoveryimage
}

echo -e "\n1.Sync sources\n2.Setup ZRAM\n3.Apply patches\n4.Build ROM\n5.Build kernel\n6.Build recovery"
echo -e
read -p "Your choice: " num
case $num in 
    1|2|3|4|5|6)
esac

if [ $num = '1' ]; then
    sync
elif [ $num = '2' ]; then
    zram
elif [ $num = '3' ]; then
    patches
elif [ $num = '4' ]; then
    build
elif [ $num = '5' ]; then
    kernel
elif [ $num = '6' ]; then
    recovery
else echo "Invalid input, aborting!"
fi
