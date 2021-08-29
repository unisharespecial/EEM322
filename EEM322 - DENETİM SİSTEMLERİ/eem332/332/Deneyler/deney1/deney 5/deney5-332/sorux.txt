TITLE PROGRAM LAB 5: KEYBOARD HIT USING INT 16	
	.MODEL SMALL
	.STACK
	.DATA

	SAYILAR DB ? DUP (5)
	RESULT DB ?
	MESSAGE DB 'NOTLARI GIRINIZ?'
	.CODE
MAIN	PROC	FAR                                   
	MOV AX, @DATA                          
	MOV DS, AX                                      
	MOV CX, 5 		       
	MOV BX, OFFSET SAYILAR      
	MOV AL,0                   
	MOV AL, [BX] 
	INC BX
	INT 21H
AGAIN:	MOV AH, 01
	INT 16H
	JZ AGAIN
	MOV AH, 0
	INT 16H
	MOV [BP],AL
	INC BP
	CMP AL, [BX]		
	JL NEXT			
	MOV AL,[BX]		
NEXT	INC BX
	LOOP AGAIN                              
	MOV RESULT, AL		
	MOV AH, 4CH		
	INT 21H			
MAIN	ENDP			
	END MAIN