
	.MODEL SMALL
	.STACK 64 (?)

;________DATA SEGMENT________________________________	



	.DATA
CR	EQU	0DH
LF	EQU	0AH


STR1	DB  100, ?, 100 DUP (0)	; buraya klavyeden gelicek string
	ORG 100
STR2	DB CR, LF, 100 DUP (?), '$'	; burasý deiþtirilmiþ string


MSG	DB	'Donusturulecek Cumleyi Giriniz..:$'
	ORG 22H
MSG2	DB	CR, LF, 'Donusturulen Cumle..:', '$'
	ORG 20H


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
				
				

	MOV DX, OFFSET STR1	 
	CALL INPUT		

	MOV BX, OFFSET STR1	
	CALL FNDSPC		

	MOV AX, OFFSET STR1
	ADD AX, DX
	MOV SI, AX

	MOV AX, OFFSET STR2
	MOV DI, AX

	CALL REVERT		


	MOV DX, OFFSET MSG2
	CALL DISPLAYSTR
	
	
	MOV DX, OFFSET STR2
	CALL DISPLAYSTR
			
	MOV AH, 4CH		
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
	MOV DH, 00H	
	INT 10H
	RET
CURSOR	ENDP	
	

;_________________________________________________________
;_______INPUT Fonksiyonu___________________________________
;_________________________________________________________


INPUT	PROC

	MOV AH,0AH		
	INT 21H			
	RET
INPUT	ENDP


;_________________________________________________________
;_______FNDSPC Fonksiyonu__________________________________
;_________________________________________________________


FNDSPC	PROC

	;BX= OFFSET STR*******************************
	XOR DX,DX
	
SPACE:	MOV DX, BX		
				
SEARCH:	MOV AL,[BX]
	INC BX
	CMP AL, 20H		 
	JE SPACE			  
	CMP AL,0DH		
	JE LOST		
	JMP SEARCH		
	
LOST:	RET			; DX= Son kelimenin yeri 
				; BX=  NULL ýn indexi.

FNDSPC	ENDP


;_________________________________________________________
;_______REVERT Fonksiyonu__________________________________
;_________________________________________________________



REVERT	PROC
	
	MOV AX, BX
	SUB AX, DX
	MOV CX, AX
	DEC CX
	
	
TURN:	MOV AL, [SI]
	MOV [DI], AL
	INC SI
	INC DI
	LOOP TURN
	
	MOV AL, 20H
	MOV [DI],  AL
	INC DI

	MOV AX, OFFSET STR1
	INC AX
	INC AX
	MOV SI, AX

COPY:	MOV AL, [SI]
	MOV [DI], AL
	INC DI
	INC SI
	CMP SI, DX
	JC COPY
	
	RET
REVERT	ENDP


;_________________________________________________________
;_______DISPLAYSTR Fonksiyonu______________________________
;_________________________________________________________


DISPLAYSTR	PROC
	MOV AH, 09H
	INT 21H
	RET
DISPLAYSTR ENDP

;__________________________________________________________
	END MAIN

	