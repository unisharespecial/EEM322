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
        mov rnum, ax			;rnum deðeri ax deðerini alýr

	mov bx,0100			;0-100 arasý için kýstýlama yapacak register
	div bx				;bölme iþlemi kalan dx registerinde
	add dx,1			;mod iþlemi gereði 1 toplanmasý
	
	mov ax,dx	
	MOV aH, 0H
					;decimale çevirmek için gerekli iþlemler		
	MOV BX, 10	
	DIV BL
	OR aX, 3030H	

	mov dl,al
	mov bl,ah
	mov ah,02H
	int 21H

	mov dl,bl			;yazdýrma iþlemleri
	mov ah,02H
	
	int 21H
	mov ah,4cH			;DOS a dönüþ
	int 21H

main endp
	end main