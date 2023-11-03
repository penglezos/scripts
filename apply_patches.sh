#!/bin/bash
#
# Copyright (C) 2023 penglezos <panagiotisegl@gmail.com>
#
# SPDX-License-Identifier: Apache-2.0
#

PATCHES_PATH=$PWD/build/patches

for project_name in $(cd "${PATCHES_PATH}"; echo */); do
        project_path="$(tr _ / <<<$project_name)"

        cd ${project_path}
        git am "${PATCHES_PATH}"/${project_name}/*.patch
        git am --abort &> /dev/null
done