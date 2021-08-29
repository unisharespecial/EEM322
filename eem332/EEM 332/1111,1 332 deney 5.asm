	.MODEL SMALL
	.STACK 100h
	.DATA 
kelime DB "Bir kelime giriniz: $"

degistir DB 30,?, 29 DUP ('$')
	.CODE
MAIN PROC FAR

	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX

MOV AH, 09H
MOV DX, OFFSET kelime
INT 21H	

MOV AH, 0AH
MOV DX, OFFSET degistir
INT 21H

mov dl, 10d ; dl = LF 
mov ah, 2h ; display subprogram
int 21h ; display LF

	CLD
	MOV DI,OFFSET degistir
	MOV CX,0ffH
	MOV AL,'e'
DONGU :	REPNE SCASB
	JNE OVER
	DEC  DI
	MOV BYTE PTR[DI],'a'
	INC CX
	LOOP DONGU

OVER:	MOV AH,09H
	MOV DX,OFFSET degistir+2
	INT 21H

	MOV AH,4CH
	INT 21H

MAIN ENDP
	END MAIN