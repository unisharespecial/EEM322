TITLE PROGRAM LAB 5: KEYBOARD HIT USING INT 16	

	.MODEL SMALL
	.STACK
	.DATA

	SAYILAR DB 5 dup (?)
	RESULT DB ?
	MESSAGE DB 'NOTLARI GIRINIZ?'
	.CODE

MAIN	PROC	FAR                                   
	MOV AX, @DATA                          
	MOV DS, AX                                      
	MOV CX, 5 
	MOV BP, 0
	MOV AH,09		       
	MOV DX, OFFSET MESSAGE
    	INT 21H
	MOV BX, OFFSET SAYILAR
	MOV AL,0                   
	MOV AL, [BX] 
	INC BX
	
AGAIN:	MOV AH, 01
	INT 16H
	JZ AGAIN
	MOV AH, 0
	INT 16H
	MOV [BP],AL
	INC BP
	MOV AH, 02
	INT 21H
	CMP AL, [BX]		
	JL NEXT			
	MOV AL,[BX]		

NEXT:	INC BX
	LOOP AGAIN                              
	MOV RESULT, AL		

	MOV AH, 4CH		
	INT 21H			

MAIN	ENDP			
	END MAIN