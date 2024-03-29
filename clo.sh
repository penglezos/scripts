#!/bin/bash
#
# Simple bash script to merge CLO tags to kernel
#
# Usage:
#       ./clo.sh $TAG
#

TAG=$1

if [ -z ${TAG+x} ]; then
    echo "Pass a valid argument"
fi

if [[ $2 = "-i" || $2 = "--initial" ]]; then
    INITIAL_MERGE=true
    echo "Initial merge"
fi

# msm-4.14 kernel
function merge_kernel() {
    echo "Merging msm-4.14 kernel"
    if ! git remote add msm-4.14 https://git.codelinaro.org/clo/la/kernel/msm-4.14; then
        git remote rm msm-4.14
        git remote add msm-4.14 https://git.codelinaro.org/clo/la/kernel/msm-4.14
    fi

    git fetch msm-4.14 $TAG
    git merge FETCH_HEAD
    git commit -m "msm-4.14: Merge tag '$TAG'"
    echo "Merged msm-4.14 kernel tag succesfully!"
}

# qcacld-3.0
function merge_qcacld() {
    echo "Merging qcacld-3.0"
    if ! git remote add qcacld-3.0 https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0; then
        git remote rm qcacld-3.0
        git remote add qcacld-3.0 https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0
    fi

    git fetch qcacld-3.0 $TAG

    if [[ ${INITIAL_MERGE} = true ]]; then
        git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
        git read-tree --prefix=drivers/staging/qcacld-3.0 -u FETCH_HEAD
        git commit -m "qcacld-3.0: Merge tag '$TAG'"
        echo "Merged qcacld-3.0 tag succesfully!"
    else
        if ! git merge -X subtree=drivers/staging/qcacld-3.0 FETCH_HEAD --log; then
            echo "Merge failed!" && exit 1
        else
            echo "Merged qcacld-3.0 tag sucessfully!"
        fi
    fi
}

# fw-api
function merge_fw_api() {
    echo "Merging fw-api"
    if ! git remote add fw-api https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api; then
        git remote rm fw-api
        git remote add fw-api https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api
    fi

    git fetch fw-api $TAG

    if [[ ${INITIAL_MERGE} = true ]]; then
        git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
        git read-tree --prefix=drivers/staging/fw-api -u FETCH_HEAD
        git commit -m "fw-api: Merge tag '$TAG'"
    echo "Merged fw-api tag succesfully!"
    else
        if ! git merge -X subtree=drivers/staging/fw-api FETCH_HEAD --log; then
            echo "Merge failed!" && exit 1
        else
            echo "Merged fw-api tag sucessfully!"
        fi
    fi
}

# qca-wifi-host-cmn
function merge_qca_wifi_host_cmn() {
    echo "Merging qca-wifi-host-cmn"
    if ! git remote add qca-wifi-host-cmn https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn; then
        git remote rm qca-wifi-host-cmn
        git remote add qca-wifi-host-cmn https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn
    fi

    git fetch qca-wifi-host-cmn $TAG

    if [[ ${INITIAL_MERGE} = true ]]; then
        git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
        git read-tree --prefix=drivers/staging/qca-wifi-host-cmn -u FETCH_HEAD
        git commit -m "qca-wifi-host-cmn: Merge tag '$TAG'"
    echo "Merged qca-wifi-host-cmn tag succesfully!"
    else
        if ! git merge -X subtree=drivers/staging/qca-wifi-host-cmn FETCH_HEAD --log; then
            echo "Merge failed!" && exit 1
        else
            echo "Merged qca-wifi-host-cmn tag sucessfully!"
        fi
    fi
}

# techpack-audio
function merge_techpack() {
    echo "Merging techpack-audio"
    if ! git remote add techpack https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel; then
        git remote rm techpack
        git remote add techpack https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel
    fi

    git fetch techpack $TAG

    if [[ ${INITIAL_MERGE} = true ]]; then
        git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
        git read-tree --prefix=techpack/audio -u FETCH_HEAD
        git commit -m "techpack-audio: Merge tag '$TAG'"
        echo "Merged techpack-audio tag succesfully!"
    else
        if ! git merge -X subtree=techpack/audio FETCH_HEAD --log; then
            echo "Merge failed!" && exit 1
        else
            echo "Merged techpack-audio tag sucessfully!"
        fi
    fi
}

# techpack-data
function merge_techpack_data() {
    echo "Merging techpack data"
    if ! git remote add techpack-data https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel; then
        git remote rm techpack-data
        git remote add techpack-data https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel
    fi

    git fetch techpack-data $TAG

    if [[ ${INITIAL_MERGE} = true ]]; then
        git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
        git read-tree --prefix=techpack/data -u FETCH_HEAD
        git commit -m "techpack-data: Merge tag '$TAG'"
        echo "Merged techpack-data tag succesfully!"
    else
        if ! git merge -X subtree=techpack/audio FETCH_HEAD --log; then
            echo "Merge failed!" && exit 1
        else
            echo "Merged techpack-data tag sucessfully!"
        fi
    fi
}

# initialize script
merge_kernel
merge_qcacld
merge_fw_api
merge_qca_wifi_host_cmn
merge_techpack
merge_techpack_data