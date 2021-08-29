; 10000 kisiye ait ogrenim durumu bilgileri 
; hafizaya kaydedilmistir. 
; Ogrenim durumu LISANSUSTU icin 'M', 
; UNIVERSITE icin 'U', 
; LISE icin 'L' 
; ILKOGRETIM icin 'I' girilmistir. 
; Herbir ogrenim durumu icin kisi sayisini bulup 
; tumunu buyukten kucuge sirali olarak 10'luk tabanda ekrana yazar.
; m.ali akcayol - 26.07.2007

MACRO YAZDIR HEXSAYI
    MOV AX,HEXSAYI  ; sayi 10 a bolunerek her seferinde kalan
    MOV DL,10       ; alinmistir. 
    MOV CL,0
    DONGU:
        DIV DL
        MOV BL,AH
        XOR AH,AH
        XOR BH,BH
        PUSH BX     ; stack'a once birler basamagi atilir
        INC CL
        CMP AL,10
        JNB DONGU
    MOV BL,AL
    XOR BH,BH
    PUSH BX
    INC CL
    
    MOV AH,2
    MOV DL,' '
    INT 21H         ; bosluk verildi
    DONGU2:
        POP DX       ; stack'tan once yuzler basamagi alinir
        ADD DX,30H   ; karakter karsiligi hesaplaniyor
        MOV AH,2     ; karakter yazdirma islemi yapiliyor
        INT 21H
        DEC CL   
        CMP CL,0
        JE CIKIS
        JMP DONGU2
    CIKIS:
ENDM YAZDIR

org 0100h
kayitM db 2485 dup('M')
kayitU db 2459 dup('U')
kayitL db 2541 dup('L')
kayitI db 2515 dup('I')
xor bx,bx   ; lisansustu
xor cx,cx   ; universite
xor dx,dx   ; lise
xor di,di   ; ilkogretim
mov si,0
dongubasi:              ; her dongude bir karakter karsilastirilir
    mov al,[0100h+si]
    cmp al,'M'          ; Lisansustu
    je lisansustu        
    cmp al,'U'          ; Universite
    je universite
    cmp al,'L'          ; Lise
    je lise
    cmp al,'I'          ; Ilkogretim
    je ilkogretim
    lisansustu:
        inc bx          ; Lisansustu sayisi artirildi
        jmp devam
    universite:
        inc cx          ; Universite sayisi artirildi
        jmp devam
    lise:
        inc dx          ; Lise sayisi artirildi
        jmp devam
    ilkogretim:
        inc di          ; Ilkogretim sayisi artirildi
    devam:
        inc si          ; Sonraki karakter
        cmp si,10000    ; Hepsi kontrol edildiyse donguden cik
        jb dongubasi
mov ah,4                ; 4 farkli karakter icin
tekrar:
    xor si,si           ; si gecici sayi tutmak icin kullanilacak
    cmp bx,0            ; her yazilan -1 yapilacak
    jl atlaM            ; -1 ise onceden yazilmistir
    cmp si,bx           ; Lisansustu degeri mevcuttan buyukse onu al
    ja atlaM            ; degilse degistirme yapma
    mov si,bx           ; yeni en buyuk lisansustu
    mov al,'M'          ; bu donguler 4 defa tekrarlanir
atlaM:                  ; her defasinda kalanlardan en buyugu yazilir
    cmp cx,0            
    jl atlaU
    cmp si,cx
    ja atlaU
    mov si,cx
    mov al,'U'
atlaU:
    cmp dx,0
    jl atlaL
    cmp si,dx
    ja atlaL
    mov si,dx
    mov al,'L'
atlaL:
    cmp di,0
    jl atlaI
    cmp si,di
    ja atlaI
    mov si,di
    mov al,'I'
atlaI:
    cmp al,'M'
    jne MGec
    mov bx,-1           ; yazilana -1 atanir 
	pusha 
	call yenisatir
	mov dx, offset msgM
	mov ah, 9
	int 21h             ; lisansustu ise ilgili mesaj yazilir
	popa 
MGec:
    cmp al,'U'
    jne UGec
    mov cx,-1           ; yazilana -1 atanir
	pusha 
	call yenisatir
	mov dx, offset msgU
	mov ah, 9
	int 21h             ; universite ise ilgili mesaj yazilir
	popa
UGec:
    cmp al,'L'
    jne LGec
    mov dx,-1           ; yazilana -1 atanir
    pusha
	call yenisatir
	mov dx, offset msgL
	mov ah, 9
	int 21h             ; lise ise ilgili mesaj yazilir
	popa
LGec:
    cmp al,'I'
    jne IGec
    mov di,-1           ; yazilana -1 atanir 
	pusha  
	call yenisatir
	mov dx, offset msgI
	mov ah, 9
	int 21h             ; ilkogretim ise ilgili mesaj yazilir
	popa 
IGec: 
    pusha 
    YAZDIR SI           ; toplam adet degeri yazilir
    popa
dec ah
cmp ah,0
je bitis
jmp tekrar
bitis:
msgM db "LISANSUSTU = $"   
msgU db "UNIVERSITE = $"
msgL db "LISE = $"
msgI db "ILKOGRETIM = $"
hlt

yenisatir proc 
    mov ah,2
    mov dl, 0Dh             ; return
    int 21h                 
    mov dl, 0Ah             ; yeni satir
    int 21h 
    ret
yenisatir endp 