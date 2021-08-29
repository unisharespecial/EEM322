; Girilen 3 basamakli bir sayidan
; kucuk asal sayilari bulup ekrana yazan program
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
buffer db 4,?,4 dup(1)

mov bl,10  
mov dx,offset buffer
mov ah,0Ah
int 21h             ; 3 basamakli bir sayi girildi           

mov al,[buffer+2]   ; yuzler basamagi alindi
sub al,30h          ; karakter sayisal degere cevrildi
mul bl              ; 10 la carpildi
mul bl              ; 100 le carpildi
mov cx,ax           ; 100 ler basamagi cx e aktarildi

mov al,[buffer+3]   ; onlar basamagi alindi
sub al,30h           
mul bl
add cx,ax

mov al,[buffer+4]   ; birler basamagi alindi
sub al,30h 
add cx,ax   ; cx e 3 basamakli sayi aktarildi

mov ah,2    ; 1 ve 2 dogrudan yazdiriliyor
mov dl,' '
int 21h
mov dl,'0'
int 21h
mov dl,'1'  ; 01
int 21h
mov dl,' '
int 21h
mov dl,'0'
int 21h
mov dl,'2'  ; 02
int 21h

mov dl,3    ; 3 ve ustu sayilar kontrol edilecek
xor dh,dh

disdongu:       ; her sayi icin tekrarlanir
    mov bl,2    ; bolme islemi 2 ile baslar
    icdongu:
        mov ax,dx   ; dx kontrol edilen sayiyi tutar  
        div bl      ; ax bolme islemleri icin kullanildi
        cmp ah,0    ; kalan kotrol edildi
        je sonrakisayi    ; kalan yoksa asal degildir  
        inc bl      ; bolen artiriliyor
        cmp bl,dl   ; bolen sayiya esitse asal sayidir 
        je asalsayi
        jmp icdongu ; degilse yeni bolenle devam edilir
        asalsayi:
            push dx ; dx ve cx kullanildigi icin stack'a atildi 
            push cx
            YAZDIR DX   ; sayi 10 luk tabanda yazdiriliyor
            pop cx
            pop dx
        sonrakisayi:
        inc dl      ; sonraki sayiya geciliyor
        cmp dx,cx   ; girilen sayiya esitse program biter
        jne disdongu    
hlt
