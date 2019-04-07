#!/bin/bash

if [ -f /home/runner/mido/output/arch/arm64/boot/"Image.gz-dtb" ]; then
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
MESSAGE="✅ Build: ${VERSION} completed in: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE"
else
echo "$(tput setaf 1) Build Failed. $(tput sgr 0)"
MESSAGE="❌ Build FAILED: @penglezos."
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE"
fi