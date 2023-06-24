#!/bin/bash

# android_build
cd build/core
git fetch https://github.com/EnglezosAOSP/android_build/
git cherry-pick 5e9b6967c5a461081e39fb2fa740ce850cc628ef
cd ../../

# build_soong
cd build/soong
git fetch https://github.com/EnglezosAOSP/android_build_soong/
git cherry-pick 7e07da046df0f883ee6082bdbbd8c1aa91faf222
git cherry-pick 957fe8a3d7d30192697d06ea9fba0f66bda08e42
git cherry-pick 82153b85ef8b015ee6f4fdfd5742f0ec0239cec5
cd ../../

# vendor_lineage
cd vendor/lineage
git fetch https://github.com/EnglezosAOSP/android_vendor_lineage
git cherry-pick 25535f0fc42644a8f4a95220eb97745899a6e95b
git cherry-pick 25535f0fc42644a8f4a95220eb97745899a6e95b
cd ../../

# frameworks_base
cd frameworks/base
git fetch https://github.com/EnglezosAOSP/android_frameworks_base
git cherry-pick b461c338a0c13805beb275ef84ed59bcaf560042
git cherry-pick 5f32ff0bb2da41638eec8906b4365b92a56a14a7
git cherry-pick e637d8d3071ef5712bddf3da15ecf4bb8932baf4
git cherry-pick b6333dc4eab82c67df1e9cc2d705eda8fe7da1ed
git cherry-pick 0cf7d919c42d01fbeeac02c1bbc9e77cf64ab4d4
git cherry-pick 23ce7b86cb05a903b73241eeaeadbd0b2daa89a8
git cherry-pick 00ee470bd57dd30b699cbd69f030244045b09066
git cherry-pick 001bdab6beddf462a0bbf58972ea67ca78829d7c
git cherry-pick b8e4dfae3cb7d365f64260968d4182f030812d51
git cherry-pick babe8ef6af2965197ab91075472f6e4ff2451bce
git cherry-pick 49cc70c6bf955a7501bcd187d5d8de9326e1da8f
git cherry-pick a859702975357b73aa4fbddf4d8ea705fe387fd2
git cherry-pick 6d509e925019951d93f6a87fb6eee9b86608435a
git cherry-pick 585bddfe28f2a9ff27655274fe7fe7f1be230f6e
git cherry-pick 2c02c4c4e7e25b759233fcf2bb0ec21a594f82a7
cd ../../

# Settings
cd packages/apps/Settings
git fetch https://github.com/EnglezosAOSP/android_packages_apps_Settings
git cherry-pick 74cb3d86162f83dbef7258e2bf4255f21da90cba
cd ../../../

# Connectivity
cd packages/modules/Connectivity
git fetch https://github.com/EnglezosAOSP/android_packages_modules_Connectivity/
git cherry-pick 1113fdb6eee9fbac29f479a805c366465667f65c
cd ../../../

# Wifi
cd packages/modules/Wifi
git fetch https://github.com/EnglezosAOSP/android_packages_modules_Wifi
git cherry-pick 6d8e04ac2aa22b6b8eff5294958a4bc17ef57791
git cherry-pick f3453559a9d93f970f542438094c7fd1da859a8f
cd ../../../

# system_core
cd system/core
git fetch https://github.com/EnglezosAOSP/android_system_core
git cherry-pick a7d5e6ef3735ae46d0dbef69b2820d198069f4d2
git cherry-pick b023047c5d6ce65b02ce378d585d84df1afa63ae
cd ../../../