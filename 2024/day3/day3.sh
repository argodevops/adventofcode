#!/bin/bash

text="xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

matches=($(echo "$text" | grep -oP 'mul\([0-9]+,[0-9]+\)'))

total=0

for match in "${matches[@]}"; do
    if [[ $match =~ mul\(([0-9]+),([0-9]+)\) ]]; then
        num1=${BASH_REMATCH[1]}
        num2=${BASH_REMATCH[2]}
        product=$((num1 * num2))
        (( total = $total + $product ))
    fi
done

echo "Part 1 total: $total"

text=$(cat "input.txt")

matches=($(echo "$text" | grep -oP 'mul\([0-9]+,[0-9]+\)'))

total=0

for match in "${matches[@]}"; do
    if [[ $match =~ mul\(([0-9]+),([0-9]+)\) ]]; then
        num1=${BASH_REMATCH[1]}
        num2=${BASH_REMATCH[2]}
        product=$((num1 * num2))
        (( total = $total + $product ))
    fi
done

echo "Part 1 total: $total"

#### part 2

text="xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

matches=($(echo "$text" | grep -oP "do\(\)|don't\(\)|mul\([0-9]+,[0-9]+\)"))

total=0
enabled=true

for match in "${matches[@]}"; do
    if [[ $match =~ do\(\) ]]; then
        enabled=true
    fi
    if [[ $match =~ don\'t\(\) ]]; then
        enabled=false
    fi
    if $enabled && [[ $match =~ mul\(([0-9]+),([0-9]+)\) ]]; then
        num1=${BASH_REMATCH[1]}
        num2=${BASH_REMATCH[2]}
        #echo "$num1 $num2"
        product=$((num1 * num2))
        (( total = $total + $product ))
    fi
done

echo "Part 2 total: $total"

text=$(cat "input.txt")

matches=($(echo "$text" | grep -oP "do\(\)|don't\(\)|mul\([0-9]+,[0-9]+\)"))

total=0
enabled=true

for match in "${matches[@]}"; do
    if [[ $match =~ do\(\) ]]; then
        enabled=true
    fi
    if [[ $match =~ don\'t\(\) ]]; then
        enabled=false
    fi
    if $enabled && [[ $match =~ mul\(([0-9]+),([0-9]+)\) ]]; then
        num1=${BASH_REMATCH[1]}
        num2=${BASH_REMATCH[2]}
        #echo "$num1 $num2"
        product=$((num1 * num2))
        (( total = $total + $product ))
    fi
done

echo "Part 2 total: $total"
