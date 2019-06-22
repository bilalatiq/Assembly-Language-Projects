dosseg
.model small
.stack 100h
.data
fromMsg db 'Which conversion do you want?',10,13,'$'
options db '1) Binary To Hexa',10,13,'2) Binary To Octal',10,13,'3) Octal To Hexa',10,13,'4) Octal to Binary',10,13,'5) Hexa To Binary',10,13,'6) Hexa to Octal',10,13,'$'
user1msg db 'User input: $'
user1 db ?
var db ?,?,?,?
var2 db '$'
var1 db 1,2,4
var3 db 1,2,4,8
m0 db 'Binary To Hexa  $'
m1 db 'enter binary  $ '
m2 db 'hexa num   $ '
m3 db 'invalid  $ '
m4 db 'Binary To Octal  $'
m5 db 'octal num  $'
m6 db 'Octal To Binary  $'
m7 db 'enter octal  $ '
m8 db 'binary num $ '
m9 db 'Hexa To Binary  $'
m10 db 'enter hexa  $ '
m11 db 'Hexa To Octal  $'
m12 db 'Octal To Hexa  $'
m13 db 'Binary  $'
.code

main proc
    mov ax,@data
    mov ds,ax
    
    lea dx, fromMsg
    mov ah,09
    int 21h
    
    lea dx,options
    mov ah,9
    int 21h

    lea dx,user1msg
    mov ah,9
    int 21h

    lea dx,user1
    mov ah,1
    int 21h
    
    call carriage
    call newline 
    
    cmp al,'1'
    je LblbinaryToHexa
    
    cmp al,'2'
    je binaryToOctal
    
    cmp al,'3'
    je octalToHexa
    
    cmp al,'4'
    je octalToBinary
    
    cmp al,'5'
    je hexaToBinary
    
    cmp al,'6'
    je hexaToOctal
    jmp bahar
    
             
             
    LblbinaryToHexa:
    call binaryToHexa
    
    Lb2binaryToOctal:
    call binaryToOctal

    Lb3octalToHexa:
    call octalToHexa

    Lb4octalToBinary:
    call octalToBinary

    Lb5hexaToBinary:
    call hexaToBinary

    Lb6hexaToOctal:
    call hexaToOctal

    
    bahar:
    mov ah,4Ch
    int 21h
main endp

binaryToHexa proc

	    push ax
	    push bx
	    push cx
	    push dx	

        mov ax,@data
        mov ds,ax
        
        lea dx,m0
        mov ah,9
        int 21h
        
        
        clear:

        call carriage
        call newline 

        lea dx,m1
        mov ah,9
        int 21h
        
        xor bh,bh
        mov bl,0        
input:
        cmp bl,4
        je print
         
        mov ah,1
        int 21h
        
        inc bl
               
        mov ch,al

        cmp ch,13
        je print

        cmp ch,'0'
        jl exit

        cmp ch,'1'
        jg exit

        and ch,15 ;0000 1111  
        shl bh,1
        or bh,ch
        
        jmp input
        
print:
        call carriage
        call newline 

        lea dx,m2
        mov ah,9
        int 21h

        mov ah,2

        cmp bh,9
        jle number

        cmp bh,15
        jle character

number:
        add bh,48
        mov ah,2
        mov dl,bh
        int 21h
        jmp clear

character:
        add bh,55
        mov ah,2
        mov dl,bh
        int 21h
        jmp clear

exit:
        call carriage
        call newline 

        lea dx,m3
        mov ah,9
        int 21h

        mov ah,4Ch
        int 21h   
	
	pop dx
	pop cx
	pop bx
	pop ax	
    
    ret
    binaryToHexa endp

binaryToOctal proc
    
        
        push ax
	    push bx
	    push cx
	    push dx	
        
        mov ax,@data
        mov ds,ax
        
        lea dx,m4
        mov ah,9
        int 21h

        clear1:

        call carriage
        call newline

        lea dx,m1
        mov ah,9
        int 21h

        xor bh,bh
        mov bl,0
        
 input1:
        cmp bl,3
        je print1
        
        mov ah,1
        int 21h
        
        inc bl
        
        mov ch,al

        cmp ch,13
        je print1

        cmp ch,'0'
        jl exit1

        cmp ch,'1'
        jg exit1

        and ch,7 ;0000 1111
        shl bh,1
        or bh,ch

        jmp input1

print1:
        call carriage
        call newline

        lea dx,m5
        mov ah,9
        int 21h

        mov ah,2

        cmp bh,7
        jle number1

number1:
        add bh,48
        mov ah,2
        mov dl,bh
        int 21h
        jmp clear1


exit1:
        call carriage
        call newline

        lea dx,m3
        mov ah,9
        int 21h

        mov ah,4Ch
        int 21h
        
    pop dx
	pop cx
	pop bx
	pop ax
    
    ret
    binaryToOctal endp


octalToHexa proc 

        push ax
	    push bx
	    push cx
	    push dx	
        
        mov ax,@data
        mov ds,ax
        
        lea dx,m12
        mov ah,9
        int 21h 
        
        call newline
        call carriage

        lea dx,m7
        mov ah,9
        int 21h

        mov ah,1
        int 21h
        sub al,48

        mov dx,0
        mov bl,al

        mov cx,8 
        lea si,var
        cmp bl,8
        jge exit2

lb1l2:

        shl bl,1
        jnc l01
   
        cmp cx, 4
        jle printer6
        jmp l03
    
printer6:

    	mov dl,'1'
        mov [si],dl
        inc si
        jmp l03
l01:
 
        cmp cx, 4
        jg l03
    
printer7:

        mov dl,'0'        			 
        mov [si],dl
        inc si

l03: 
        loop lb1l2
    
	
        push ax
	
;print binary of hexa
        mov ah,2

        call newline
        call carriage 

        lea dx, m13
        mov ah,9
        int 21h

        mov cx,3
        lea di, var
        inc di

l5:
        mov ah,2
        mov dl,[di]
        int 21h
        inc di
        loop l5


;print ocatl_result_label
        mov ah,2

        call newline
        call carriage 

        lea dx, m2
        mov ah,9
        int 21h

        pop ax

;print hexa
        lea di,var1
        dec si
        mov cx,3
        mov al,0

loop1:  
        mov bl,'1'
        cmp [si],bl
        je adding
        jne incre

adding:
        add al,[di]

incre:
        dec si
        inc di
        loop loop1


        add al,48
        mov ah,2
        mov dl,al
        int 21h
        mov ah,4Ch
        int 21h
        
exit2:  
        call newline
        call carriage
        
        lea dx,m3
        mov ah,9
        int 21h
        
        mov ah,4Ch
        int 21h


    pop dx
	pop cx
	pop bx
	pop ax
    
    ret
    octalToHexa endp


octalToBinary proc 
    
        push ax
	    push bx
	    push cx
	    push dx
	    
        mov ax,@data
        mov ds,ax 
        
        lea dx,m6
        mov ah,9
        int 21h

        clear3:

        call carriage
        call newline

        lea dx,m7
        mov ah,9
        int 21h  
        
 input3:
        mov ah,1
        int 21h

        mov bl,al
        sub bl,48
        
        cmp bl,13
        je print3

print3:  
        call carriage
        call newline
        
        lea dx,m8
        mov ah,9
        int 21h     
        
        mov cx,8
        lbl2:
            shl bl,1
            jnc l1
            
            cmp cx,3
            jle printer0
            jmp l3
 
        printer0:   
            mov ah,2
            mov dl,'1'
            int 21h
            jmp l3
        
        l1: 
            cmp cx,3
            jg l3
            
        printer1:
            mov ah,2
            mov dl,'0'
            int 21h  
            

        l3:
            loop lbl2
            mov ah,4Ch
            int 21
        
    pop dx
	pop cx
	pop bx
	pop ax
    
    ret
    octalToBinary endp


hexaToBinary proc 
    
        push ax
	    push bx
	    push cx
	    push dx
	    
        mov ax,@data
        mov ds,ax 
        
        lea dx,m9
        mov ah,9
        int 21h

        clear4:

        call carriage
        call newline

        lea dx,m10
        mov ah,9
        int 21h

input4:
        mov ah,1
        int 21h
        mov bl,al

        cmp bl,9
        jle number2

        cmp bl, 'A'
        je character2

        cmp bl, 'B'
        je character2

        cmp bl, 'C'
        je character2

        cmp bl, 'D'
        je character2

        cmp bl, 'E'
        je character2

        cmp bl, 'F'
        je character2

  
number2:
        call carriage
        call newline
        
        lea dx,m8
        mov ah,9
        int 21h
        
        sub bl,48
        mov cx,8 
        
        lbl22:
            shl bl,1
            jnc l11
            
            cmp cx,4
            jle printer2
            jmp l33
            
        printer2:
            mov ah,2
            mov dl,'1'
            int 21h
            jmp l33 
        
        l11:
            cmp cx,4
            jg l33
            
        printer3:
            mov ah,2
            mov dl,'0'
            int 21h

        l33:
            loop lbl22 
            mov ah,4ch
            int 21h
        
        
character2:
        call carriage
        call newline
        
        lea dx,m8
        mov ah,9
        int 21h
        
        sub bl,55
        mov cx,8 
        
        lbl222:
            shl bl,1
            jnc l111
            
            cmp cx,4
            jle printer4
            jmp l333
            
        printer4:  
            mov ah,2
            mov dl,'1'
            int 21h
            jmp l333 
        
        l111:
            cmp cx,4
            jg l333
            
        printer5:
            mov ah,2
            mov dl,'0'
            int 21h

        l333:
            loop lbl222 
            mov ah,4ch
            int 21h
    
    pop dx
	pop cx
	pop bx
	pop ax
    
    ret
    hexaToBinary endp


hexaToOctal proc
    
    
        push ax
	    push bx
	    push cx
	    push dx	
        
        mov ax,@data
        mov ds,ax
        
        lea dx,m11
        mov ah,9
        int 21h
        
        call newline
        call carriage
               
        lea dx,m10
        mov ah,9
        int 21h
        
        mov ah,1
        int 21h
        sub al,48
        
        mov dx,0
        mov bl,al
        
        mov cx,8 
        lea si,var
        cmp bl,8
        jge exit3

lbl12:

        shl bl,1
        jnc l001
   
        cmp cx, 4
        jle printer8
        jmp l003
    
printer8:

	    mov dl,'1'
        mov [si],dl
        inc si
        jmp l003
l001: 
        cmp cx, 4
        jg l003
    
printer9:

        mov dl,'0'
        mov [si],dl
        inc si

l003: 
        loop lbl12
    
	
        push ax
	
;print binary of octal
        mov ah,2
        
        call newline
        call carriage
        
        lea dx,m13
        mov ah,9
        int 21h
        
        mov cx,4
        lea di,var
l51:
        mov ah,2
        mov dl,[di]
        int 21h
        inc di
        loop l51


;print ocatl_result_label
        mov ah,2
        
        call newline
        call carriage
        
        lea dx,m5
        mov ah,9
        int 21h
        
        pop ax
        
;print octal
        lea di, var3
        dec si
        mov cx,4
        mov al,0
loop12:  
        mov bl,'1'
        cmp [si],bl
        je adding1
        jne incre1

adding1:
        add al,[di]

incre1:
        dec si
        inc di
        loop loop12


        add al,48
        mov ah,2
        mov dl,al
        int 21h
        mov ah,4Ch
        int 21h
        
exit3:  
        call newline
        call carriage
        
        lea dx,m3
        mov ah,9
        int 21h
        
        mov ah,4Ch
        int 21h


    pop dx
	pop cx
	pop bx
	pop ax
    
    
    ret
    hexaToOctal endp


newline proc
    
    push ax
    push dx
    mov dl,10
    mov ah,2
    int 21h
    pop dx
    pop ax
    ret
    newline endp
                   
                   
carriage proc
    
    push ax
    push dx
    mov dl,13
    mov ah,2
    int 21h
    pop dx
    pop ax
    ret
    carriage endp


end main