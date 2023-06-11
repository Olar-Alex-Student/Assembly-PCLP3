;;;Tema 4 
;;;Aplicatia nr2

;;;Aceast? aplica?ie prime?te un ?ir de caractere ?i inverseaz? ordinea caracterelor ?n ?ir, apoi afi?eaz? ?irul inversat ?i a?teapt? ca utilizatorul s? apese o tast? pentru a ?ncheia programul.
org 100h
;org 100h reprezint? adresa de ?nceput a aplica?iei propuse
jmp start
;salt la eticheta 'start'

string1 db '!gnirts a si siht$'
;declararea variabilei 'string1' care con?ine ?irul de caractere

start:
;eticheta 'start' unde ?ncepe blocul de instruc?iuni
lea bx, string1
;?ncarc? adresa de ?nceput a ?irului 'string1' ?n registrul 'bx'
mov si, bx
;mut? adresa din registrul 'bx' ?n registrul 'si'

next_byte:
;eticheta 'next_byte' pentru a itera prin fiecare byte din ?ir
cmp [si], '$'
;compar? valoarea de la adresa registrului 'si' cu caracterul terminator de ?ir
je found_the_end
;salt? la eticheta 'found_the_end' dac? s-a ajuns la sf?r?itul ?irului

inc si
;incrementeaz? registrul 'si' pentru a parcurge urm?torul caracter din ?ir
jmp next_byte
;salt? la eticheta 'next_byte' pentru a continua iterarea prin ?ir

found_the_end:
;eticheta 'found_the_end' pentru a marca sf?r?itul ?irului
dec si
;decrementeaz? registrul 'si' pentru a ajunge la sf?r?itul ?irului

do_reverse:
;eticheta 'do_reverse' pentru a inversa ordinea caracterelor ?n ?ir
cmp bx, si
;compar? valorile registrilor 'bx' ?i 'si'
jae done
;salt? la eticheta 'done' dac? 'bx' este mai mare sau egal cu 'si'

mov al, [bx]
;mut? byte-ul de la adresa registrului 'bx' ?n registrul 'al'
mov ah, [si]
;mut? byte-ul de la adresa registrului 'si' ?n registrul 'ah'

mov [si], al
;copiaz? con?inutul registrului 'al' la adresa registrului 'si'
mov [bx], ah
;copiaz? con?inutul registrului 'ah' la adresa registrului 'bx'

inc bx
;incrementeaz? valoarea registrului 'bx' pentru a avansa ?n ?ir
dec si
;decrementeaz? valoarea registrului 'si' pentru a retroceda ?n ?ir
jmp do_reverse
;salt? la eticheta 'do_reverse' pentru a finaliza inversarea

done:
;eticheta 'done' pentru a marca sf?r?itul procesului de inversare
lea dx, string1
;?ncarc? adresa de ?nceput a ?irului 'string1' ?n registrul 'dx'
mov ah, 09h
;seteaz? valoarea '09h' ?n registrul 'ah' pentru a afi?a

 ?irul de caractere
int 21h

mov ah, 0
;seteaz? valoarea '0' ?n registrul 'ah' pentru a a?tepta ap?sarea unei taste
int 16h
;apeleaz? serviciul de citire al unei taste din BIOS

.exit
;ie?ire din program