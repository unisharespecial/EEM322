.MODEL SMALL
.STACK 100H
.DATA

DATA1 DB 99,?, 100 DUP ('$')
laf db "hiz giriniz: 1-hizli 2-orta 3-yavas","$"
erro db  "erroro",0dH,0ah,"$"

BAYRAK1A DB "  *                                                   ",0dH,0ah," * *                                                  ",0dH,0ah,"*   **************************************************",0dH,0ah,"$"
BAYRAK1B DB "       *                                              ",0dH,0ah,"      * *                                             ",0dH,0ah,"******   *********************************************",0dH,0ah,"$"
BAYRAK2A DB "            *                                         ",0dH,0ah,"           * *                                        ",0dH,0ah,"***********   ****************************************",0dH,0ah,"$"
BAYRAK2B DB "                 *                                    ",0dH,0ah,"                * *                                   ",0dH,0ah,"****************   ***********************************",0dH,0ah,"$"
BAYRAK3A DB "                      *                               ",0dH,0ah,"                     * *                              ",0dH,0ah,"*********************   ******************************",0dH,0ah,"$"
BAYRAK3B DB "                           *                          ",0dH,0ah,"                          * *                         ",0dH,0ah,"**************************   *************************",0dH,0ah,"$"
YOKET  DB  0dH,0ah,"$"


.CODE

MAIN PROC FAR
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX

	JMP ILK

TEKRAR:	CALL CLRSCR

	MOV AH, 09H
	MOV DX, OFFSET yoket
	INT 21H

	MOV AH, 09H
	MOV DX, OFFSET erro
	INT 21H

ILK:	MOV AH, 09H
	MOV DX, OFFSET laf
	INT 21H		

	MOV SI,OFFSET Data1

	SUB AX,AX
	INT 16H
	MOV DL,AL
	MOV AH,02
	INT 21H
	MOV [SI],DL

	MOV AL,31H
	
	CMP DL,AL
	JZ  NO1
	INC AL
	CMP DL,AL
	JZ NO2
	INC AL
	CMP DL,AL
	JZ NO3
	JMP TEKRAR

NO1:  	MOV BX,1FFFH
	JMP STEP
NO2:	MOV BX,5FFFH
	JMP STEP
NO3:	MOV BX,9FFFH
	JMP STEP


step:	 mov cx,9fffH
bigloop: push cx

	
	PUSH BX
	
	call clrscr

	pop bx

	MOV AH, 09H
	MOV DX, OFFSET BAYRAK1A
	INT 21H	

	MOV AH, 09H
	MOV DX, OFFSET BAYRAK1B
	INT 21H	

	MOV AH, 09H
	MOV DX, OFFSET yoket
	INT 21H	
	
	mov dx,bx
	
	call dela

	mov bx,dx

	push bx

	call clrscr

	pop bx

	MOV AH, 09H
	MOV DX, OFFSET BAYRAK2A
	INT 21H	

	MOV AH, 09H
	MOV DX, OFFSET BAYRAK2B
	INT 21H	

	MOV AH, 09H
	MOV DX, OFFSET yoket
	INT 21H	

	mov dx,bx

	call dela

	mov bx,dx
		
	push bx

	call clrscr

	pop bx

	MOV AH, 09H
	MOV DX, OFFSET BAYRAK3A
	INT 21H	

	MOV AH, 09H
	MOV DX, OFFSET BAYRAK3B
	INT 21H	

	MOV AH, 09H
	MOV DX, OFFSET yoket
	INT 21H	

	mov dx, bx
	
	call dela	

	mov bx,dx		

	pop cx
	loop bigloop	
	

	MOV AH,4CH
	INT 21H
MAIN ENDP
	


CLRSCR	PROC
	MOV AX, 0600H
	MOV BH, 07H
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H
	RET
CLRSCR	ENDP	
	
DELA  	PROC

	mov cx,1fffH
lol2:	push cx
	mov cx,1fffH
lol:	loop lol
	pop cx
	loop lol2
	RET
DELA 	ENDP
	END MAIN
