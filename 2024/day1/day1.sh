#!/bin/bash
input_file="$1"

mapfile -t column1 < <(awk '{print $1}' "$input_file")
mapfile -t column2 < <(awk '{print $2}' "$input_file")

sorted_column1=($(printf "%s\n" "${column1[@]}" | sort -n))
sorted_column2=($(printf "%s\n" "${column2[@]}" | sort -n))

# part 1
sum_of_differences=0
for ((i = 0; i < ${#sorted_column1[@]}; i++)); do
    difference=$((sorted_column1[i] - sorted_column2[i]))
    sum_of_differences=$((sum_of_differences + ${difference#-}
))
done

echo "Part 1 answer: $sum_of_differences"

# part 2
sum_of_similarities=0
for num1 in "${sorted_column1[@]}"; do
    count=0
    for num2 in "${sorted_column2[@]}"; do
        if [[ "$num1" -eq "$num2" ]]; then
            ((count++))
        fi
    done
    similarity=$((num1 * count))
    sum_of_similarities=$((sum_of_similarities + similarity))
done

echo "Part 2 answer: $sum_of_similarities"