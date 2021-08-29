org 0100h
mov [0100h], word ptr 121   ; 1.sayi
mov [0102h], word ptr 235   ; 2.sayi
mov bx,[0100h]                
mov ax,[0102h]  
mov dl,2                    ; bolen (2)
mov cx,0                    ; kalanlarin toplami saklanacak        
cmp bx,0                    ; 1.sayi sifirmi?
jz bitis                    ; sifirsa bitir
dongu:                      ; her dongude 1.sayi iki katina cikar 2.sayi 2'ye bolunur
    cmp ax,0                ; 2.sayi sifirsa veya dongude sifir olduysa bitir
    jz bitis
    div dl                  ; 2.sayi 2'ye bolunur
    cmp ah,0                ; kalan kontrol ediliyor
    jz atla                 ; kalan yoksa ekleme yapmadan devam et
    add cx,bx               ; kalan 1 ise 1.sayiyi sonuca ekle
    atla:                   
        add bx,bx           ; 1.sayiyi iki katina cikar
        xor ah,ah           ; bir onceki islemden kalani sifirla
        jmp dongu           
bitis:  
mov [0104h],cx              ; sonucu bir sonraki adrese kaydet
hlt
    
