sudo apt-get install -y ccache bc bash git-core gnupg build-essential zip curl make automake autogen autoconf autotools-dev libtool shtool python m4 gcc libtool zlib1g-dev dash
git clone https://github.com/penglezos/aarch64-linux-android-4.9
git clone https://github.com/penglezos/android_kernel_xiaomi_msm8953.git -b pie

make ARCH=arm64 clean O=output
make ARCH=arm64 mrproper O=output
make O=output ARCH=arm64 mido_defconfig
make -j4 O=output ARCH=arm64 CROSS_COMPILE=/home/runner/mido/aarch64-linux-android-4.9/bin/aarch64-linux-android-