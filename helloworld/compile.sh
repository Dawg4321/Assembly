#!/bin/bash

#simple script to compile helloworld.asm

nasm -f elf32 -o h helloworld.asm
ld -m elf_i386 -o helloworld h
rm h