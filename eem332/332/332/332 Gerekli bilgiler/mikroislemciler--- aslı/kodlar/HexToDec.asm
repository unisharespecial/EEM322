; 16 lik tabandaki sayiyi 10 luk tabana cevirir
; ekrana 10 luk tabanda yazilir
; m.ali akcayol - 23.07.2007

MACRO YAZDIR
MOV AH, 2
DONGU:
    POP BX      ; soldan saga dogru sayi pop edilir
    MOV DL, BL  ; yazdirilacak deger
    ADD DL, 48  ; 48 eklenerek karakter karsiligi bulundu
    INT 21h
    DEC CL      ; sagdaki basamak icin azaltildi
    CMP CL,0    ; sifirsa en sagdaki basamak yazilmistir
    JNE DONGU
ENDM YAZDIR

org 0100h
mov ax, 231h    ; 10 luk tabana donusturulecek sayi
mov dl,10       ; bolme icin
mov cl,0        ; kac defa bolme yapildigini tutar
basa:           ; her dongude 10 luk sayinin 1 basamagi hesaplanir
    inc cl      ; basamak artirildi
    div dl      ; kalan bulunacak
    mov bl,ah   ; kalan sagdaki basamak degeri
    push bx     ; sagdan sola dogru sayi push edilir
    cmp al,10   ; bolum sonucu 10 dan kucukse son basamak bulundu
    jb atla     ; son basamaksa atla
    xor ah,ah   ; kalani sifirla basa don
    jmp basa    ; yeni basamak hesapla
atla:    
inc cl
mov bl,al       ; son basamakta stack a push edilir
push bx
YAZDIR          ; yazdirma islemi
hlt

