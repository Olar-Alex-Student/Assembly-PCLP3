.model small
.stack 1024
.data
msg1 db "Dati un sir: ",'$' ;declarare 2 msg
msg2 db "Sirul este: ",'$'
sir db 8 dup(' ') ;dimensiunea vectorului declarare vector de 8 caractere

.code
start:
mov ax,dgroup
mov ds,ax

;afisare mesaj de inceput
mov dx, offset msg1 ;muta in dx adresa de inceput al vectorului de caractere msg1
mov ah,09h
int 21h

;citire_sir
mov si,0 ;si index ca si un while/for e registru special
citire1:  ;eticheta citireq pentru jump,de aici incepe citirea sirului
mov ah, 01h ;pune in ah 01h,adica instructiune de citire
int 21h  ; mov/int sitaxa standard citire caracter,citirea standard salveaza intodeauna in registru al
mov sir[si], al ;mutam in vectorul sir,pe pozitia si caracterul din al
inc si ;incrementam si(si++)
cmp al, 13 ;comparam caracterul citit de la tastatura al cu 13,codul ASCII pentru ENTER
je skip ; jumpifequal(je) daca al==13 sari la eticheta SKIP:
jne citire1 ;jumpifnotequal daca al!=13 sari la eticheta citire1
 
skip: ;eticheta skip

mov sir[si],'$' ; la final,pentru a se putea afisa un sir la consola,trebuie sa aiba '$' la sfarsit,si cum si e cum ar fi i in for,ajuns la n,si era i=0;i<n,adaugam null la sfarsit ca in C++

;afisare mesaj de final
mov dx, offset msg2
mov ah,09h
int 21h

;afisare sir
mov si, 0 ; resetam indexul vectorului sir
afisare:
    mov dl, sir[si] ; mutam caracterul din sir in registru dl
    mov ah, 02h ; setam functia pentru afisarea caracterului
    int 21h ; afisam caracterul
    mov dl, ' ' ; mutam caracterul spatiu in registru dl
    int 21h ; afisam spatiul
    inc si ; incrementam indexul vectorului sir
    cmp sir[si], '$' ; verificam daca am ajuns la finalul sirului
    jne afisare ; daca nu am ajuns, continuam afisarea

mov ah,4ch ;pune in ah cod de inceiere a programului
int 21h
 
end start
