; Aplica?ia citeste un caracter introdus de la tastatur? ?i ?l afi?eaz?.
; Mai ?nt?i, se cite?te de la tastatur? caracterul, apoi acesta este convertit de la liter? mic? la liter? mare
; prin linia 'sub al 20h', care scade valoarea 20h din registrul 'al'.

org 100h ; Adresa de ?nceput a aplica?iei.
.data ; Segmentul de date.
    mesaj1 db "Citeste caracterul:", 24h ; Se declar? variabila mesaj1 ca un ?ir de caractere cu mesajul "Citeste caracterul:".
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

    sub al, 20h ; Se scade valoarea 20h din registrul al pentru a converti caracterul citit de la minuscul? la majuscul?.
    mov ch, al ; Se mut? caracterul citit ?i convertit ?n registrul ch.

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
    mov dl, ch ; Se mut? valoarea din registrul ch (caracterul citit anterior) ?n registrul dl pentru a fi afi?at?.
    int 21h ; Se apeleaz? serviciul de afi?are a caracterului.

.exit ; Eticheta de sf?r?it a aplica?iei.
