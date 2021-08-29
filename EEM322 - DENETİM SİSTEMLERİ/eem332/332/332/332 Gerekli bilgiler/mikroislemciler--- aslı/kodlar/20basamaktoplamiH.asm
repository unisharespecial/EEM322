; hafizada yeralan ve herbirisi 20 rakamdan olusan
; 16'lik tabandaki iki sayinin toplamini yapar.
; ilk sayi 0100h-0109h
; ikinci sayi 010Ah-0113h
; sonuc 0114h-011Dh
; m.ali akcayol                  
; 01.07.2007

org 0100h
mov [0100h],8A76h
mov [0102h],6557h
mov [0104h],1A98h
mov [0106h],713Eh
mov [0108h],8797h
mov [010Ah],2587h
mov [010Ch],8B96h
mov [010Eh],2588h
mov [0110h],46D1h
mov [0112h],9854h

mov si, 0108h           ; 1.sayinin en sagdaki 4 rakam (1 word) aliniyor
mov bx,[si]         
add bx,[si+000Ah]       ; 2.sayinin en sagdaki 4 rakami ile toplaniyor
mov [si+0014h],bx       ; sonuc hafizaya yaziliyor
jnc atla1               ; carry=0 ise atla
    mov dx,1            ; sub isleminden once carry dx'e saklaniyor
    atla1:              
sub si,2                ; sola dogru 4 rakam (1 word) gidiliyor
dongu:
    mov bx,[si]         ; 1.sayinin onceki 4 rakami (1 word) aliniyor
    add bx,[si+000Ah]   ; 2.sayinin onceki 4 rakami ile toplaniyor 
    add bx,dx           ; varsa carry ekleniyor
    xor dx,dx           ; saklanan carry degeri sifirlaniyor
    mov [si+0014h],bx   ; sonuc hafizaya yaziliyor
    jnc atla2           ; carry=0 ise atla
      mov dl,1
    atla2:
        sub si,2        ; sola dogru 4 rakam (1 word) gidiliyor
        cmp si,0100h    ; en sola gelindimi?
        jae dongu       ; gelinmediyse basa doner
call mesajyaz
hlt      

mesajyaz proc
    mov dx, offset mesajvar
    mov ah, 9
    int 21h
    ret
    mesajvar db "toplama islemi tamamlandi... $"         
mesajyaz endp