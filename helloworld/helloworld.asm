global _start

section.text:           ; text section

_start:
    
    ; write function from /usr/include/asm/unistd_32.h is defined as seen below (see man 2 write)
    ; write(int fd, const void *buf, size_t count)
    ; fd = file decriptor (ebx)
    ; buf = chars to display (ecx)
    ; count = length of bytes to print (edx)

    mov eax, 0x4        ; use write system call
    mov ebx, 1          ; use stdout as file descriptor
    mov ecx, msg        ; use msg as buf
    mov edx, msg_len    ; use length of msg as count
    int 0x80            ; invoke write with interupt

    mov eax, 0x1        ; use exit system call
    mov ebx, 0          ; move return value of zero to ebx
    int 0x80            ; invoke exit with interupt

section.data:                    ; data section

msg: db "Hello World!",0xA,0    ; defining message
msg_len: equ $-msg              ; getting message length