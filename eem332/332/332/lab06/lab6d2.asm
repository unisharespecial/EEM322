;BERK YURTTAGÜL 20094386
;EEM 332 - LAB 6 - ÖNÇALIÞMA SORU 1

		.MODEL SMALL
		.STACK 64
		.DATA
SONUC		DB	100 DUP(?)
ISIM		DB	100 DUP(?)
		

		.CODE
MAIN		PROC	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS



		SUB DX,DX	;DX'i sýfýrla
		SUB CX,CX
		MOV SI,OFFSET ISIM
		MOV DI,OFFSET SONUC

		
	DEVAM:	MOV AH,1
		INT 21H
		CMP AL,0DH	;Enter'a basýldý mý?
		JZ  DONDURME		;Basýldýysa döngüden çýk
		MOV [SI],AL
		INC SI		;stringi arttýr
		JMP DEVAM	;Devam

      DONDURME: MOV AH,'$'
		MOV [SI],AH
		MOV SI,OFFSET ISIM


	ARA:	INC CL
		MOV AH,20H
		CMP [SI],AH	;Boþluk mu?
		JZ  YAZ		;Boþluk ise ÇIK
		INC SI
		JMP ARA		;Devam


	YAZ: 	MOV AH,'$'
		INC SI
		CMP [SI],AH
		JZ  BAS		;SONU ise ÇIK
		MOV AH,[SI]
		MOV [DI],AH
		INC DI
		JMP YAZ

	BAS:	MOV SI,OFFSET ISIM
		MOV AH,' '
		MOV [DI],AH
		INC DI
		DEC CL
	YAZ2:	MOV AH,[SI]
		MOV [DI],AH
		INC DI
		INC SI
		LOOP YAZ2


		MOV AX,0D0AH
		MOV [DI],AX	;Alt Satýra yazdýrmak için
		MOV DX,OFFSET SONUC
		ADD DI,2	;Ýki adet 8 bit
		MOV AH,'$'	;String sonu
		MOV [DI],AH

		MOV 	AH,09H
		INT 	21H

		SUB DI,2
		MOV AH,'$'	;String sonu
		MOV [DI],AH

	        MOV AH,1
		INT 21H
		CMP AL,0DH		;Enter'a basýldý mý?
		JNZ  SON		;Basýldýysa döngüden çýk

		MOV AH,'$'	;String sonu

	
		MOV SI,OFFSET SONUC
	 HESAP:	CMP [SI],AH
		JZ SAYITMM
		INC CL
		INC SI
		JMP HESAP
	SAYITMM:INC CL
		MOV SI,OFFSET ISIM
		MOV DI,OFFSET SONUC
		JMP BIRDAHA

	BIRDAHA:MOV AH,[DI]
		MOV [SI],AH
		INC SI
		INC DI
		LOOP BIRDAHA

		MOV SI,OFFSET ISIM
		MOV DI,OFFSET SONUC
		JMP ARA



		MOV 	AH,09H
		INT 	21H
		
	SON:	MOV	AH,4CH		;set up to
		INT	21H		;return to DOS
MAIN		ENDP			
		END	MAIN		;this is the program exit point