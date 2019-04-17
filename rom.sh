#!/bin/bash
#
# Copyright © 2019, "penglezos" <panagiotisegl@gmail.com>
# Android ROM build script
# Thanks to Ali Hasan and Barny
#

tput reset
echo -e "==============================================="
echo    "         Compiling Englezos ROM                "
echo -e "==============================================="


# Syncing
echo -e "Syncing from sources."
repo init -u git://github.com/LineageOS/android.git -b lineage-16.0
repo sync -f --force-sync --no-tags --no-clone-bundle
echo -e "Syncing finished."

# Initialize device trees
echo -e "Initializing device: (device tree, vendor, kernel)."
git clone https://github.com/penglezos/android_device_xiaomi_mido -b lineage-16.0 device/xiaomi/mido
git clone https://github.com/zeelog/proprietary_vendor_xiaomi -b lineage-16.0 vendor/xiaomi
git clone https://github.com/penglezos/android_kernel_xiaomi_msm8953 -b pie kernel/xiaomi/msm8953
echo -e "Finished successfully."

# Compiling
source build/envsetup.sh
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 50G
lunch lineage_mido-userdebug
mka installclean
make bacon -j$(nproc --all)
