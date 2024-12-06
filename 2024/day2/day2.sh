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

    increasing=true
    decreasing=true
    valid_difference=true

    prev_num=${numbers[0]}

    for (( i = 1; i < ${#numbers[@]}; i++ )); do
        num=${numbers[i]}
        
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
        echo "The row is safe"
        (( safe_report_count++ ))
    else
        echo "The row is not safe"
    fi

done < "$input_file"

echo "Safe report count: $safe_report_count"
