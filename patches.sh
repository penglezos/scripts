#!/bin/bash

# android_build
cd build
git fetch https://github.com/EnglezosAOSP/android_build/
cd core
git cherry-pick 5e9b696
cd ../../