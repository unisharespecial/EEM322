; bir dizideki tek sayilari dizinin on kismina
; cift sayilari arka kismina alir
; m.ali akcayol                  
; 01.07.2007

org 0100h
mov [0100h],'1'
mov [0101h],'4'
mov [0102h],'2'
mov [0103h],'8'
mov [0104h],'7'
mov [0105h],'3'
mov [0106h],'5'
mov [0107h],'9'
mov [0108h],'2'
mov [0109h],'6'

call ekranayazdir   ; baslangic durumunu yazdir

mov bx,0100h        ; ilk sayi
mov cx,0109h        ; son sayi
mov dl,2            ; bolen

teksayidongu:       ; soldaki ilk cift sayiyi bulur
    mov si, bx
    mov al,[si]     
    xor ah,ah       ; onceki bolme sonucu atiliyor
    div dl          
    cmp ah,0        ; bolmede kalan varmi?
    jnz devamtek        ; kalan varsa tektir
    jmp ciftsayidongu   ; kalan yoksa cifttir
    
    devamtek:
        inc bx
        cmp bx,cx
        je cikis
        jmp teksayidongu
        
ciftsayidongu:
    mov si,cx
    mov al,[si]
    xor ah,ah
    div dl
    cmp ah,0
    jz devamcift
    jmp degistir
    
    devamcift:
        dec cx
        cmp bx,cx
        je cikis
        jmp ciftsayidongu
        
degistir:
    push ax
    mov al,[bx]
    mov ah,[si]
    mov [bx],ah
    mov [si],al
    pop ax
    jmp teksayidongu
          
cikis:
call ekranayazdir
hlt    
                              
ekranayazdir proc
    mov cx, 0               ; karakter sayaci
    mov ah, 2               ; int 21, ah=2, ekrana karakter yazdir
    tekrar:  
        mov si,cx
        mov dl, [0100h+si]
        int 21h             ; int 21, ah=2, ekrana karakter yazdir
        inc cx
        cmp cx,9
        ja yazmacikisi
        mov dl, ','
        int 21h             ; int 21, ah=2, ekrana karakter yazdir
    jmp tekrar  
    yazmacikisi:  
    mov dl, 0Dh             ; return
    int 21h                 
    mov dl, 0Ah             ; yeni satir
    int 21h
    ret    
ekranayazdir endp   

                              