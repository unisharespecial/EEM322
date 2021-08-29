org 0100h
mov [0100h],'7'
mov [0101h],'5'
mov [0102h],'9'
mov [0103h],'3'
mov [0104h],'2'
mov [0105h],'7'
mov [0106h],'8'
mov [0107h],'6'
mov [0108h],'5'
mov [0109h],'1'
mov [010Ah],'3'

call ekranayazdir   ; baslangic durumunu yazdir

mov dx,0100h        ; soldaki gosterge
mov cx,0100h        ; kontrol edilen 
mov bx,0100h        ; en kucuk sayinin adresi icin 

dongu:              ; her sayinin dogru yeri bulunur
    mov si, cx      
    mov al,[si]     
    cmp al,[bx]     ; bir sonraki sayi en kucukle karsilastirilir
    jae atla        ; buyuk veya esitse bir sonrakine gec
    mov bx,cx       ; yeni sayi en kucukten kucukse en kucuk yap
    inc cx          ; bir sonrakine gec
    cmp cx,010Bh    ; sona gelindimi?
    je yerdegistir  ; sonda ise yer degistir
    jmp dongu       ; sona gelinmedi basa don
    yerdegistir:
        cmp bx,dx
        je ayniatla ; ayni eleman yer degistirme
            call degistir   ; dx ile bx yer degistirir
        ayniatla:
        inc dx          ; soldaki gosterge bir ilerler
        cmp dx, 010Ah   ; sona gelindimi?
        je cikis        ; son elemanda sirasina konduysa cikis yap 
        mov cx,dx       ; siralanmamis sayinin adresi cx bx e atilir
        mov bx,dx
        jmp dongu       ; basa don 
    atla:               ; yeni sayi buyuk veya esitse bir sonrakini sec
        inc cx
        cmp cx,010Bh    ; sona gelindimi?
        je yerdegistir  ; son elemanda en kucukle karsilastirildigi
        jmp dongu       ; yer degirme yapilir ve basa donulur
          
cikis:
    call ekranayazdir
hlt    
                              
degistir proc
    push ax
    push si
    mov si,dx
    mov al,[si]
    mov ah,[bx]
    mov [si],ah
    mov [bx],al
    pop si
    pop ax
    ret    
degistir endp    

ekranayazdir proc
    mov cx, 0               ; karakter sayaci
    mov ah, 2               ; int 21, ah=2, ekrana karakter yazdir
    tekrar:  
        mov si,cx
        mov dl, [0100h+si]
        int 21h             ; int 21, ah=2, ekrana karakter yazdir
        inc cx
        cmp cx,11
        je yazmacikisi
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

                              