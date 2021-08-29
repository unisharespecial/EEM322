; 2x2 iki matrisin carpimini hesaplar
; 0100h-0103h birinci matris
; 0104h-0107h ikinci matris
; m.ali akcayol - 26.07.2007
;
; 1   2   3   5   7   D
;       X       = 
; 3   8   2   4   19  2F
;
                        
org 0100h
mov [0100h],1
mov [0101h],2
mov [0102h],3
mov [0103h],8
mov [0104h],3
mov [0105h],5
mov [0106h],2
mov [0107h],4

mov al,[0100h]
mul [0102h]
mov bl,al
mov al,[0101h]
mul [0106h]
add al,bl
mov [0108h],al

mov al,[0100h]
mul [0105h]
mov bl,al
mov al,[0101h]
mul [0107h]
add al,bl
mov [0109h],al

mov al,[0102h]
mul [0104h]
mov bl,al
mov al,[0103h]
mul [0106h]
add al,bl
mov [010Ah],al

mov al,[0102h]
mul [0105h]
mov bl,al
mov al,[0103h]
mul [0107h]
add al,bl
mov [010Bh],al

hlt
