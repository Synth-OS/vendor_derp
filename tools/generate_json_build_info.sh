#!/bin/bash
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m"
if [ "$1" ]; then
    echo "Generating .json"
    file_path=$1
    file_name=$(basename $file_path)
    device_name=$(echo $file_name | cut -d "-" -f 5)
    if [ -f $file_path ]; then
        if [[ $file_name == *"Synthetic"* ]]; then # only generate for official builds
            file_size=$(stat -c%s $file_path)
            md5=$(cat "$file_path.md5sum" | cut -d' ' -f1)
            currenttime=$(date +%s)
            datetime=$(($currenttime - 86400))
            id=$(sha256sum $file_path | awk '{ print $1 }')
            link="https://sourceforge.net/projects/derpfest/files/${device_name}/${file_name}/download"
            echo "{" > $file_path.json
            echo "  \"response\": [" >> $file_path.json
            echo "    {" >> $file_path.json
            echo "     \"datetime\": ${datetime}," >> $file_path.json
            echo "     \"filename\": \"${file_name}\"" >> $file_path.json
            echo "     \"id\": \"${id}\"" >> $file_path.json
            echo "     \"romtype\": \"Synthetic\"" >> $file_path.json
            echo "     \"size\": ${file_size}," >> $file_path.json
            echo "     \"url\": \"${link}\"," >> $file_path.json
            echo "     \"version\": \"11\"" >> $file_path.json
            echo "     \"product\": \"${SYNTH_VERSION_PRODUCT}\"" >> $file_path.json
            echo "     \"model\": \"${SYNTH_VERSION_MODEL}\"" >> $file_path.json
            echo "    }" >> $file_path.json
            echo "  ]" >> $file_path.json
            echo "}" >> $file_path.json
            mv "${file_path}.json" "out/target/product/${device_name}/${device_name}.json"
            echo -e "${GREEN}Done generating ${YELLOW}${device_name}.json${NC}"
        else
            echo -e "${YELLOW}Skipped generating json for a non-official build${NC}"
        fi
    fi
fi
