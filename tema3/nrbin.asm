;;;Tema 3
;;;Aplicatia nr2

;;;Aplicatia isi propune sa citeasca un caracter introdus de la tastatura 
;;;pana cand intalneste caracterul de sfarsit de linie
;;;Apoi sa afiseze sirul de caractere introdus, numarul total de caractere si 
;;;de cate ori a intalnit caracterul 'a'

org 100h
.data
    msg1 db "Numarul este: ", 24h ; mesajul si caracterul de sfarsit de sir
    msg2 db "Err", 0Dh, 0Ah, 24h ; mesajul si caracterul de sfarsit de sir si de rand nou
    prod dw 10 ; se declara variabila prod cu valoarea 10

.code
    mov ax, @data ; mutam in registrul ax adresa zonei de date
    mov ds, ax
    mov es, ax ; mutam in registrii 'ds' si 'es' pentru a putea accesa variabilele din zona de date
               
    mov bx, 0 ; initializeaza registrul bx cu 0
    mov ah, 01h ; seteaza serviciul de citire caracter
    int 21h
    cmp al, 0Dh ; verifica daca este caracterul enter
    je err ; daca este true face salt la err
    sub al, '0' ; scade valoarea codului ascii pentru a afisa o valoare numerica
    mov ah, 0 ; initializare cu 0
    add bx, ax ; aduna valoarea numerica partiala inregistrata in registrul bx
    mov ch, 0 ; initializare cu 0

repeta:
    mov ah, 01h ; seteaza serviciul de citire caracter
    int 21h
    cmp al, 0Dh ; comapra daca este sfarsit de linie
    je mesaj ; daca este true face salt la mesaj
    sub al, '0' ; scade pentru a afisa un numar
    mov cl, al ; muta in registrul cl pentru a realiza inmultirea si adunarea
    mov ax, bx ; muta valoarea inregistrata in bx
    mul prod ; inmulteste partial cu 10
    add ax, cx ; aduna valoarea numerica citita la suma partiala inregistrata
    mov bx, ax ; muta rezultatul in registrul bx
    jmp repeta ; face salt la repeta

mesaj:
    mov ah, 02h ; seteaza serviciul de afisare de caractere
    mov dl, 0Dh ; seteaza caracterul de rand nou
    int 21h
    mov dl, 0Ah ; seteaza serviciul de rand nou
    int 21h
    mov cl, 16 ; seteaza registrul cl la 16
    mov ah, 09h ; seteaza functia de afisare caracter
    lea dx, msg1 ; calculeaza adresa de inceput al mesajului 'msg2'
    int 21h 

afisare:
    cmp cl, 0 ; comapara daca s-au afisat toate cifrele
    je stop ; daca este true face salt la stop care opreste programul
   

 shl bx, 1 ; mutare la stanga a valorii inregistrate in bx
    dec cl ; decrementare a registrului cl
    jc unu ; daca bitul de semn rezultat in urma mutarii este unu, face salt la eticheta unu

    mov ah, 02h ; seteaza serviciul de afisare de caractere
    mov dl, '0' ; seteaza caracterul '0' pentru afisare
    int 21h      
    jmp afisare ; face salt la inceputul buclei pentru a afisa urmatoarea cifra

unu:
    mov ah, 02h ; seteaza serviciul de afisare de caractere
    mov dl, '1' ; seteaza caracterul '1' pentru afisare
    int 21h      
    jmp afisare ; face salt la inceputul buclei pentru a afisa urmatoarea cifra

err:
    mov ah, 09h ; seteaza functia de afisare de caractere
    lea dx, msg2 ; calculeaza adresa de inceput al mesajului 'msg2'
    int 21h 

stop:    
.exit ; sfarsit de program