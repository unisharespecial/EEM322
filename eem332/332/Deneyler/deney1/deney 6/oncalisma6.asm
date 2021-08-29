.MODEL SMALL
		.STACK 64
		.DATA
		ORG   0100h
DAT		DB      100  DUP(?)
Sayi     DB      ?
		

		.CODE
MAIN		PROC			FAR          
		MOV			AX,#DAT
		MOV 			DS,AX
		SUB			AX,AX
		MOV 			CX,100
		MOV			SI,OFFSET DAT
		sub			bx,bx	

verial:
		mov			ax,0
		int			16h
		mov			[si],si
		inc 			si
		mov 			dl,al
		mov 			sh,02	
		cmp			sl,32d
		jnz			devam 
		Ýnc 			bx

devam:		cmp			sl,46 
		Jx			yazdýr
		Ýnt 			21h 
		loop			verial

		inc			bl   
		sub			ax,ax
		mov 			al,bl	
		mov 			cl,10
		div			al, 
		mov			bx,ax

		mov 			dl,46
		int			21h
		mov 			ah,02
		int 			21h
		mov 			dl,09
		int 			21h
		mov			dl,ah
		or 			dl,46
		int 			21h
		mov 			dl,bh
		or 			dl,46
		int 			21h
		mov 			ah,4ch
		int 			21h


		ENDP
		END MAIN
