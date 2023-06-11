org 100h ; Seteaza adresa de inceput a programului la 100h

.data ; Segmentul de date
    VECTOR  db  1,2,3,4,5 ; Declara un vector de bytes (1,2,3,4,5)

.code ; Segmentul de cod
    mov ax, @data ; Mut? adresa segmentului de date ?n registrul ax
    mov ds, ax ; Mut? valoarea registrului ax ?n registrul ds (segmentul de date)
    mov es, ax ; Mut? valoarea registrului ax ?n registrul es (segmentul de date)

    mov bx, 4 ; Mut? valoarea 4 ?n registrul bx
    mov al, 0 ; Mut? valoarea 0 ?n registrul al (accumulator)

next_el: ; Eticheta pentru un ciclu repetitiv
    mov dl, VECTOR[bx] ; Mut? valoarea din vectorul VECTOR la adresa bx ?n registrul dl
    add al, dl ; Adun? valoarea din registrul dl la valoarea din registrul al

    dec bx ; Decrementeaz? valoarea din registrul bx
    cmp bx, -1 ; Compar? valoarea din registrul bx cu -1
    jnz next_el ; Dac? valoarea din registrul bx nu este zero, s?ri la eticheta next_el

.exit ; Eticheta de sf?r?it a programului
