#!/bin/bash

function sync_rom {
	repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1
	repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
}

function repo_pick {
    source build/envsetup.sh
    repopick -t twelve-launcher3-hidden
}

function sync_device {
	rm -rf device/xiaomi/
	rm -rf vendor/xiaomi/
	rm -rf kernel/xiaomi/
	git clone https://github.com/penglezos/device_xiaomi_raphael device/xiaomi/raphael
	git clone https://github.com/penglezos/vendor_xiaomi_raphael vendor/xiaomi/raphael
	git clone https://github.com/penglezos/kernel_xiaomi_raphael kernel/xiaomi/raphael
}

function build {
	ccache -M 50G
	export USE_CCACHE=1
	export CCACHE_EXEC=$(command -v ccache)
	export LC_ALL=C
	export ARROW_GAPPS=true
	export SELINUX_IGNORE_NEVERALLOWS=true
	source build/envsetup.sh
	lunch arrow_raphael-userdebug
	make bacon
}

echo "Android ROM build script"
echo

while read -p "Do you want to sync rom (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		sync_rom
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

while read -p "Do you want to pick changes (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		repo_pick
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
