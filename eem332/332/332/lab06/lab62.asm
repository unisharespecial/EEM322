.model small
.stack 100
.data
rnum dw ?
	.code
main proc far

        in al, 40h			; read micro-clock for initial seed
        mov ah, al
        in al, 40h
        xchg al, ah
        or ax, 1
        mov rnum, ax			;rnum de�eri ax de�erini al�r

	mov bx,0100			;0-100 aras� i�in k�st�lama yapacak register
	div bx				;b�lme i�lemi kalan dx registerinde
	add dx,1			;mod i�lemi gere�i 1 toplanmas�
	
	mov ax,dx	
	MOV aH, 0H
					;decimale �evirmek i�in gerekli i�lemler		
	MOV BX, 10	
	DIV BL
	OR aX, 3030H	

	mov dl,al
	mov bl,ah
	mov ah,02H
	int 21H

	mov dl,bl			;yazd�rma i�lemleri
	mov ah,02H
	
	int 21H
	mov ah,4cH			;DOS a d�n��
	int 21H

main endp
	end main