	LIST P=16F84A
INCLUDE "P16F84A.INC"
	ORG 0X00                 ;Programý '0x00' dan baþlatýr.
	BSF STATUS,RP0           ;STATUS'ün beþinci bitini 1 yaparak TRISA VE TRISB'nin olduðu BANK1'e geçtik.
	CLRF TRISA               ;TRISA'nýn tüm bitlerini output yaptýk.
	MOVLW B'00000100'        ;Working Registera deðer aldýk.
	MOVWF TRISB              ;Working R. daki deðer ile TRISB'nin ikinci bitini(RB2) input yaptýk.
	BCF STATUS,RP0           ;STATUS'ün beþinci bitini 0 yaparak BANK0'a geçtik.
LOOP1                        ;LOOP1 döngüsü butona basýlý deðil iken (high) çalýþýr.
	MOVLW B'00000101'        ;Working R. 'a B'00000101'(H'05') deðerini aldýk.
	MOVWF PORTA              ;Working R.'daki deðeri PORTA'ya attýk.RA0 ve RA2 bitlerini 1 deðeri yaptýk ve lambalar yandý.
LOOP2                        ;LOOP2 döngüsü butona basýlý iken (low) çalýþýr.
	BTFSC PORTB,2            ;PORTB adresindeki sayýnýn ikinci bitini kontrol eder. Eðer sýfýr(low) ise, kendisinden sonra gelen komutun üzerinden atlar. Deðilse (high) GOTO LOOP1 komutundan devam eder.
	GOTO LOOP1               ;LOOP1 döngüsüne gider.
	MOVLW B'00001010'        ;Working R. 'a B'00001010'(H'10') deðerini aldýk.
	MOVWF PORTA              ;Working R.'daki deðeri PORTA'ya attýk.RA1 ve RA3 bitlerini 1 deðeri yaptýk ve lambalar yandý.
	GOTO LOOP2               ;LOOP2 döngüsünden devam eder.PORTB 'nin ikinci bitindeki (RB2) butonunu kontrol ederek devam eder.
	END                      ;Sonlandýrma komutu.