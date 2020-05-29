#!/bin/bash
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=${HOME}/tools/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=${HOME}/tools/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=${HOME}/tools/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=${HOME}/tools/clang/lib64:$LD_LIBRARY_PATH
KERNEL_DIR=`pwd`
OUT=$KERNEL_DIR/out
make O=out CC=clang raphael_defconfig
make O=out CC=clang -j$(nproc --all)
