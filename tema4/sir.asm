;;;Tema 4 
;;;Aplicatia nr3

;;;Aplicatia isi propune sa primeasca un sir de caractere si sa inverseze ordinea caracterelor 
;;;in sir, apoi afiseaza sirul inversat si asteapta utilizatorul sa apese o tasta pentru a incheia programul
.model small
;seteaza modul de memorie pentru 'small'
.stack 1024
;stabileste dimensiunea stivei la '1024' de bytes
.data
; reprezinta locul unde se vor declara datele ce urmeaza a fi folosite
    sir db 53 dup(?)
    ;declararea unei variabile de sir tipul byte cu o lungime de maxim 53 de bytes
.code
; segmentul pentru declararea codului
    mov ax, data
    ; incarca in adresa registrului 'ax' segmentul de date
    mov ds, ax
    ;copiaza adresa din 'ax' in registrul 'ds' pentru a seta segmentul de date
    jmp start
    ;salt la eticheta start
citire_sir proc
        ; inceputul procedurii 'citire_sir'
        push bp
        ;salveaza valoarea registrului 'bp' in stiva
        mov bp, sp
        ;copiaza continutul registrului in 'sp' in registrul 'bp'
        push dx
        ;salveaza valoarea registrului 'dx' in stiva
        push ax
        ;salveaza valoarea registrului 'ax' in stiva
    
        mov si, [bp+4]
        ;memoreaza adresa variabilei 'sir' din parametrii pe care i-a primit procedura in registrul 'si'
        mov byte ptr [si], 50   
        ;initializeaza primul byte al sirului cu 50 
        mov ah, 0ah 
        ;seteaza valoarea '0ah' in registrul 'ah' pentru a citi intrarea utilizatorului 
        int 21h
        ;apeleaza serviciul de citire a sirului de caractere
        mov ah, 0
        ;reseteaza valoarea registrului 'ah'
        mov al, byte ptr[si+1]  
        ;muta in registrul valoarea lungimii introdus de utilizator
        add ax, 2   
        ;adauga 2 la lungimea sirului pentru a ajunge la sfarsit
        add si, ax  
        ;avanseaza adresa din 'si' la sfarsitul sirului
        mov byte ptr [si], 24h  
        ;adauga caracterul de sfarsit de caracter de linie noua
        
        mov ah, 02h
        ;seteaza valoarea '02h' in registrul 'ah' pentru a afisa un caracter 
        mov dx, 0ah
        ;memoreaza codul ascii pentru caracterul de linie noua in registrul 'dx'
        int 21h
        mov dx, 0dh
        ;memoreaza codul ascii pentru caracterul de revenire la linie noua
        int 21h

        pop ax
        ;restaureaza valoarea registului 'ax' de pe stiva
        pop dx
        ;restaureaza valoarea registului 'dx' de pe stiva
        pop bp
        ;restaureaza valoarea registului 'dp' de pe stiva
        ret 2   
        ;returneaza controlul catre apelant si elimina 2 bytes de pe stiva
citire_sir endp
;sfarsitul procedurii 'citire_sir'

afisare_sir proc
;inceputul procedurii afisare
    push bp
    ;salvare a valorii registrului 'bp' in stiva
    mov bp, sp
    ;copiaza continutul registrului 'sp' in registrul 'bp'
    push dx
    ;salveaza valoarea registrului 'dx' in stiva
    push ax
    ;salveaza valoarea registrului 'ax' in stiva
    
    mov dx, [bp+4]
    ; memoreaza in adresa registrului 'dx' parametrii ce ia primit din variabila 'sir'
    add dx, 2   
    ;aduna 2 la adresa registrului'dx' pentru a sari peste lungimea sirului
    mov ah, 09h
    ;seteaza valoarea '09h' in registrul 'ah' pentru a afisa sirul de caractere;
    int 21h
    
    pop ax
    ; elimina valoarea de pe stiva a regsitrului 'ax'
    pop dx
    ; elimina valoarea de pe stiva a regsitrului 'dx'
    pop bp
    ; elimina valoarea de pe stiva a regsitrului 'bp'
    ret 2
    ;returneaza controlul utilizatorului si elimina 2 bytes de pe stiva
    
afisare_sir endp
;sfarsit definitii procedurii 'afisare_sir'

start:
;eticheta de 'start' unde incepe alt bloc de instructiuni
    mov ax, offset sir  
    ; muta in registrul 'ax' adresa de inceput al 'sir'
    push ax     
    ; elimina valoarea de pe stiva a regsitrului 'ax'
    call citire_sir
    ;face apel la blocul de instructiuni corespunzator 'citire_sir'  
    push ax  
    ; elimina valoarea de pe stiva a regsitrului 'ax'   
    call afisare_sir    
    ; face apel la blocul de instructiuni corespunzator 'afisare_sir'
    mov ah, 4ch
    ; seteaza valoarea '4ch' in registrul 'ah' pentru a termina programul.
    int 21h
end
;sfarsitul aplicatiei