; binary search --- 
; sirali bir dizide en cok log(2)sayiadedi 
; kadar kontrolle aranan sayinin olup
; olmadigini bulur
; m.ali akcayol
; 29.06.2007


org 0100h
mov [0100h], 1
mov [0101h], 2
mov [0102h], 3
mov [0103h], 4
mov [0104h], 6
mov [0105h], 8
mov [0106h], 9
mov [0107h], 10
mov [0108h], 11
mov [0109h], 13
mov [010Ah], 14
mov [010Bh], 15
mov [010Ch], 16
mov [010Dh], 17
mov [010Eh], 19
mov [010Fh], 20
mov [0110h], 22
mov [0111h], 23
mov [0112h], 25
mov [0113h], 27
mov [0114h], 28
mov [0115h], 30

mov dl,2        ; bolen
mov dh,28       ; aranan sayi   
mov bx,0100h    ; en kucuk adres
mov cx,0115h    ; en buyuk adres
mov si,0100h

mov ax,cx       ; eleman sayisi hesaplaniyor
dec bx
sub ax,bx
div dl          ; ortadaki sayi bulunuyor
xor ah,ah       ; kalan atiliyor
add si,ax       ; ortadaki sayinin adresi
dongu:
    cmp [si],dh     ; ortadaki sayi arananla karsilastiriliyor
    jb sagtaraf     ; kucukse saga gidilir
    ja soltaraf     ; buyukse sola gidilir
    je bulundu      ; esitse bulunmustur
    sagtaraf:
        mov bx,si
        mov ax,cx       ; eleman sayisi hesaplaniyor
        sub ax,bx
        div dl          ; ortadaki sayi bulunuyor
        cmp al,0
        jz kalanal1
        xor ah,ah       ; kalan atiliyor
        add si,ax       ; ortadaki sayinin adresi
        jmp dongu       ; basa don
        kalanal1:       ; son kalan eleman kontrol ediliyor
            xchg al,ah
            add si,ax
            cmp [si],dh
            je bulundu
            jne sayiyok
    soltaraf:
        mov cx,si
        mov ax,cx       ; eleman sayisi hesaplaniyor
        sub ax,bx
        div dl          ; ortadaki sayi bulunuyor
        cmp al,0
        jz kalanal2
        xor ah,ah       ; kalan atiliyor
        sub si,ax       ; ortadaki sayinin adresi
        jmp dongu       ; basa don
        kalanal2:       ; son kalan eleman kontrol ediliyor
            xchg al,ah
            sub si,ax
            cmp [si],dh
            je bulundu
            jne sayiyok

; yazdirma islemleri

bulundu:                
    mov dx, offset mesajvar
    mov ah, 9
    int 21h
    ret
    mesajvar db "sayi bulundu $"         
    jmp cikis         
sayiyok:
    mov dx, offset mesajyok
    mov ah, 9
    int 21h 
    ret
    mesajyok db "sayi yok $"         
cikis:
hlt
