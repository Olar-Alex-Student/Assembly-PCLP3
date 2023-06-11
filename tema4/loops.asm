;;;Tema 4 
;;;Aplica?ia nr1

;;;Aplica?ia afi?eaz? un model grafic format dintr-un ?ir repetitiv
;;;de cifrele 1, 2 ?i 3 ?n consol?, utiliz?nd instruc?iunile de afi?are a caracterelor
;;;Aceasta utilizeaz? bucle pentru a controla num?rul de repeti?ii ?i pentru a crea
;;;un model vizual repetitiv
org 100h
; org 100h reprezint? adresa de ?nceput a aplica?iei propuse
mov bx, 0
; ini?ializare registrului 'bx' cu '0'
mov cx, 2
; ini?ializare registrului 'cx' cu '2'
k1: 
; eticheta 'k1' marcheaz? ?nceputul primei bucle 
    add bx, 1         
    ; increment?m registrul 'bx' cu '1'
    mov al, '1'
    ; memoreaz? caracterul '1' ?n registrul 'al'
    mov ah, 0eh
    ; seteaz? valoarea '0eh' pentru registrul 'ah' pentru a afi?a caracterul 
    int 10h 
    ; apel al serviciului de afi?are a caracterelor din BIOS
    push cx
    ; pune valoarea din registrul 'cx' pe stiv?
    mov cx, 2
    ; ini?ializeaz? registrul 'cx' cu valoarea 2
      k2: add bx, 1  
      ; eticheta a doua a buclei 'k2' ?i incrementeaz? cu valoarea '1' registrul 'bx' 
      mov al, '2'
      ; memoreaz? caracterul '2' ?n registrul 'al'
      mov ah, 0eh
      ; seteaz? valoarea '0eh' pentru registrul 'ah' pentru a afi?a caracterul 
      int 10h 
      ; apel al serviciului de afi?are a caracterelor din BIOS
      push cx
      ; pune valoarea din registrul 'cx' pe stiv?
      mov cx, 2
      ; ini?ializeaz? registul 'cx' cu 2 
         k3: add bx, 1 
         ; eticheta a treia a buclei 'k3' ?i incrementeaz? cu valoarea '1' registrul 'bx' 
         mov al, '3'
         ; memoreaz? caracterul '3' ?n registrul 'al'
         mov ah, 0eh
         ; seteaz? valoarea '0eh' pentru registrul 'ah' pentru a afi?a caracterul 
         int 10h 
         ; apel al serviciului de afi?are a caracterelor din BIOS
         loop k3
         ; decrementeaz? registrul 'cx' ?i face salt la eticheta 'k3' p?n? c?nd registrul 'cx' este '0'    
      pop  cx
      ; elimin? valoarea de pe stiv? a registurlui 'cx'
      loop  k2      
      ; decrementeaz? registrul 'cx' ?i face salt la eticheta 'k2' p?n? c?nd registrul 'cx' este '0'    
    pop cx
    ; elimin? valoarea de pe stiv? a registurlui 'cx'
loop k1         
; decrementeaz? registrul 'cx' ?i face salt la eticheta 'k1' p?n? c?nd registrul 'cx' este '0'    
mov ah, 1
; mut? valoarea '1' ?n registrul 'ah' pentru a a?tepta ap?sarea unei taste
int 21h
.exit
; ie?ire din aplica?ie
