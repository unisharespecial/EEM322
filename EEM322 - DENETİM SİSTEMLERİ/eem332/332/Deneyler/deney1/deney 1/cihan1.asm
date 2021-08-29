		.MODEL SMALL
		.STACK 64
		.DATA
		ORG 0010H			
		SIGN_DATA DB 69,87,96,45,75		;place data definitions here
		;
		.CODE
MAIN		PROC	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		;
		MOV CX,5;place code here	
		MOV BX,OFFSET SIGN_DATA	
		SUB AL,AL
AGAIN:		CMP AL,[BX]
		JA NEXT 
		MOV AL,[BX]
NEXT:		INC BX
		LOOP AGAIN
		MOV BX,10H
		MOV AH,02H
		MOV DL,[BX]
		INT 21H	
		;		
		MOV	AH,4CH	;set up to
		INT	21H		;return to DOS
MAIN		ENDP			
		END	MAIN		;this is the program exit point
