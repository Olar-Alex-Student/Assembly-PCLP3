;;;Tema 5 
;;;Aplica?ia nr2

;;;Aplica?ia utilizeaz? driverul mouse-ului pentru a detecta ap?sarea butoanelor ?i pentru a afi?a un mesaj corespunz?tor pe ecran
;;;Programul ruleaz? ?ntr-o bucl? infinit? p?n? c?nd se apas? o tast?
.model small
; seteaz? modul de memorie la 'small'
.stack 100h
; stabile?te dimensiunea stivei la '1024' de octe?i
.data
; reprezint? locul unde vor fi declarate datele utilizate

left  db 'LEFT BUTTON PRESSED',13,10,'$'
; declararea variabilei 'left'
right db 'RIGHT BUTTON PRESSED',13,10,'$'
; declararea variabilei 'right'
.code
; locul unde ?ncepe declararea codului
  mov  ax, @data
  ; ini?ializarea registrului 'ax' cu segmentul de date
  mov  ds, ax
  ; setarea segmentului de date cu valoarea din registrul 'ax'
  mov  ax, 0
  ; setarea registrului 'ax' la 0
  int  33h
  ; apelarea serviciului mouse driver pentru ini?ializare 
  mov  ax, 1
  ; setarea registrului 'ax' la 1
  int  33h  
  ; apelarea serviciului mouse driver pentru afi?area pozi?iei cursorului 

while:                   
; eticheta 'while'
  mov  ax, 3
  ; setarea registrului 'ax' la 3
  int  33h   
  ; apelarea serviciului mouse driver pentru citirea st?rii mouse-ului
  mov  ax, bx  
  ; copierea valorii din registrul 'bx' ?n registrul 'ax'
  and  ax, 0000000000000001b 
  ; efectuarea opera?iei 'AND' ?ntre registrul 'ax' ?i '0000000000000001b'
  jz   check_right 
  ; sare la eticheta 'check_right' dac? rezultatul este 0 
  mov  ah, 9     
  ; setarea registrului 'ah' la 9, care reprezint? serviciul DOS pentru afi?area unui ?ir de caractere
  lea  dx, left
  ; calculeaz? adresa de ?nceput a 'left' ?n registrul 'dx'
  int  21h
  ; apeleaz? serviciul de afi?are a caracterelor
check_right:
; eticheta 'check_right'
  mov  ax, bx
  ; copiaz? valoarea din registrul 'bx' ?n registrul 'ax'
  and  ax, 0000000000000010b 
  ; efectuarea opera?iei 'AND' ?ntre registrul 'ax' ?i '0000000000000010b'
  jz   check_key  
  ; sare la eticheta 'check_key'
  mov  ah, 9     
  ; setarea registrului 'ah' la 9, care reprezint? serviciul DOS pentru afi?area unui ?ir de caractere
  lea  dx, right
  ; calculeaz? adresa de ?nceput a 'right' ?n registrul 'dx'
  int  21h
  ; apeleaz? serviciul de afi?are a caracterelor
check_key:
; eticheta 'check_key'
  mov  ah, 0bh
  ; mut? valoarea '0bh' ?n registrul 'ah' pentru citirea tastelor ap?sate
  int  21h                                     
  ; apeleaz? serviciul pentru citirea tastelor ap?sate
  cmp  al, 0      
  ; compar? valoarea registrului 'al' cu 0
  jz   while
  ; face salt la eticheta 'while' dac? rezultatul este 0

  mov  ax, 4c00h  
  ; setarea registrului 'ax' la '4c00h', care reprezint? serviciul de ?nchidere a programului
  int  21h            
  ; apeleaz? serviciul DOS pentru ?nchiderea programului
