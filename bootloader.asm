org 0x7c00
bits 16

buffer TIMES 80 db 0
temp TIMES 2 db 0

go:
    ; Set the video mode (3 for 80x25 color text mode)
    mov ah, 00H
    mov al, 3 ; mov -> move
    int 10h  ; run the code
	
	; setting col and row to 0
	; dh - row
	; dl - col
    mov dh, 0
    mov dl, 0
    
    ; storing the string into si
    mov si, buffer

start:
	;read input	
    mov ah, 00H
    int 16h
	
	;check backspace
    cmp ah, 14
    je check_backspace

	;check enter
    cmp ah, 28
    je check_enter
	
	;print character from the input if its not backspace or enter
    mov ah, 09H
    mov bh, 0
    mov bl, 0x04
    mov cx, 1
    int 10h
    	
    ;change cursor position
    mov ah, 02H
    add dl, 1
    int 10h

    jmp start


check_backspace:
	; check if the cursor position is at begining
    cmp dl, 0 
    je subrow

    mov ah, 02H
    sub dl, 1
    int 10h

    mov ah, 09H
    mov al, ' '
    int 10h

    jmp start

check_enter:
	cmp dh, 23
	je start
	mov [temp], dl
	mov dl, 0
    jmp copy_row	
	
copy_row:
	cmp dl, 80
	je print_str
	
	;move the cursor
	mov ah, 02h
	int 10h
	
	;read video
    mov ah, 8h
    int 10h
    
    mov [si], al
    add si, 1
	
	
	add dl, 1
	jmp copy_row

print_str:
	mov dl, 0
	add dh, 1
	;print buffer string
	mov ax, 0x0
	mov es, ax
	mov bp, buffer
	mov cx, 80
	mov bH, 0
	mov bl, 0x07
	mov ax, 1300h
	int 10h
	
	mov dl, [temp]
	
	;move the cursor
	mov ah, 02h
	int 10h
	mov si, buffer
	
	jmp start
    
subrow:
	;if the cursor is at 0x0 you cant backspace
    cmp dh, 0 
    je start
	
	;otherwise we move the cursor the row above at the end
    sub dh, 1
    mov dl, 80

    ;change cursor position
    mov ah, 02H
    int 10h

	;read video
    mov ah, 8h
    int 10h 
	
	;check if it's empty
    cmp al, 32
    je check_character_end_position

    jmp start

check_character_end_position:
	;base case if the line above is all empty
    cmp dl, 0
    je start 
	
	; go a postion to the left
    sub dl, 1

    ;change cursor position
    mov ah, 02H
    int 10h
	
	;read video
    mov ah, 8h
    int 10h 
	
	;check if its empty
    cmp al, 32
    je check_character_end_position

	;move cursor to the right empty space
    add dl, 1
    ;change cursor position
    mov ah, 02H
    int 10h

    jmp start

times 510 - ($-$$) db 0
dw 0xAA55
