.model small
.stack 100h
.data

;
;Ekrana yazd�r�lacaklar ve stringler i�in haf�zada yer ayr�l�yor
;

giris DB "Ters cevrilecek kelimeyi giriniz: $"
kelime DB 30,?, 29 DUP ('$')
ters DB	30 DUP(?), 29 DUP ('$')


	.code
main proc far
	mov	ax, @Data
	mov	ds, ax	
	

;
;Ekrana yazd�rma mesaj� g�r�nt�leniyor
;
MOV AH, 09H
MOV DX, OFFSET giris
INT 21H	




;
;Ters �evrilecek kelime klavyeden okunuyor
;
MOV AH, 0AH
MOV DX, OFFSET kelime
INT 21H

;
;�mle� bir a�a��ya al�n�yor
;
mov dl, 10d 
mov ah, 2h 
int 21h 


	
	mov	cx, 11				
	mov	dx, OFFSET kelime		;Ters �evrilecek kelime okunup DX i�ine atan�yor



			
	push	cx	
	mov	bx, OFFSET kelime
	mov	si, OFFSET ters+4
	add	si, cx	
	dec	si			
	
cevir:
		mov	al, [bx]		; 
		mov	[si], al		; 
		inc	bx			;Harfler �evrilmi� �ekilde tekrar yerle�tiriliyor
		dec	si			; 
		loop	cevir			; 
		pop	cx			;
		mov	ah, 40h			;
		mov	bx, 1			;Ters �evrilmi� kelime ekrana yazd�r�l�yor 
		mov	dx, OFFSET ters+2	;
		int	21h			; 

;
;Program sonland�r�l�yor
;

		mov	ah, 4ch			
		int	21h			
		main endp
			end main
