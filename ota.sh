#
# Copyright (C) 2019-2022 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the 
# License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#$1=TARGET_DEVICE, $2=PRODUCT_OUT, $3=LINEAGE_VERSION
existingOTAjson=./vendor/OTA/$1.json
output=./vendor/OTA/$1.json

if [ -f $existingOTAjson ]; then
	#get data from already existing device json
	#there might be a better way to parse json yet here we try without adding more dependencies like jq
	filename=$3
	version=`echo "$3" | cut -d'-' -f2`
	url="https://sourceforge.net/projects/voltage-os/files/'$device'/'$filename'/download"
	buildprop=$2/system/build.prop
	linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
	datetime=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
	id=`md5sum "$2/$3" | cut -d' ' -f1`
	size=`stat -c "%s" "$2/$3"`

	#cleanup old file
	if [ -f $output ]; then
        	rm $output
	fi

	echo '{
	"response": [
		{
			"filename": "'$filename'",
			"url": "'url'",
			"datetime": '$datetime',
			"id": "'$id'",
			"size": '$size',
			"version": "'$version'",
		}
	]
}' >> $output

        echo "JSON file data for OTA support:"
else
	#if not already supported, create dummy file with info in it on how to
	echo 'There is no official support for this device yet' >> $output;
fi

cat $output
echo ""