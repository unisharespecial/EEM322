		.MODEL SMALL
		.STACK 64 (?)
		.DATA

	BRC	DB  100  (?)
		ORG 100
    
		.CODE
	MAIN	PROC	FAR                                   
		MOV AX, @DATA                          
		MOV DS, AX                                      
		SUB AX,AX
		MOV AH,0AH
		LEA DX, BRC
		INT 21H
		
		SUB DX,DX
		LEA BX, BRC

BOS:		INC DL
		
DEVAM:	MOV AL,[BX]
		INC BX
		CMP AL,20H
		JE BOS
		CMP AL,0DH
		JE DIGER
		JMP DEVAM
	
DIGER:	SUB AX,AX
		MOV AL,DL
		MOV CL, 04H
		SHL AX, CL
		SHR AL, CL
		OR AX,3030H
		MOV CX, AX
		MOV AH,02H
		MOV DL,CH
		INT 21H
		MOV DL,CL
		INT 21H
		MOV AH, 4CH		
		INT 21H			

MAIN	ENDP			
	END MAIN
