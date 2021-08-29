
	.MODEL SMALL
	.STACK 64 (?)

;________DATA SEGMENT________________________________	



	.DATA
CR	EQU	0DH
LF	EQU	0AH


MSG	DB	'Kelimeleri Sayilacak Cumleyi Giriniz..:$'
MSG2	DB	CR, LF, 'Girilen Cumledeki Kelime adeti..:', '$'
MSG3	DB	' Adettir...$'

STR1	DB  100, ?, 100 DUP (0)	; buraya klavyeden gelicek string
	ORG 100



;________CODE SEGMENT_________________________________
 
    
	.CODE
MAIN	PROC	FAR                                   
	MOV AX, @DATA                          
	MOV DS, AX                                      
	
	XOR AX,AX		

	CALL CLRSCR		
	CALL CURSOR		
	
	MOV DX, OFFSET MSG
	CALL DISPLAYSTR

	MOV DX, OFFSET STR1	; DX e stringin adresi atýlýyor.
	CALL INPUT

	MOV BX, OFFSET STR1
	CALL FNDSPC		

	CALL CASCII
				
				
	MOV DX, OFFSET MSG2
	CALL DISPLAYSTR
	
	MOV AH,02H
	MOV DL,CH
	INT 21H
	
	MOV DL,CL
	INT 21H
	
	MOV DX, OFFSET MSG3
	CALL DISPLAYSTR	
	
	MOV AH, 4CH		; EXIT to DOS 
	INT 21H			

MAIN	ENDP			
	


;_________________________________________________________
;_______CLRSCR Fonksiyonu__________________________________
;_________________________________________________________


CLRSCR	PROC
	MOV AX, 0600H
	MOV BH, 07H
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H
	RET
CLRSCR	ENDP	
	
;_________________________________________________________
;_______CURSOR  Fonksiyonu_________________________________
;_________________________________________________________


CURSOR	PROC
	MOV AH, 02H
	MOV BH, 00H
	MOV DL, 00H
	MOV DH, 00H	;***************************************
	INT 10H
	RET
CURSOR	ENDP	
	

;_________________________________________________________
;_______INPUT Fonksiyonu___________________________________
;_________________________________________________________


INPUT	PROC

	MOV AH,0AH		;AH=0AH String  için INT 21 deðeri.
;DX= STR ADDRESS******************
	INT 21H			; String DX in gösterdiði adreste.
	RET
INPUT	ENDP


;_________________________________________________________
;_______FNDSPC Fonksiyonu__________________________________
;_________________________________________________________


FNDSPC	PROC

	
	XOR DX,DX
	
SPACE:	INC DX			
				; en son giren space en son kelimenin baþladýý yer
SEARCH:	MOV AL,[BX]
	INC BX
	CMP AL, 20H		;space arýoz 
	JE SPACE			; space varsa spacein indexini kaydetmek için SPACE e git dioz  
	CMP AL,0DH		; NULL mý acaba Null sa string bitti loopdan defol
	JE LOST		
	JMP SEARCH		
	
LOST:	RET			; DX= Kaç Space olduðu. 
				; BX=  NULL ýn indexi.

FNDSPC	ENDP


;_________________________________________________________
;_______DISPLAYSTR Fonksiyonu______________________________
;_________________________________________________________


DISPLAYSTR	PROC
	MOV AH, 09H
; DX= STR ADDRESS *****************************************
	INT 21H
	RET
DISPLAYSTR ENDP



;_________________________________________________________
;_______CASCII Fonksiyonu______________________________
;_________________________________________________________


CASCII	PROC
	
	MOV AX, DX
	
	MOV CL, 04H
	SHL AX, CL
	SHR AL, CL
	OR AX, 3030H

	MOV CX, AX
	
	RET
CASCII	ENDP


;_________________________________________________________
;_______RWASCII Fonksiyonu______________________________
;_________________________________________________________


	



;__________________________________________________________
	END MAIN

	