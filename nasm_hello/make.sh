#!/bin/bash
# NASM make file for Linux

a=${1%.*}
o=$a.o
nasm -f elf $1 && ld $o -o $a
