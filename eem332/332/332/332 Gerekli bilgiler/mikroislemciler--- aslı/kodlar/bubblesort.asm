; hafizada yeralan toplam 100 karakterden
; ADET ile belirtilen kadarini kendi 
; yerinde siralayan algoritma - bubblesort
; m.ali akcayol                  
; 28.06.2007


org 0100h
dizi0 db 'v','a','z','b','t','r','z','k','m','a'
dizi1 db 'v','a','z','b','t','r','z','k','m','a'
dizi2 db 'v','a','z','b','t','r','z','k','m','a'
dizi3 db 'v','a','z','b','t','r','z','k','m','a'
dizi4 db 'v','a','z','b','t','r','z','k','m','a'
dizi5 db 'v','a','z','b','t','r','z','k','m','a'
dizi6 db 'v','a','z','b','t','r','z','k','m','a'
dizi7 db 'v','a','z','b','t','r','z','k','m','a'
dizi8 db 'v','a','z','b','t','r','z','k','m','a'
dizi9 db 'v','a','z','b','t','r','z','k','m','a'
        
ADET dw 9                   ; ilk 10 karakter siralanir

mov dx,ADET                 ; eleman sayisi-1
call ekranayazdir

dongu:                      ; toplam eleman sayisi kadar tekrar
    mov cx,0                ; siralanmamis eleman sayisi
    icdongu:                ; kalan eleman sayisi kadar tekrar         
        mov si,cx
        mov al,[dizi0+si]   ; soldaki eleman
        mov bl,[dizi0+si+1] ; sagdaki eleman
        cmp al,bl
        jbe devam           ; soldaki kucukse degistrme yapma
        call degistir       ; soldaki buyukse degistir
        devam:               
            inc cx          ; siralanmamis elemanlarda bir artir
            cmp cx,dx       ; siralanmamis elemanlarin sonuna geldimi
            jnb icdongusonu ; siralanmamis elemanlarin sonu
    jmp icdongu             ; siralanmamis eleman devam ediyor
    icdongusonu:            ; ic dongude siralanmamis eleman kalmadi    
    dec dx                  ; sirasiz kalan eleman sayisini bir azalt
    cmp dx,0                ; sirasiz eleman sayisi 0 mi?
    je bitir                ; sirasiz eleman sayisi 0 ise bitir
    jmp dongu               ; sirasiz eleman varsa basa git
bitir: 
call ekranayazdir           ; sirali yazdir
hlt                         ; program bitisi

degistir proc               ; yanyana iki karakter yer degistirir
    mov [dizi0+si],bl
    mov [dizi0+si+1],al 
    ret
degistir endp

ekranayazdir proc
    push dx                 ; dl ye deger atanacak
    mov cx, 0               ; karakter sayaci
    mov ah, 2               ; int 21, ah=2, ekrana karakter yazdir
    tekrar:  
        mov si,cx
        mov dl, [dizi0+si]
        int 21h             ; int 21, ah=2, ekrana karakter yazdir
        inc cx
        cmp cx, ADET
        ja cikis
    jmp tekrar  
    cikis:  
    mov dl, 0Dh             ; return
    int 21h                 
    mov dl, 0Ah             ; yeni satir
    int 21h
    pop dx                  ; dl nin eski degeri alindi
    ret    
ekranayazdir endp   

