#!/bin/sh

echo "output the intermediate representation (IR)"

# swiftc -help |grep emit

mkdir -p tmp

swiftc -emit-ir main.swift > tmp/main.ir.txt

echo "now check out ir 'cat tmp/main.ir.txt' "

cat tmp/main.ir.txt