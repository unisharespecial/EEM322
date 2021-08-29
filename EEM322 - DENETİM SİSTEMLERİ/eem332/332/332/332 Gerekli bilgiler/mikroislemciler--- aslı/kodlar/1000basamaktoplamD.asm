; hafizada yeralan ve herbirisi 1000 rakamdan olusan
; 10'luk tabandaki iki sayinin toplamini yapar.
; ilk sayi 1000-1999
; ikinci sayi 2000-2999
; sonuc 3000-4000
; m.ali akcayol                  
; 04.07.2007

org 0100h      
ADET equ 1000           ; toplam rakam sayisi
mov dl,10               ; sayilari onluk tabanda gostermek icin

call baslangic          ; baslangic degerleri atanir
call degerata           ; iki sayinin degerleri atanir
call topla              ; toplama islemi yapilir
call mesajyaz           ; kullaniciya islemin bittigi bildirilir

hlt

topla proc    
    call baslangic
    mov bx,0            ; bl'de kalan saklanacak
    mov cx,ADET         ; cx sayaci rakam sayisina esitleniyor
    sonrakibasamak:
        mov al,[si]         ; ilk sayinin en sagdaki basamagi
        add al,[si+1000]    ; ikinci sayinin en sagdaki basamagiyla toplaniyor
        add al,bl           ; onceki basamaktan gelen toplandi
        div dl              ; toplam 10'a bolunerek kanal alinacak
        mov [si+2001],ah    ; elde olursa 1001 byte gerekir o yuzden 2001
        xor ah,ah           ; bir sonraki bolme icin 
        mov bl,al           ; kalan saklandi sonraki basamaga eklenecek
        dec si              ; onceki basamaklara gecilir
        loop sonrakibasamak
    mov [si+2001],bl        ; elde varsa bir onceki adrese yazildi    
    ret    
topla endp

baslangic proc
    mov cx,ADET     ; her sayidaki rakam sayisi
    mov si,1000     ; ilk dizinin en soldaki rakami
    add si,cx       ; ilk dizinin en sagdaki rakami
    ret
baslangic endp         

degerata proc       ; dizilere baslangic degerleri atar
    dongu:
        mov ax,cx   ; her eleman (cx mod 10) ile belirleniyor
        div dl      
        mov al,ah   ; kalan deger alinacak
        xor ah,ah
        mov [si],al         ; ilk diziye
        mov [si+1000],al    ; ikinci diziye
        dec si              ; bir soldaki rakam
        loop dongu
        ret
degerata endp  

mesajyaz proc
    mov dx, offset mesajvar
    mov ah, 9
    int 21h
    ret
    mesajvar db "toplama islemi tamamlandi... $"         
mesajyaz endp
