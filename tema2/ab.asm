org 100h ; Seteaz? adresa de ?nceput a programului la 100h

.data ; Segmentul de date
    a dw 1010110110001011b ; Declara?ie a unei variabile a de tip word cu valoarea binar? 1010110110001011
    b dw 1001010101100101b ; Declara?ie a unei variabile b de tip word cu valoarea binar? 1001010101100101

.code ; Segmentul de cod
    mov ax, @data ; Mut? adresa segmentului de date ?n registrul ax
    mov ds, ax ; Mut? valoarea registrului ax ?n registrul ds (segmentul de date)
    mov es, ax ; Mut? valoarea registrului ax ?n registrul es (segmentul de date)

    and b, 000Fh ; Aplic? opera?ia AND ?ntre b ?i 000Fh pentru a p?stra doar cei 4 bi?i mai din dreapta ai lui b
    shl b, 2 ; Deplaseaz? st?nga con?inutul registrului b cu 2 bi?i
    and a, 0xFFC3h ; Aplic? opera?ia AND ?ntre a ?i 0xFFC3h pentru a p?stra doar anumite bi?i specifica?i
    mov ax, b ; Mut? valoarea din registrul b ?n registrul ax
    xor a, ax ; Aplic? opera?ia XOR ?ntre a ?i ax ?i stocheaz? rezultatul ?n a

.exit ; Eticheta de sf?r?it a programului
