#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

# Function to find payload offset
findPayloadOffset() {
    build=$1
    info=$(zipdetails "$build")
    foundBin=0
    while IFS= read -r line; do
        if [[ $foundBin == 1 ]]; then
            echo "$line" | grep -q "PAYLOAD"
            res=$?
            if [[ $res == 0 ]]; then
                hexNum=$(echo "$line" | cut -d ' ' -f1)
                echo $(( 16#$hexNum ))
                break
            fi
            continue
        fi
        echo "$line" | grep -q "payload.bin"
        res=$?
        [[ $res == 0 ]] && foundBin=1
    done <<< "$info"
}

# Check if file is provided
if ! [ "$1" ]; then
    echo -e "${RED}No file provided${NC}"
    if ! return 0 &> /dev/null; then
        exit 0
    fi
fi

file_path=$1
file_dir=$(dirname "$file_path")
file_name=$(basename "$file_path")
md5_hash=$(md5sum "$file_path" | cut -d' ' -f1)
device_code=$(echo "$file_name" | cut -d'-' -f2)
version=$(echo "$file_name" | cut -d'-' -f1 | cut -d'_' -f2)

# Set base URL
BASE_URL="https://downloads.sourceforge.net/project/project-cherta/${version}/${device_code}/"

# Check if file exists
if ! [ -f "$file_path" ]; then
    echo -e "${RED}File does not exist${NC}"
    if ! return 0 &> /dev/null; then
        exit 0
    fi
fi

echo -e "${GREEN}Generating JSON file: ${YELLOW}${output_filename}${NC}"

# Extract payload properties if available
isPayload=0
[ -f payload_properties.txt ] && rm payload_properties.txt
if unzip "$file_path" payload_properties.txt; then
    isPayload=1
    offset=$(findPayloadOffset "$file_path")
    keyPairs=$(cat payload_properties.txt | sed "s/=/\": \"/" | sed 's/^/            \"/' | sed 's/$/\"\,/')
    keyPairs=${keyPairs%?}
fi

datetime=$(date +%s)

# Build JSON
{
    echo "{"
    echo "  \"response\": ["
    echo "    {"
    echo "      \"datetime\": ${datetime},"
    echo "      \"filename\": \"${file_name}\","
    echo "      \"url\": \"${BASE_URL}${file_name}\","
    echo -n "      \"md5\": \"${md5_hash}\""
} > "${file_dir}/${output_filename}"

# Add payload section if present
if [[ $isPayload == 1 ]]; then
    {
        echo ","
        echo "      \"payload\": ["
        echo "        {"
        echo "          \"offset\": ${offset},"
        echo "${keyPairs}"
        echo "        }"
        echo "      ]"
    } >> "${file_dir}/${output_filename}"
fi

# Close JSON structure
{
    echo "    }"
    echo "  ]"
    echo "}"
} >> "${file_dir}/${output_filename}"

echo -e "${GREEN}OTA JSON generated and saved as ${YELLOW}${output_filename}${NC}"
