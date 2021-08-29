
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

	
	
	MOV DX, OFFSET MSG
	MOV AH, 09H
	INT 21H		 
				
				

	MOV DX, OFFSET STR1	 
	MOV AH,0AH		
	INT 21H			
			

	MOV BX, OFFSET STR1	
	XOR DX,DX
	
SPACE:	MOV DX, BX		
				
SEARCH:	MOV AL,[BX]
	INC BX
	CMP AL, 20H		 
	JE SPACE			  
	CMP AL,0DH		
	JE LOST		
	JMP SEARCH		

	MOV AX, OFFSET STR1
	ADD AX, DX
	MOV SI, AX

	MOV AX, OFFSET STR2
	MOV DI, AX

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


	MOV DX, OFFSET MSG2
	MOV AH, 09H
	INT 21H
	
	
	MOV DX, OFFSET STR2
	MOV AH, 09H
	INT 21H
			
	MOV AH, 4CH		
	INT 21H			

MAIN	ENDP			
	


	END MAIN

	