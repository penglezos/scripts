#!/bin/bash

export USERNAME=penglezos
export HOSTNAME=home

# Setup Git profile.
git config --global user.name "penglezos"
git config --global user.email "panagiotisegl@gmail.com"

function sync_rom {
	repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.0
	repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
}

function sync_device {
	rm -rf device/xiaomi/
	rm -rf vendor/xiaomi/
	rm -rf kernel/xiaomi/
	git clone https://github.com/EnglezosRaphael/device_xiaomi_raphael device/xiaomi/raphael
	git clone https://github.com/EnglezosRaphael/vendor_xiaomi_raphael vendor/xiaomi/raphael
	git clone https://github.com/EnglezosRaphael/kernel_xiaomi_raphael kernel/xiaomi/raphael
}

function build {
	ccache -M 50G
	export USE_CCACHE=1
	export CCACHE_EXEC=$(command -v ccache)
	export LC_ALL=C
	export ARROW_GAPPS=true
	source build/envsetup.sh
	lunch arrow_raphael-userdebug
	make bacon -j16
}

echo "Android ROM build script"
echo

while read -p "Do you want to sync rom (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		sync_rom
		echo
		echo "All files are synced successfully."
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

echo

while read -p "Do you want to sync device trees (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		sync_device
		echo
		echo "All files are synced successfully."
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

echo

while read -p "Do you want to build ROM (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		build
		echo
		echo "ROM built successfully."
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
