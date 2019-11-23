#!/bin/bash

repo init -u git://github.com/LineageOS/android.git -b lineage-16.0
repo sync -f --force-sync --no-tags --no-clone-bundle
git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git packages/resources/devicesettings

git clone https://github.com/raphael-development/android_device_xiaomi_raphael -b lineage-17.0 device/xiaomi/raphael
git clone https://github.com/raphael-development/proprietary_vendor_xiaomi -b lineage-17.0 vendor/xiaomi

source build/envsetup.sh
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 50G
lunch lineage_raphael-userdebug
mka installclean
make bacon -j$(nproc --all)
