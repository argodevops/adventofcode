#!/bin/bash
input_file="$1"

if [[ ! -f "$input_file" ]]; then
    echo "File $input_file not found!"
    exit 1
fi

safe_report_count=0

while IFS= read -r line; do
    numbers=($line)
    
    echo "Processing row: ${numbers[@]}"

    check_numbers() {
        echo "Check numbers: $@"
        local arr=("$@")
        local increasing=true
        local decreasing=true
        local valid_difference=true
        local prev_num=${arr[0]}

        for (( i = 1; i < ${#arr[@]}; i++ )); do
            local num=${arr[i]}
            
            if [[ $num -gt $prev_num ]]; then
                decreasing=false
            elif [[ $num -lt $prev_num ]]; then
                increasing=false
            fi

            diff=$(( num - prev_num ))
            if (( diff < -3 || diff > 3 || diff == 0 )); then
                valid_difference=false
            fi

            prev_num=$num
        done

        if ($increasing || $decreasing) && $valid_difference; then
            return 0 # safe
        else
            return 1 
        fi
    }

    row_safe=false

    check_numbers "${numbers[@]}"

    for (( skip_index = 0; skip_index < ${#numbers[@]}; skip_index++ )); do
        temp_numbers=("${numbers[@]:0:$skip_index}" "${numbers[@]:$((skip_index + 1))}")

        if check_numbers "${temp_numbers[@]}"; then
            row_safe=true
        fi
    done

    if $row_safe; then
        echo "The row is safe after skipping an element."
        (( safe_report_count++ ))
    else
        echo "The row is not safe even after skipping elements."
    fi

done < "$input_file"

echo "Safe report count: $safe_report_count"
