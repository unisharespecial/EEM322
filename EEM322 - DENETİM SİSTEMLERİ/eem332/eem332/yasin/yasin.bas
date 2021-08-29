'****************************************************************
'*  Name    : UNTITLED.BAS                                      *
'*  Author  : [select VIEW...EDITOR OPTIONS]                    *
'*  Notice  : Copyright (c) 2008 [select VIEW...EDITOR OPTIONS] *
'*          : All Rights Reserved                               *
'*  Date    : 14.05.2008                                        *
'*  Version : 1.0                                               *
'*  Notes   :                                                   *
'*          :                                                   *
'****************************************************************
trisa=%00011000
trisb=%10000000
SYMBOL  BIR=PORTA.3
SYMBOL  IKI=PORTA.4
SYMBOL  UC=PORTB.7
T VAR word
ZAMAN var byte
BILGI var byte
sayi var byte
x var byte
t=4000
LED var byte
porta=4
portb=%00111111
;****************************************************************
BASLA:
    if uc=0 then ayar
    if bir=0 then   
    pause 75
    count bir,t,bilgi
    x=bilgi
    gosub al
    portb=sayi
    endif
    goto basla  
    
AL:    LOOKUP X,[63,6,91,79,102,109,125,7,127,111,99,57],SAYI :RETURN    
    
AYAR:
    portb=%01000000
    if bir=0 then art
    if iki=0 then azal
    goto ayar
art:
    t=t+1000
    if t=8000 then
    t=7000
    endif
    porta=porta+1
    if porta=8 then
    porta=7
    endif
    while bir=0
    wend
    pause 100
bekle:
    if uc=0 then cik
    if bir=0 then art
    if iki=0 then azal
    goto bekle
cik:pause 50
    while uc=0
    wend 
    portb=%00111111
       goto basla
azal:    
    t=t-1000
    if t=0 then
    t=1000
    endif
    porta=porta-1
    if porta=0 then
    porta=1
    endif
    while iki=0
    wend
    pause 100
bekle1:
    if uc=0 then cik1
    if iki=0 then azal
    if bir=0 then art
    goto bekle1
cik1:pause 50
    while uc=0
    wend 
    portb=%00111111
   goto basla
    

