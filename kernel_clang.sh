#!/bin/bash
rm .version

clear
echo -e "==============================================="
echo    "         Compiling Englezos Kernel             "
echo -e "==============================================="

export CLANG_PATH=/home/home/tools/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=/home/home/tools/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/home/tools/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=${HOME}/tools/clang/aosp/clang/lib64:$LD_LIBRARY_PATH
KERNEL_DIR=`pwd`

function make_kernel {
		echo
		make O=out CC=clang raphael_defconfig
		make O=out CC=clang -j$(grep -c ^processor /proc/cpuinfo)

}
DATE_START=$(date +"%s")

# Vars
DATE=`date +"%Y%m%d-%H%M"`
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=penglezos
export KBUILD_BUILD_HOST=box

echo

while read -p "Do you want to build?" dchoice
do
case "$dchoice" in
	y|Y )
		make_kernel
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

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo