org 0x7c00
bits 16

start:
    cli

    ; Set the video mode (3 for 80x25 color text mode)
    mov ah, 00H
    mov al, 3
    int 10h

    ; Set the cursor position 0x0
    mov ah, 02H
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 10h
    
    ; M1
    mov ah, 0eH
    mov AL, 'C'
    int 10h
    
    mov ah, 02H
    mov bh, 0
    mov dh, 1
    mov dl, 0
    int 10h
  
	;M2, M3, M4, M5
    ; Set the text mode attributes for red text on a black background
    mov ah, 09h
    mov al, 'H'
    mov bh, 0
    mov bl, 0x04  ; Red on black
    mov cx, 1
    int 10h
    
    mov ah, 02H
    mov bh, 0
    mov dh, 1
    mov dl, 1
    int 10h
    
    ; M6, M7
    ;; ES:BP is the pointer to string.
    mov ax, 0x0
    mov es, ax
    mov bp, str

    mov     dh, 12
    mov 	dl, 30
    mov     cx, 20
    mov     bH, 0
    mov 	bl, 0x02
    mov     ax, 1301h        ; AH=Function number 13h, AL=WriteMode 0
    int     10h
    
    mov ax, 0x0
    mov es, ax
    mov bp, str2
    mov     dh, 13
    mov 	dl, 30
    mov     cx, 20
    mov     bH, 0
    mov 	bl, 0x02
    mov     ax, 1302h        ; AH=Function number 13h, AL=WriteMode 0
    int     10h

    jmp $

str:	db 'FAF-211 Prodan Denis', 0
str2:  DB 'F',17H, 'A',24H, 'F',37H, '-',47H, '2',57H, '1',6fH,'1',07H, ' ',07H, 'P',07H, 'r',07H, 'o',97H, 'd',1fH, 'a',05H, 'n',17H, ' ',42H, 'D',07H, 'e',07H, 'n',0fH, 'i',09H, 's',07H
times 510 - ($-$$) db 0
dw 0xAA55
