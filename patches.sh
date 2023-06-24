#!/bin/bash

# android_build
cd build/core
git fetch https://github.com/EnglezosAOSP/android_build/
git cherry-pick 5e9b696
cd ../../