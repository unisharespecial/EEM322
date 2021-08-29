LIST p=16F84A 
  INCLUDE "P16F84A.INC" 
 
  __CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC 
 
  j  EQU 0x0c 
  k  EQU 0x0d 
   
  ORG     0x00 
   
  BSF STATUS,5 
  MOVLW 0x00 
  MOVWF TRISB 
  BCF STATUS,5 
   
LEDonoff:
movlw b'00000001'  
  movwf PORTB 
  call delay 
   
  movlw b'00000000' 
  movwf PORTB 
  call delay 
  goto LEDonoff 
   
   
delay: 
  movlw d'200' 
  movwf j  
jloop: 
  movwf k  
kloop: 
  decfsz k,f 
  goto kloop 
  decfsz j,f 
  goto jloop 
return 
 
End