#!/bin/bash

# Setup Git profile.
git config --global user.name "penglezos"
git config --global user.email "panagiotisegl@gmail.com"

# Initialize LineageOS source code.
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Initialize device files.
git clone https://github.com/EnglezosRaphael/device_xiaomi_raphael device/xiaomi/raphael
git clone https://github.com/EnglezosRaphael/vendor_xiaomi_raphael vendor/xiaomi/raphael
git clone https://github.com/EnglezosRaphael/android_kernel_xiaomi_raphael kernel/xiaomi/raphael

# Set build enviroment and build.
ccache -M 50G
export USE_CCACHE=1
export CCACHE_EXEC=$(command -v ccache)
. build/envsetup.sh
lunch lineage_raphael-userdebug
export LC_ALL=C
make bacon
