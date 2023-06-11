; Aplica?ia ??i propune s? citeasc? dou? caractere de la tastatur? ?i s? le afi?eze.
; Mai ?nt?i se afi?eaz? mesajul "Citeste caracterele:", apoi se cite?te primul caracter ?i se stocheaz? ?n registrul al.
; Se cite?te al doilea caracter ?i se stocheaz? ?n registrul al.
; Se compar? primul caracter cu '1' (valoarea 31h ?n hexazecimal) ?i se sare la eticheta 'eroare' dac? nu sunt egale.
; Se compar? al doilea caracter cu '6' (valoarea 36h ?n hexazecimal) ?i se sare la eticheta 'eroare' dac? este mai mare sau egal.
; Caracterele citite sunt afi?ate pe ecran dup? afi?area unor caractere de linie nou?.
; Se afi?eaz? mesajul "Caracterul este:".
; Se adaug? valoarea 17 la al doilea caracter.
; Caracterul modificat este afi?at pe ecran.
; Se sare la eticheta 'iesire'.
; Eticheta 'eroare' este definit? pentru a afi?a un mesaj de eroare ?i a afi?a caracterele de linie nou?.
; Se afi?eaz? mesajul de eroare "Caracterul este gresit!".
; Eticheta 'iesire' este definit? pentru a marca punctul de ie?ire al programului.

org 100h ; Adresa de ?nceput a aplica?iei.
.data ; Segmentul de date.
    mesaj1 db "Citeste caracterele:", 24h ; Se declar? variabila mesaj1 ca un ?ir de caractere cu mesajul "Citeste caracterele:".
    mesaj2 db "Caracterul este:", 24h ; Se declar? variabila mesaj2 ca un ?ir de caractere cu mesajul "Caracterul este:".
    err db "Caracterul este gresit!", 24h ; Se declar? variabila err ca un ?ir de caractere cu mesajul de eroare "Caracterul este gresit!".

.code ; Segmentul de cod.
    mov ax, @data ; Se mut? adresa segmentului de date ?n registrul ax.
    mov ds, ax ; Se mut? valoarea registrului ax ?n registrul ds (segmentul de date).
    mov es, ax ; Se mut? valoarea registrului ax ?n registrul es (segmentul de date).

    mov ah, 09h ; Se seteaz? serviciul de afi?are a string-urilor ?n registrul ah.
    lea dx, mesaj1 ; Se ?ncarc? ?n registrul dx adresa efectiv? a mesaj1.
    int 21h ; Se apeleaz? serviciul de afi?are a string-urilor.

    mov ah, 01h ; Se seteaz? serviciul de citire a unui caracter de la tastatur? ?n registrul ah.
    int 21h ; Se apeleaz? serviciul de citire a unui caracter de la tastatur?.
    mov ch, al ; Se mut? valoarea registrului al (primul caracter citit) ?n registrul ch.

    mov ah, 01h ; Se seteaz? din nou serviciul de citire a unui caracter de la tastatur? ?n registrul ah.
    int 21h ; Se apeleaz? din nou serviciul de citire a unui caracter de la tastatur?.
    mov cl, al ; Se mut? valoarea registrului al (al doilea caracter citit) ?n registrul cl.

    cmp ch, 31h ; Se compar? valoarea registrului ch (primul caracter) cu '1' (valoarea 31h ?n hexazecimal).
    jnz eroare ; Dac? nu sunt egale, se sare la eticheta 'eroare'.

    cmp cl, 36h ; Se compar? valoarea registrului cl (al doilea caracter) cu '6' (valoarea 36h ?n hexazecimal).
    jge eroare ; Dac? este mai mare sau egal, se sare la eticheta 'eroare'.

    mov ah, 02h ; Se seteaz? serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, 0Dh ; Se mut? valoarea hexazecimal? '0Dh' (13 ?n zecimal) ?n registrul dl pentru a afi?a un caracter de linie nou?.
    int 21h ; Se apeleaz? serviciul de afi?are a caracterului.

    mov ah, 02h ; Se seteaz? din nou serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, 0Ah ; Se mut? valoarea hexazecimal? '0Ah' (10 ?n zecimal) ?n registrul dl pentru a afi?a un caracter de revenire la linia urm?toare.
    int 21h ; Se apeleaz? din nou serviciul de afi?are a caracterului.

    mov ah, 09h ; Se seteaz? din nou serviciul de afi?are a string-urilor ?n registrul ah.
    lea dx, mesaj2 ; Se ?ncarc? ?n registrul dx adresa efectiv? a mesaj2.
    int 21h ; Se apeleaz? din nou serviciul de afi?are a string-urilor.

    add cl, 17 ; Se adaug? valoarea 17 la registrul cl (al doilea caracter citit).

    mov ah, 02h ; Se seteaz? din nou serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, cl ; Se mut? valoarea registrului cl (caracterul modificat) ?n registrul dl pentru a afi?a caracterul.
    int 21h ; Se apeleaz? din nou serviciul de afi?are a caracterului.

    jmp iesire ; Se sare la eticheta 'iesire'.

eroare: ; Eticheta 'eroare' este definit? pentru a trata cazul ?n care caracterul nu respect? condi?iile.
    mov ah, 02h ; Se seteaz? din nou serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, 0Dh ; Se mut? valoarea hexazecimal? '0Dh' (13 ?n zecimal) ?n registrul dl pentru a afi?a un caracter de linie nou?.
    int 21h ; Se apeleaz? din nou serviciul de afi?are a caracterului.

    mov ah, 02h ; Se seteaz? din nou serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, 0Ah ; Se mut? valoarea hexazecimal? '0Ah' (10 ?n zecimal) ?n registrul dl pentru a afi?a un caracter de revenire la linia urm?toare.
    int 21h ; Se apeleaz? din nou serviciul de afi?are a caracterului.

    mov ah, 09h ; Se seteaz? din nou serviciul de afi?are a string-urilor ?n registrul ah.
    lea dx, err ; Se ?ncarc? ?n registrul dx adresa efectiv? a err (mesajul de eroare).
    int 21h ; Se apeleaz? din nou serviciul de afi?are a string-urilor.

iesire: ; Eticheta 'iesire' este definit? pentru a marca punctul de ie?ire al programului.

.exit ; Indic? sf?r?itul programului ?i ie?irea din executarea acestuia.
