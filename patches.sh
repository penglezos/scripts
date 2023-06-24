#!/bin/bash

# android_build
cd build/core
git fetch https://github.com/EnglezosAOSP/android_build/
git cherry-pick 5e9b696
cd ../../

# build_soong
cd build/soong
git fetch https://github.com/EnglezosAOSP/android_build_soong/
git cherry-pick 7e07da0^..82153b8
cd ../../

# lineage-sdk
cd lineage-sdk
git fetch https://github.com/EnglezosAOSP/android_lineage-sdk
git cherry-pick bb78702
cd ../../