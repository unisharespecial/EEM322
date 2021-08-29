;BERK YURTTAGÜL 20094386
;EEM 332 - LAB 6 - ÖNÇALIÞMA SORU 1

		.MODEL SMALL
		.STACK 64
		.DATA
SONUC	DB	100 DUP(?)
		

		.CODE
MAIN		PROC	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX	;assign value to DS
		
	
		SUB DX,DX	;DX'i sýfýrla
		SUB BX,BX
		INC DX		;En az bir kelime
		
	DEVAM:	MOV AH,1
		INT 21H
		CMP AL,0DH		;Enter'a basýldý mý?
		JZ  BITIS		;Basýldýysa döngüden çýk
		MOV [SI],AL
		INC SI			;stringi arttýr
		CMP AL,20H		;Boþluk mu?
		JZ  BOSLUK		;Boþluk ise DX'i arttýr
		JMP DEVAM		;Devam

	BOSLUK: INC DX		;Boþluk, DX'i arttýr
		JMP DEVAM    

		MOV DI,DX	
	
	

		;Lab Föyünde verilen Hex 'i Decimal'e çeviren kod

	BITIS:  MOV DI,DX
		MOV AX,DI 	;HEXVAL ADRESINDEN DEGERI AX’E AL
		SUB DX,DX
		MOV BL,000AH 	;BX YAZMACINA 0A DEGERINI ATA
		DIV BL 		;AX YAZMACINI BX YAZMACINA BÖL
		MOV DH,AL 	;CIKAN DEGER DECIMAL SAYININ 10LAR
		MUL BL 		;DEGERI BX’LE CARP
		MOV CX,DI
		SUB CX,AX	;CX VE AX YAZMACLARININ FARKINI AL
		MOV DL,CL 	;CIKAN DEGER DECIMAL SAYININ 1LER 


		OR  DX,3030H		;ASCII'ye çevir
		XCHG DL,DH		;Basamaklarý düzenle
		MOV DI,OFFSET SONUC
		MOV AX,0D0AH		;Alt Satýra yazdýrmak için
		MOV [DI],AX		;Alt Satýra yazdýrmak için
		ADD DI,2
		MOV [DI],DL
		INC DI
		MOV [DI],DH
		INC DI	
		MOV DX,OFFSET SONUC	
		MOV AH,'$'		;String sonu
		MOV [DI],AH



		MOV 	AH,09H	;Yazdýr
		INT 	21H
		
		MOV	AH,4CH	;set up to
		INT	21H		;return to DOS
MAIN		ENDP			
		END  MAIN		;this is the program exit point