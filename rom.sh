#!/bin/bash
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
git clone https://github.com/penglezos/device_xiaomi_raphael device/xiaomi/raphael
git clone https://github.com/raphael-development/proprietary_vendor_xiaomi vendor/xiaomi/raphael


ccache -M 50G
export USE_CCACHE=1
export CCACHE_EXEC=$(command -v ccache)
. build/envsetup.sh
lunch lineage_raphael-userdebug
export LC_ALL=C
make bacon -j$(nproc --all)
