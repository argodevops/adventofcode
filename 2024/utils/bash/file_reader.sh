#!/bin/bash

read_file() {
    local file_path="$1"
    local lines=()

    if [[ -f "$file_path" ]]; then
        while IFS= read -r line; do
            lines+=("$line")
        done < "$file_path"
    else
        echo "Error: File '$file_path' not found."
    fi

    echo "${lines[@]}"
}
