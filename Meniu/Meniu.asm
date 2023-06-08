;Aplicatie de timp MEniu cu 3 alegeri: 1. Afisare mesaj, 2. Info Autor, 3. Exit

.model small
.data
    mesaj db 10,13,"Acesta este mesajul afisat", "$"
    nume db 10,13,"Olar Alex", "$"
    afisare db 10,13,"1. AFISARE MESAJ", 0ah, "2. INFO", 0ah, "3. EXIT", 0ah, "$"
    exit db 10,13,"Ati iesit din program!","$"
    prompt db 10,13,"Apasati tasta: ", "$"

.code
.startup

    mov ax, @data
    mov ds, ax
   
    ; Afisam optiunile de meniu
    mov ah, 09h
    mov dx, offset afisare
    int 21h

citeste_tasta:

    ; Afisam promptul pentru a introduce tasta
    mov ah, 09h
    mov dx, offset prompt
    int 21h

    ; Citim un caracter de la tastatura
    mov ah, 01h
    int 21h
   
    ; Verificam tasta apasata
    cmp al, '1'
    je afisare_mesaj
    cmp al, '2'
    je afisare_nume
    cmp al, '3'
    je inchide_program
   
    jmp citeste_tasta

afisare_mesaj:
    ; Afisam mesajul
    mov ah, 09h
    mov dx, offset mesaj
    int 21h
    jmp citeste_tasta

afisare_nume:
    ; Afisam numele
    mov ah, 09h
    mov dx, offset nume
    int 21h
    jmp citeste_tasta

inchide_program:
    ; Inchidem programul
    mov ah, 09h
    mov dx, offset exit
    int 21h
    mov ah, 4Ch
    mov al, 0
    int 21h
    jmp citeste_tasta
    
end