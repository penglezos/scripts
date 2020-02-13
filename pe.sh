#!/bin/bash

# Sync ROM Sources
while read -p "Do you want to sync (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		repo init -u https://github.com/PixelExperience/manifest -b ten
        repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
		echo
		echo "Synced successfully!"
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

# Sync with my changes
while read -p "Do you want to sync your changes (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		rm -rf device/xiaomi/
		git clone https://github.com/penglezos/device_xiaomi_raphael -b wip device/xiaomi/raphael
		echo
		echo "Synced successfully!"
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

# Compile
while read -p "Do you want to compile (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		. build/envsetup.sh
        lunch aosp_raphael-userdebug
        make bacon -j$(nproc --all)
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done
