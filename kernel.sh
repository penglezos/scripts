#!/bin/bash
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=${HOME}/tools/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=${HOME}/tools/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=${HOME}/tools/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=${HOME}/tools/clang/lib64:$LD_LIBRARY_PATH
LC_ALL=C date +%Y-%m-%d	
date=`date +"%Y%m%d-%H%M"`	
BUILD_START=$(date +"%s")
VERSION='0.'
KERNEL_DIR=`pwd`
REPACK_DIR=$KERNEL_DIR/AnyKernel3
OUT=$KERNEL_DIR/out

rm -rf out
make O=out CC=clang raphael_defconfig
make O=out CC=clang -j$(nproc --all)

cd $REPACK_DIR
cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb $REPACK_DIR/
FINAL_ZIP="EnglezosKernel-raphael-${VERSION}.zip"
zip -r9 "${FINAL_ZIP}" *
cp *.zip $OUT
rm *.zip
cd $KERNEL_DIR
rm AnyKernel3/Image.gz-dtb

BUILD_END=$(date +"%s")	
DIFF=$(($BUILD_END - $BUILD_START))	
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
