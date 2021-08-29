;BERK YURTTAG�L 20094386
;EEM 332 - LAB 6 - �N�ALI�MA SORU 1

		.MODEL SMALL
		.STACK 64
		.DATA
SONUC		DB	100 DUP(?)
ISIM		DB	100 DUP(?)
RNUM 		DW 	?
		

		.CODE
MAIN		PROC	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS



		SUB DX,DX	;DX'i s�f�rla
		SUB CX,CX
		MOV SI,OFFSET ISIM
		MOV DI,OFFSET SONUC

		
	DEVAM:	MOV AH,1
		INT 21H
		CMP AL,0DH	;Enter'a bas�ld� m�?
		JZ  DONDURME		;Bas�ld�ysa d�ng�den ��k
		MOV [SI],AL
		INC SI		;stringi artt�r
		JMP DEVAM	;Devam

      DONDURME: MOV AH,'$'
		MOV [SI],AH
		MOV SI,OFFSET ISIM
	

	ARA1:	MOV AH,20H
		MOV AL,'$'
		CMP [SI],AH	
		JZ  BOSSAY		;Bo�luk ise sayac� artt�r
		CMP [SI],AL
		JZ  RANDOM		;B�TT� �SE �IK	
		INC SI
		JMP ARA1		;Devam

	BOSSAY:	INC CL
		INC SI
		JMP ARA1


	RANDOM: IN AL, 40H		; READ M�CRO-CLOCK FOR �N�T�AL SEED
		MOV AH, AL
		IN AL, 40H
		XCHG AL, AH
  		OR AX, 1
     		MOV RNUM, AX		;RNUM DE�ER� AX DE�ER�N� ALIR

		MOV BL,CL		;0-100 ARASI ���N	
		DIV BX			;B�LME ��LEM� KALAN DX�DE
		ADD DX,1		;MOD ��LEM� GERE�� 1 TOPLANMASI
		
		
		MOV SI,OFFSET ISIM
		SUB CX,CX


	ARA:	INC CL
		MOV AH,20H
		CMP [SI],AH	;Bo�luk mu?
		JZ  YAZ		;Bo�luk ise �IK
		INC SI
		JMP ARA		;Devam


	YAZ: 	MOV AH,'$'
		INC SI
		CMP [SI],AH
		JZ  BAS		;SONU ise �IK
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
	
		DEC DX
		MOV AH,'$'	;String sonu
		MOV [DI],AH
		JNZ TEKRAR


		MOV AX,0D0AH
		MOV [DI],AX	;Alt Sat�ra yazd�rmak i�in
		MOV DX,OFFSET SONUC
		ADD DI,2	;�ki adet 8 bit
		MOV AH,'$'	;String sonu
		MOV [DI],AH

		MOV 	AH,09H
		INT 	21H

		SUB DI,2
		MOV AH,'$'	;String sonu
		MOV [DI],AH

	        MOV AH,1
		INT 21H
		CMP AL,0DH		;Enter'a bas�ld� m�?
		JNZ  SON		;Bas�ld�ysa d�ng�den ��k

		MOV AH,'$'	;String sonu

	
	TEKRAR:	MOV SI,OFFSET SONUC
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