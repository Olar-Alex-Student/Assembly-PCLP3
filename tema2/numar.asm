org 100h
.data
    numar db 20 dup(?) ; Definirea unei variabile numar de tip byte cu 20 de elemente neinitializate
    msg1 db "Numarul este: ", 24h ; Definirea unui mesaj "Numarul este: " urmat de un caracter de sfarsit de sir
    msg2 db "Are suma cifrelor ", 24h ; Definirea unui mesaj "Are suma cifrelor " urmat de un caracter de sfarsit de sir
    msg3 db " este divizibil cu 3;", 0Dh, 0Ah, 24h ; Definirea unui mesaj " este divizibil cu 3;" urmat de un caracter de sfarsit de rand nou si un caracter de sfarsit de sir
    msg4 db " nu", 24h ; Definirea unui mesaj " nu" urmat de un caracter de sfarsit de sir
.code
    mov ax, @data ; Mutarea adresei segmentului de date in registrul ax
    mov ds, ax ; Mutarea adresei segmentului de date in registrul ds
    mov es, ax ; Mutarea adresei segmentului de date in registrul es

    lea si, numar ; Calcularea adresei de inceput a variabilei 'numar' si memorarea in registrul si
    mov bl, 0 ; Initializarea registrului bl cu 0

repeta:
    mov ah, 01h ; Setarea functiei de citire de la tastatura
    int 21h ; Apelarea serviciului de citire de la tastatura

    cmp al, 0Dh ; Compararea caracterului citit cu 0Dh (caracterul de sfarsit de rand nou)
    je afisare ; Daca caracterul este 0Dh, se trece la eticheta 'afisare'

    mov [si], al ; Salvarea caracterului citit in variabila 'numar' de la adresa indicata de registrul si
    inc si ; Incrementarea registrului si pentru a trece la urmatorul element al variabilei 'numar'
    mov [si], ' ' ; Salvarea caracterului spatiu in variabila 'numar' pentru a separa cifrele
    inc si ; Incrementarea registrului si pentru a trece la urmatorul element al variabilei 'numar'

    sub al, '0' ; Scaderea valorii corespunzatoare codului ASCII pentru '0' pentru a obtine valoarea numerica a cifrei
    add bl, al ; Adaugarea valorii cifrei la registrul bl pentru a calcula suma cifrelor

    jmp repeta ; Sari la eticheta 'repeta' pentru a continua citirea de la tastatura

afisare:
    mov [si], 24h ; Salvarea caracterului de sfarsit de sir in variabila 'numar'

    mov ah, 02h ; Setarea functiei de afisare de caractere
    mov dl, 0Dh ; Setarea caracterului de sfarsit de rand nou
    int 21h ; Apelarea serviciului de afisare de caractere

    mov dl, 0Ah ; Setarea caracterului de rand nou
    int 21h ; Apelarea servici

ului de afisare de caractere

    mov ah, 09h ; Setarea functiei de afisare de siruri de caractere
    lea dx, msg1 ; Calcularea adresei de inceput a mesajului 'msg1'
    int 21h ; Apelarea serviciului de afisare de siruri de caractere

    lea dx, numar ; Calcularea adresei de inceput a variabilei 'numar'
    int 21h ; Apelarea serviciului de afisare de siruri de caractere

    mov ah, 02h ; Setarea functiei de afisare de caractere
    mov dl, 0Dh ; Setarea caracterului de sfarsit de rand nou
    int 21h ; Apelarea serviciului de afisare de caractere

    mov dl, 0Ah ; Setarea caracterului de rand nou
    int 21h ; Apelarea serviciului de afisare de caractere

    mov ah, 09h ; Setarea functiei de afisare de siruri de caractere
    lea dx, msg2 ; Calcularea adresei de inceput a mesajului 'msg2'
    int 21h ; Apelarea serviciului de afisare de siruri de caractere

    mov al, bl ; Mutarea valorii sumei cifrelor din registrul bl in registrul al
    mov ah, 0 ; Initializarea registrului ah cu 0
    mov bh, 10 ; Initializarea registrului bh cu 10 pentru a realiza impartirea
    idiv bh ; Impartirea valorii din registrul ax la 10, rezultatul va fi in registrul al, restul in registrul ah

    mov ch, ah ; Mutarea valorii restului in registrul ch
    mov ah, 02h ; Setarea functiei de afisare de caractere
    add al, '0' ; Adaugarea valorii corespunzatoare codului ASCII pentru '0'
    mov dl, al ; Mutarea valorii afisabile in registrul dl
    int 21h ; Apelarea serviciului de afisare

    add ch, '0' ; Adaugarea valorii corespunzatoare codului ASCII pentru '0'
    mov dl, ch ; Mutarea valorii afisabile in registrul dl
    int 21h ; Apelarea serviciului de afisare

    mov al, bl ; Mutarea valorii sumei cifrelor in registrul al
    mov ah, 0 ; Initializarea registrului ah cu 0
    mov bh, 3 ; Initializarea registrului bh cu 3 pentru a verifica daca suma este divizibila cu 3
    idiv bh ; Impartirea valorii din registrul ax la 3, rezultatul va fi in registrul al, restul in registrul ah

    cmp ah, 0 ; Compararea restului cu 0
    je este ; Daca restul este 0, se trece la eticheta 'este'

    mov ah, 09h ; Setarea functiei de afisare de siruri de caractere
    lea dx, msg4 ; Calcularea adresei de inceput a mesajului 'msg4'
    int 21h ; Apelarea serviciului de afisare de siruri de caractere



este:
    mov ah, 09h ; Setarea functiei de afisare de siruri de caractere
    lea dx, msg3 ; Calcularea adresei de inceput a mesajului 'msg3'
    int 21h ; Apelarea serviciului de afisare de siruri de caractere

.exit ; Eticheta de sfarsit a programului