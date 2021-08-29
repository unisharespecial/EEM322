.model small
.stack 100h
.data

;
;Ekrana yazdýrýlacaklar ve stringler için hafýzada yer ayrýlýyor
;

giris DB "Ters cevrilecek kelimeyi giriniz: $"
kelime DB 30,?, 29 DUP ('$')
ters DB	30 DUP(?), 29 DUP ('$')


	.code
main proc far
	mov	ax, @Data
	mov	ds, ax	
	

;
;Ekrana yazdýrma mesajý görüntüleniyor
;
MOV AH, 09H
MOV DX, OFFSET giris
INT 21H	




;
;Ters çevrilecek kelime klavyeden okunuyor
;
MOV AH, 0AH
MOV DX, OFFSET kelime
INT 21H

;
;Ýmleç bir aþaðýya alýnýyor
;
mov dl, 10d 
mov ah, 2h 
int 21h 


	
	mov	cx, 11				
	mov	dx, OFFSET kelime		;Ters çevrilecek kelime okunup DX içine atanýyor



			
	push	cx	
	mov	bx, OFFSET kelime
	mov	si, OFFSET ters+4
	add	si, cx	
	dec	si			
	
cevir:
		mov	al, [bx]		; 
		mov	[si], al		; 
		inc	bx			;Harfler çevrilmiþ þekilde tekrar yerleþtiriliyor
		dec	si			; 
		loop	cevir			; 
		pop	cx			;
		mov	ah, 40h			;
		mov	bx, 1			;Ters çevrilmiþ kelime ekrana yazdýrýlýyor 
		mov	dx, OFFSET ters+2	;
		int	21h			; 

;
;Program sonlandýrýlýyor
;

		mov	ah, 4ch			
		int	21h			
		main endp
			end main
