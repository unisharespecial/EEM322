; radix sort - kelimeleri alfabetik olarak siralar
; m.ali akcayol
; 11.07.2007

org 0100h
kelimeler db 'klf','dfa','fez','zas','ser','akf','kle','mys','mhv','akc'

mov di,0                    ; hangi karakterin karsilatirilmakta oldugunu saklar
mov si,offset kelimeler     ; kelime sayisi kadar dongu icin
mov ch,0                    ; her kelime icin
mov dl,9                    ; siralanmamis eleman sayisi

call ekranayazdir           ; kelimelerin ilk sirasini ekrana yazar

sonrakikelime:              ; her dongude bir sonraki kelimeyi secer
    cmp di,2                ; di=2 ise 3.karakterlere gore siralaniyor
    je karakter3            
    cmp di,1                ; di=1 ise 2.karakterlere gore siralaniyor
    je karakter2            
    cmp di,0                ; di=0 ise 1.karakterlere gore siralaniyor
    je karakter1            
    karakter3:              ; ucuncu karakterlere gore siralaniyor
        mov al,[si-2]       ; ucuncu karaktere gore siralamayi...
        cmp al,[si+3-2]     ; ...birinci ve ikinci karakterleri ayni olanlar arasinda yap
        jne atla            ; birinci karakterler ayni degilse gec
    karakter2:              ; ikinci karakterlere gore siralaniyor 
        mov al,[si-1]       ; ikinci karaktere gore siralamayi...
        cmp al,[si+3-1]     ; ...birinci karakterleri ayni olanlar arasinda yap
        jne atla            ; birinci karakterler ayni degilse gec
    karakter1:              ; ikinci karakterlere gore siralaniyor 
        mov al,[si]         
        cmp al,[si+3]       ; birinci karakterler ayni ikincileri karsilastir
        jbe atla            ; birinci ikinciden kucukse yer degistirme

        push si             ; su andaki si push edilir
        sub si,di              ; yer degisterecek kelimenin ilk karakter adresi
        call yerdegistir
        pop si              ; eski si geri alindi
    atla:
        inc ch              ; bir kelime ilerle
        cmp ch,dl           
        je sonrakitur       ; siralanmamislarin sonuysa bir sonraki tura gec
        add si,3            ; degilse bir sonraki kelimeye gec
        jmp sonrakikelime       
    sonrakitur:             ; kelime sayisi kadar tur yapilir
        dec dl              ; her turda bir kelime dogru yere getirilir (bubble sort)
        cmp dl,0            ; en son tur bittimi?
        je sonrakikarakter  ; bir sonraki karaktere gec
        mov si, offset kelimeler    ; yeni tur
        mov ch,0                    
        jmp sonrakikelime   ; sonraki kelimeye gec
    sonrakikarakter:        ; bir sonraki karaktere gore siralar
        mov dl,9            ; siralanmamis kelime sayisi
        inc di              ; siralanacak yeni kaakter sira nosu
        cmp di,3            ; karakter bittimi? 3=4.karakter
        je bitis            ; evet bitir
        mov si, offset kelimeler    ; ilk kelimenin ilk karakterini gosterir
        add si,di                   ; si her kelimenin di.karakterini gosterir
        mov ch,0                    ; ilk kelimeye gecmek icin 
        jmp sonrakikelime           
bitis:
call ekranayazdir 
call mesajyaz
hlt

yerdegistir proc                    ; si ile verilen kelimeyle yanindakini yer degistir
    push si
    push cx
    mov cl,0
    dongu:
        mov al,[si]
        mov bl,[si+3]
        mov [si],bl
        mov [si+3],al
        inc si
        inc cl
        cmp cl,3
        je cikis
        jmp dongu 
    cikis:    
    pop cx
    pop si       
    ret
yerdegistir endp                               

ekranayazdir proc           ; ekrana 3 karakterlik kelimeleri alt alta yazar
    pusha
    mov cx, 0               ; karakter sayaci
    devam:  
        mov si,cx 
        mov dl, [0100h+si]
        mov ah, 2           
        int 21h             ; int 21, ah=2, ekrana dl'deki karakteri yazar
        inc cx
        cmp cx,30           ; toplam 30 karakter
        je yazmacikisi
        mov ax,cx
        mov bl,3            ; her kelimeden sonra alt satira gecer
        div bl
        cmp ah,0
        jne devam
        mov ah, 2           
        mov dl, 0Dh         ; return
        int 21h                 
        mov dl, 0Ah         ; yeni satir
        int 21h
        jmp devam
    yazmacikisi:
    mov ah, 2           
    mov dl, 0Dh             ; return
    int 21h                 
    mov dl, 0Ah             ; yeni satir
    int 21h
    mov dl, 0Dh             ; return
    int 21h                 
    mov dl, 0Ah             ; yeni satir
    int 21h
    popa
    ret    
ekranayazdir endp   

mesajyaz proc
    mov dx, offset mesaj
    mov ah, 9
    int 21h
    ret
    mesaj db "alfabetik siralama islemi tamamlandi... $"         
mesajyaz endp
