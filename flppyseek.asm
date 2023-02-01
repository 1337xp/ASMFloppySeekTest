
.model small
.stack 100h
.data

seekdata db "0123" ;Seek data for decoder


.code
main proc
org 100h
mov al, 014h
mov dx, 3f2h ;Drive control register
out dx, al
call testfdc
mov al, 0Fh
mov dx, 3f5h
out dx, al
call testfdc
mov al, 00h
mov dx, 3f5h
out dx, al
call testfdc
mov al, 0FFh
mov dx, 3f5h
out dx, al
call pause
mov al, 0Fh
mov dx, 3f5h
out dx, al
call testfdc
mov al, 00h
mov dx, 3f5h
out dx, al
call testfdc
mov al, 00h
mov dx, 3f5h
out dx, al
mov cl, 8
call pause
call floppyrecal
mov ah, 4ch
int 21h
main endp

testfdc proc
mov dx, 3f4h
in al, dx
and al, 0c0h
cmp al, 080h
jne testfdc
ret
testfdc endp

pause proc
push cx
push ax
push dx
push bx

mov ah,08h
int 21h

pop bx
pop ax
pop dx
pop cx

ret

pause endp


floppyrecal proc
mov dx,3f5h
mov al,07h
out dx, al
call testfdc
mov al,00h
out dx, al
call testfdc
dec cl
jnz floppyrecal
ret
floppyrecal endp
end main
