#!/bin/bash

MODEL_NAME="$1"
CSV_FILE="$2"
JSON_OUTPUT_FILE="$3"

is_first_line=true

echo "[" > "$JSON_OUTPUT_FILE"

while IFS= read -r line
do
  if $is_first_line; then
    is_first_line=false
    continue
  fi

  line=$(echo "$line" | awk '{$1=$1};1')

  if [[ ! -z $line ]]; then
    echo "{ \"model\": \"$MODEL_NAME\", \"model_id\": $line }," >> "$JSON_OUTPUT_FILE"
  fi
done < "$CSV_FILE"

sed -i '$ s/,$//' "$JSON_OUTPUT_FILE"

echo "]" >> "$JSON_OUTPUT_FILE"

echo "Transformação concluída. O arquivo transformado está em $JSON_OUTPUT_FILE"