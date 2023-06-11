; Aplica?ia ??i propune s? citeasc? caractere de la tastatur? ?i s? le afi?eze.
; Mai ?nt?i se afi?eaz? un mesaj de citire a caracterelor ?i un mesaj de afi?are a caracterului.
; Apoi se cite?te un caracter de la tastatur? ?i se stocheaz? ?n registrul al.
; Caracterul citit este afi?at pe ecran.
; ?n cele din urm?, se ?ncheie aplica?ia.

org 100h ; Adresa de ?nceput a aplica?iei.
.data ; Segmentul de date.
    mesaj1 db "Citeste caracterele:", 24h ; Se declar? variabila mesaj1 ca un ?ir de caractere cu mesajul "Citeste caracterele:".
    mesaj2 db "Caracterul este:", 24h ; Se declar? variabila mesaj2 ca un ?ir de caractere cu mesajul "Caracterul este:".

.code ; Segmentul de cod.
    mov ax, @data ; Se mut? adresa segmentului de date ?n registrul ax.
    mov ds, ax ; Se mut? valoarea registrului ax ?n registrul ds (segmentul de date).
    mov es, ax ; Se mut? valoarea registrului ax ?n registrul es (segmentul de date).

    mov ah, 09h ; Se seteaz? serviciul de afi?are a string-urilor ?n registrul ah.
    lea dx, mesaj1 ; Se ?ncarc? ?n registrul dx adresa efectiv? a mesaj1.
    int 21h ; Se apeleaz? serviciul de afi?are a string-urilor.

    mov ah, 01h ; Se seteaz? serviciul de citire a unui caracter de la tastatur? ?n registrul ah.
    int 21h ; Se apeleaz? serviciul de citire a unui caracter de la tastatur?.
    mov cl, al ; Se mut? valoarea registrului al (caracterul citit) ?n registrul cl.

    mov ah, 02h ; Se seteaz? serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, 0Dh ; Se mut? valoarea hexazecimal? '0Dh' (13 ?n zecimal) ?n registrul dl pentru a afi?a un caracter de linie nou? pe ecran.
    int 21h ; Se apeleaz? serviciul de afi?are a caracterului.

    mov ah, 02h ; Se seteaz? serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, 0Ah ; Se mut? valoarea hexazecimal? '0Ah' (10 ?n zecimal) ?n registrul dl pentru a afi?a un caracter de revenire la linia urm?toare.
    int 21h ; Se apeleaz? serviciul de afi?are a caracterului.

    mov ah, 09h ; Se seteaz? serviciul de afi?are a mesajului pe ecran ?n registrul ah.
    lea dx, mesaj2 ; Se ?ncarc? ?n registrul dx adresa efectiv? a mesaj2.
    int 21h ; Se apeleaz? serviciul de afi?are a mesajului pe ecran.

    mov ah, 02h ; Se seteaz? serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, '1' ; Se mut? valoarea '1' (un caracter constant) ?n registrul dl pentru a fi afi?at?.
    int 21h ; Se apeleaz? serviciul de afi?are a caracterului.

    sub cl, 17 ; Se scade valoarea 17 din registrul cl (caracterul citit) pentru a ob?ine un alt caracter.

    mov ah, 02h ; Se seteaz? serviciul de afi?are a caracterului ?n registrul ah.
    mov dl, cl ; Se mut? valoarea registrului cl (caracterul modificat) ?n registrul dl pentru a fi afi?at?.
    int 21h ; Se apeleaz? serviciul de afi?are a caracterului.

.exit ; Eticheta de sf?r?it a aplica?iei.
