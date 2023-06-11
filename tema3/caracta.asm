;;;Tema 3
;;;Aplicatia nr1

;;;Aplicatia isi propune sa citeasca un caracter introdus de la tastatura
;;;pana cand intalneste caracterul de sfarsit de linie
;;;Apoi sa afiseze sirul de caractere introdus, numarul total de caractere si
;;;de cate ori a intalnit caracterul 'a'

org 100h ; Adresa de inceput a aplicatiei

.data
    sir db 40 dup(?) ; Declararea variabilei 'sir' ca un sir de bytes cu 40 de elemente initializate cu '?'
    msg1 db "Sirul este: ", 24h ; Mesajul si caracterul de sfarsit de sir
    msg2 db "Are ", 24h ; Mesajul si caracterul de sfarsit de sir
    msg3 db " caractere;", 0Dh, 0Ah, 24h ; Mesajul, caracterul de sfarsit de rand nou si caracterul de sfarsit de sir
    msg4 db " caractere 'a'.", 24h ; Mesajul si caracterul de sfarsit de sir

.code
    mov ax, @data ; Mutarea adresei zonei de date in registrul ax
    mov ds, ax ; Mutarea adresei zonei de date in registrul ds pentru accesarea variabilelor din zona de date
    mov es, ax ; Mutarea adresei zonei de date in registrul es pentru accesarea variabilelor din zona de date

    lea si, sir ; Incarcarea adresei efective a variabilei 'sir' in registrul si
    mov cl, 0 ; Initializarea registrului cl cu 0 pentru a numara caracterele citite
    mov bh, 0 ; Initializarea registrului bh cu 0 pentru a numara caracterele 'a' intalnite

repeta:
    mov ah, 01h ; Setarea serviciului de citire caracter de la tastatura
    int 21h ; Apelarea serviciului de citire caracter

    cmp al, 0Dh ; Verificarea daca caracterul citit este caracterul de sfarsit de linie
    je afisare ; Salt la eticheta afisare daca este adevarat
    mov [si], al ; Stocarea caracterului citit in memoria variabilei 'sir'
    inc si ; Incrementarea valorii registrului si pentru a stoca urmatorul caracter citit
    inc cl ; Incrementarea numarului total de caractere citite

    cmp al, 'a' ; Verificarea daca caracterul citit este 'a'
    jne repeta ; Salt la inceputul buclei daca nu este adevarat
    inc bh ; Incrementarea numarului de caractere 'a' intalnite
    jmp repeta ; Salt la inceputul buclei

afisare:
    mov [si], 24h ; Adaugarea caracterului de sfarsit de sir in variabila 'sir'

    mov ah, 02h ; Setarea serviciului de afisare de caractere
    mov dl, 0Dh ; Setarea caracterului de sfarsit de rand nou
    int 21h ; Apelarea serviciului de afisare

    mov dl, 0Ah ; Set

area caracterului de rand nou
    int 21h ; Apelarea serviciului de afisare

    mov ah, 09h ; Setarea functiei de afisare de caractere
    lea dx, msg1 ; Calcularea adresei de inceput a mesajului 'msg1'
    int 21h ; Apelarea serviciului de afisare

    lea dx, sir ; Calcularea adresei de inceput a variabilei 'sir'
    int 21h ; Apelarea serviciului de afisare

    mov ah, 02h ; Setarea functiei de afisare de caractere
    mov dl, 0Dh ; Setarea caracterului de sfarsit de rand nou
    int 21h ; Apelarea serviciului de afisare

    mov dl, 0Ah ; Setarea caracterului de rand nou
    int 21h ; Apelarea serviciului de afisare

    mov ah, 09h ; Setarea functiei de afisare de caractere
    lea dx, msg2 ; Calcularea adresei de inceput a mesajului 'msg2'
    int 21h ; Apelarea serviciului de afisare

    mov al, cl ; Mutarea numarului total de caractere citite in registrul al
    mov ah, 0 ; Initializarea registrului ah cu 0
    mov bl, 10 ; Initializarea registrului bl cu 10 pentru realizarea divizarii
    idiv bl ; Impartirea registrilor al si bl, rezultatul se va inregistra in al, iar restul in ah

    mov ch, ah ; Mutarea restului in registrul ch
    mov ah, 02h ; Setarea serviciului de afisare de caractere
    add al, '0' ; Adaugarea valorii corespunzatoare codului ASCII pentru '0' pentru a afisa valoarea inregistrata
    mov dl, al ; Mutarea valorii afisabile in registrul dl
    int 21h ; Apelarea serviciului de afisare

    add ch, '0' ; Adaugarea valorii corespunzatoare codului ASCII pentru '0'
    mov dl, ch ; Mutarea valorii afisabile in registrul dl
    int 21h ; Apelarea serviciului de afisare

    mov ah, 09h ; Setarea functiei de afisare de caractere
    lea dx, msg3 ; Calcularea adresei de inceput a mesajului 'msg3'
    int 21h ; Apelarea serviciului de afisare

    mov ah, 09h ; Setarea functiei de afisare de caractere
    lea dx, msg2 ; Calcularea adresei de inceput a mesajului 'msg2'
    int 21h ; Apelarea serviciului de afisare

    mov al, bh ; Mutarea numarului de caractere 'a' intalnite in registrul al
    mov ah, 0 ; Initializarea registrului ah cu 0
    mov bl, 10 ; Initializarea registrului bl cu 10
    idiv bl ; Impartirea registrilor al si bl, rezultatul se va inregistra in al, iar restul in ah

    mov ch, ah ; Mut

area restului in registrul ch
    mov ah, 02h ; Setarea functiei de afisare de caractere
    add al, '0' ; Adaugarea valorii corespunzatoare codului ASCII pentru '0'
    mov dl, al ; Mutarea valorii afisabile in registrul dl
    int 21h ; Apelarea serviciului de afisare

    add ch, '0' ; Adaugarea valorii corespunzatoare codului ASCII pentru '0'
    mov dl, ch ; Mutarea valorii afisabile in registrul dl
    int 21h ; Apelarea serviciului de afisare

    mov ah, 09h ; Setarea functiei de afisare de caractere
    lea dx, msg4 ; Calcularea adresei de inceput a mesajului 'msg4'
    int 21h ; Apelarea serviciului de afisare

.exit
; Sfarsitul programului