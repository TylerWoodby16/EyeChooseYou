
#This at&t syntax 
.data
output: .string "%d"
arr: .quad 10, 9, 8, 7, 6, 5, 14, 3, 2, 1, 99, 66, 2, 4, 6, 24
arrlen: .quad 16
newline: .string "\n"
.text
.global main

selectSort:
dec %rsi

_selectSort:
# arr pointer in %rdi
# len in %rsi
call argmax
call swap # pass that and last known len to swap
dec %rsi
cmpq $1, %rsi
jge _selectSort
ret

swap:
#index 1 in %rax
#index 2 in %rsi
push (%rdi, %rax, 8)
push (%rdi, %rsi, 8)
pop (%rdi, %rax, 8)
pop (%rdi, %rsi, 8)
ret

argmax:
#len in %rsi
mov $0, %rax #max index, return reg
mov $1, %rbx #current index

_argmax:
mov (%rdi, %rbx, 8), %rcx
cmpq (%rdi, %rax, 8), %rcx
cmovg %rbx, %rax
inc %rbx
cmp %rbx, %rsi
jge _argmax
ret

printArr:
xor %rax, %rax
ret

_printArr:
push %rdi
push %rsi
push %rax
movq (%rdi, %rax, 8), %rsi
movq $output, %rdi
xor %rax, %rax
call printf
pop %rax
pop %rsi
pop %rdi
inc %rax
cmpq %rsi, %rax
jl _printArr
#else
movq $newline, %rdi
xor %rax, %rax
call printf
ret

main:
mov $arr, %rdi
mov (arrlen), %rsi
call printArr
mov $arr, %rdi
mov (arrlen), %rsi
call selectSort
mov $arr, %rdi
mov (arrlen), %rsi
call printArr

