#!/bin/bash
#https://stackoverflow.com/questions/31770604/how-to-generate-statically-linked-executables
rustc -C target-feature=+crt-static -o hello  src/main.rs
file hello
ldd hello 
checksec --file=./hello
