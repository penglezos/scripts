#!/bin/bash

repo init -u https://github.com/PixelExperience/manifest -b ten
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_raphael-userdebug
make bacon -j$(nproc --all)
