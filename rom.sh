#!/bin/bash
repo init -u git://github.com/LineageOS/android.git -b lineage-17.1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
git clone https://github.com/raphael-development/android_device_xiaomi_raphael -b lineage-17.1 device/xiaomi/raphael
git clone https://github.com/raphael-development/proprietary_vendor_xiaomi vendor/xiaomi/

. build/envsetup.sh
lunch lineage_raphael-userdebug
export LC_ALL=C
make bacon -j$(nproc --all)
