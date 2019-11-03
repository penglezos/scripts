#!/bin/bash

repo init -u git://github.com/LineageOS/android.git -b lineage-16.0
repo sync -f --force-sync --no-tags --no-clone-bundle
git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git packages/resources/devicesettings

git clone https://github.com/TheScarastic/android_device_xiaomi_raphael.git -b lineage-16.0 device/xiaomi/raphael
git clone https://github.com/TheScarastic/proprietary_vendor_xiaomi.git -b lineage-16.0 vendor/xiaomi

source build/envsetup.sh
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 50G
lunch lineage_raphael-userdebug
mka installclean
make bacon -j$(nproc --all)
