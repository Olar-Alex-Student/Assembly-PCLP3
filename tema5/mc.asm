;;;Tema 5 
;;;Aplicatia nr1

;;;Aplicatia are scopul de a utiliza driverul mouse-ului pentru a citi ?i afi?a pozi?ia cursorului pe ecran
;;;Dac? mouse-ul nu este detectat, se afi?eaz? un mesaj corespunz?tor
;;;Pentru a ie?i din program, se apas? butonul de ie?ire

org 100h    
  ; adresa de ?nceput a aplica?iei propuse
  mov ax,3
  ; se seteaz? valoarea registrului 'ax' la 3, corespunz?toare modului video-text
  int 10h
  ; se apeleaz? serviciul pentru modulul video-text
  xor ax,ax
  ; se seteaz? valoarea registrului 'ax' la 0  
  int 33h
  ; se apeleaz? serviciul de mouse-driver  
  
  cmp ax,0            
  ; se compar? 'ax' cu 0, verific?nd astfel dac? mouse-ul este detectat
  jz nomouse      
  ; dac? este 0, se sare la eticheta 'nomouse'  
    
  mov ax,1            
  ; se seteaz? serviciul pentru ini?ializarea mouse-ului
  int 33h
  ; se apeleaz? serviciul pentru ini?ializarea mouse-ului
     
main:
  ; eticheta 'main'
  xor bh,bh        
  ; se initializeaz? registrul 'bh' la 0  
  xor dx,dx
  ; se initializeaz? registrul 'dx' la 0  
  mov ah,2
  ; se seteaz? serviciul pentru setarea pozi?iei cursorului
  int 10h 
  ; se apeleaz? serviciul pentru setarea pozi?iei cursorului
            
  mov ax,3 
  ; se seteaz? serviciul pentru citirea pozi?iei cursorului  
  int 33h  
  ; se apeleaz? serviciul pentru citirea pozi?iei cursorului  
    
  shr cx,3             
  shr dx,3 
  ; se face deplasarea valorii ?nregistrate ?n registrul 'cx' ?i registrul 'dx' la dreapta cu 3 pozi?ii, ceea ce rezult? ?n ?mp?r?irea acestora la 8
  
   
  cmp bx,1  
  ; se compar? valoarea ?nregistrat? ?n registrul 'bx' cu 1, verific?nd astfel dac? a fost ap?sat butonul  
  jz exit
  ; dac? este 1, se sare la eticheta 'exit'
     
  push dx               
  ; se salveaz? pozi?ia ?nregistrat? ?n 'dx' pe stiv?
  mov ax,cx            
  ; se mut? valoarea ?nregistrat? ?n 'cx' ?n 'ax', urm?nd s? fie afi?at? ulterior
  call dispnum
  ; se apeleaz? func?ia pentru afi?area valorii 
  mov ah, 2
  ; se seteaz? serviciul pentru afi?area unui caracter
  mov dl,','
  ; se seteaz? caracterul ',' pentru afi?are 
  int 21h
  ; se apeleaz? serviciul pentru afi?area unui caracter
  pop ax                
  ; se restaureaz? valoarea de pe stiv? ?n registrul 'ax'
  call dispnum          
  ; se apeleaz? func?ia pentru afi?area valorii 
  mov ah,2
  ; se seteaz? serviciul pentru afi?area unui caracter
  mov dl,' '
  ; se seteaz? caracterul ' ' pentru afi?are 
  int 21h
  int 21h
  jmp main              
  ; se sare la eticheta 'main' pentru a relua bucla
  mov ax,2
  ; se seteaz? valoarea 2 ?n registrul 'ax' pentru a ascunde cursorul   
  int 33h
  ; se apeleaz? serviciul de ascundere a cursorului
  jmp exit 
  ; se sare la eticheta 'exit'  
       
nomouse: 
  ; eticheta 'nomouse'
exit:
  ; ie?ire program
  int 20h      
  ; se apeleaz? serviciul de ?nchidere a programului  
      
    
dispnum:
  ; eticheta 'dispnum'                                                      
  mov cx,10           
  ; se seteaz? registrul 'cx' la 10 pentru afi?area valorii ?n zecimal
dn:
  ; eticheta 'dn'
  xor dx,dx
  ; se initializeaz? registrul 'dx' la 0  
  div cx
  ; se ?mparte valoarea ?nregistrat? ?n 'ax' la 10, rezultatul fiind stocat ?n registrul 'al', iar restul ?n registrul 'dx'
  push dx
  ; se salveaz? restul pe stiv? 
  or ax,ax 
  ; se verific? dac? valoarea ?nregistrat? ?n 'ax' este 0 
  jz dd
  ; dac? este 0, se sare la eticheta 'dd'
  call dn
  ; se apeleaz? eticheta 'dn'
dd:
  ; eticheta 'dd'
  pop dx
  ; se scoate restul din stiv? ?i se salveaz? ?n 'dx'
  add dl,30h
  ; se adaug? valoarea 0 pentru a converti restul ?n codul ASCII corespunz?tor cifrei 
  mov ah,2
  ; se seteaz? func?ia pentru afi?area caracterelor
  int 21h
  ; se apeleaz? serviciul pentru afi?area caracterelor
ret
  ; revenire din subrutin?
