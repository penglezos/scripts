#!/bin/bash
source build/envsetup.sh
repopick -t twelve-sepol # Sepolicy fixes
repopick -t twelve-sepol-up # More sepolicy fixes
