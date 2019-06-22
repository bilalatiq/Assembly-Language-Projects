dosseg

.model small
.stack 256
.data 

lsrow db ? 
lerow db ?  

rsrow db ? 
rerow db ?

mup db 1
mdown db ?
mright db ?
mleft db 1

ballxs db ?
ballxe db ?
bally db ? 

score1 db ?
score2 db ?

golbl db 0

lst db ' Lost :-($'
wns db ' Win :)$'
 
mis db 'Missed !!$'

var db 'Press Enter to Restart$'

gm db 'Game Over !!!$'

name1 db 'Player#1 Name :$'
name2 db 'Player#2 Name :$'
var1 db 15 dup(?) 
var2 db 15 dup(?)
count db 1
cc db 0


.code  
 
    
main proc			;;;;;;;;;;;;;;;;;;;;;;;;;main


mov bx,@data
mov ds,bx 

mov cc,0
mov count,1

	mov ah,6
	mov al,0
	mov bh,00001110b
	mov ch,0  ;;upper row
	mov cl,0  ;; left column
	mov dh,24 ;; lower row
	mov dl,79 ;; right column
	int 10h

	mov ah,6
	mov al,0
	mov bh,00110100b
	mov ch,10  ;;upper row
	mov cl,45  ;; left column
	mov dh,10 ;; lower row
	mov dl,55 ;; right column
	int 10h
	
	mov ah,6
	mov al,0
	mov bh,00110100b
	mov ch,14  ;;upper row
	mov cl,45  ;; left column
	mov dh,14 ;; lower row
	mov dl,55 ;; right column
	int 10h
	
	mov ah,2h
	mov bh,0
	mov dh,10
    mov dl,28
	int 10h
	
	lea dx,name1
	mov ah,9
	int 21h	
	
	mov ah,2h
	mov bh,0
	mov dh,14
    mov dl,28
	int 10h
	
	lea dx,name2
	mov ah,9
	int 21h
	
	mov ah,2h
	mov bh,0
	mov dh,10
    mov dl,46
	int 10h
	
	lea si,var1     ;;;;; array 1st index
	mov cx,2
	
mslbl:
lb:
; hide blinking text cursor: 
     	mov ch, 32
     	mov ah, 1
     	int 10h
		
   mov ah,1
   int 21h
   cmp al,13 ;;; "Enter" ascii code
   je bahar
   mov [si],al        ;;;;;al to array "si" index
   inc si
   inc count
   cmp count,9
   jl lb
   je bahar

bahar:
inc cc
	mov bl,':'
	mov [si],bl
	inc si
	mov bl,' '
	mov [si],bl
	inc si
      mov bl,'$'      ;;;;;;;ending array 
      mov [si],bl
	  
      
    mov ah,2h
	mov bh,0
	mov dh,14
    mov dl,46
	int 10h
	cmp cc,2
	je rrr
	lea si,var2
	mov count,0
	loop mslbl


rrr:

mov score1,0
mov score2,0
    
;;bacground color
mov ah,6
mov al,0
mov bh,01111100b
mov ch,0  ;;upper row
mov cl,0  ;; left column
mov dh,24 ;; lower row
mov dl,79 ;; right column
int 10h
 

;;; left khelne wala
mov ah,6
mov al,0
mov bh,01000000b
mov ch,10  ;;upper row
mov cl,0  ;; left column
mov dh,15 ;; lower row
mov dl,0 ;; right column
int 10h

mov lsrow,ch
mov lerow,dh


;;; right khelne wala
mov ah,6
mov al,0
mov bh,01000000b
mov ch,10  ;;upper row
mov cl,79  ;; left column
mov dh,15 ;; lower row
mov dl,79 ;; right column
int 10h  

mov rsrow,ch
mov rerow,dh



;;; upper wall
mov ah,6
mov al,0
mov bh,01100000b
mov ch,0  ;;upper row
mov cl,0  ;; left column
mov dh,0 ;; lower row
mov dl,79 ;; right column
int 10h
         
         
         
;;; lower wall
mov ah,6
mov al,0
mov bh,01100000b
mov ch,24  ;;upper row
mov cl,0  ;; left column
mov dh,24 ;; lower row
mov dl,79 ;; right column
int 10h 

bol:
;;;; Ball
mov ah,6
mov al,0
mov bh,00111100b
mov ch,12  ;;upper row
mov cl,40  ;; left column
mov dh,12 ;; lower row
mov dl,41 ;; right column
int 10h 
mov ballxs,cl 
mov ballxe,dl
mov bally,ch

call sleepforball 

						mov ah,6
						mov al,0
						mov bh,01110000b
						mov ch,3  ;;upper row
						mov cl,3  ;; left column			;;;;;1st missed ka kam hold karao
						mov dh,3 ;; lower row
						mov dl,11 ;; right column
						int 10h
						
						mov ah,6
						mov al,0
						mov bh,01110000b
						mov ch,3  ;;upper row
						mov cl,60  ;; left column			;;2nd missed ka kam hold karao
						mov dh,3 ;; lower row
						mov dl,69 ;; right column
						int 10h


; mov mleft,1
; mov mup,1
; mov mdown,0
; mov mright,0

       	mov ah,2h
		mov bh,0
		mov dh,1
        mov dl,55
		int 10h
		
		lea dx,var2
		mov ah,9
		int 21h
		mov dl,score1
		add dl,48
		mov ah,2
		int 21h 
			mov ch, 32
			mov ah, 1
			int 10h
		
		mov ah,2h
		mov bh,0
		mov dh,1
		mov dl,10
		int 10h

		lea dx,var1
		mov ah,9
		int 21h
        mov dl,score2
		add dl,48
		mov ah,2
		int 21h 
			mov ch, 32
			mov ah, 1
			int 10h

lbl: 
mov golbl,0
    mov al,0
    mov ah,1 
    int 16h 
	    
    jz anlbl
    
    mov ah,0h
    int 16h
						
    cmp al,97
    je luper
    
    cmp al,115 
    je lnch1 
    
    cmp al,111
    je rupr1
    
    cmp al,112
    je rnech1 
      

anlbl:

         cmp golbl,1
         je lbl
         cmp mleft,1
         je movleft
		 cmp mright,1
		 je movright

  
    jmp lbl
	
movleft:
		cmp mdown,1
		je movldown1
		
		cmp mup,1
		je movlup1
		
		
movright:
		cmp mdown,1
		je movrdown2
		
		cmp mup,1
		je movrup2
lbl123:
call lbl
    
lnch1:
call lneche 
rupr1:
call rupr
rnech1:
call nechh
  
luper: 

    cmp lsrow,2
    jl lbl123

    mov ah,6
    mov al,0
    mov bh,01110000b

    mov cl,0  ;; left column
    mov dh,lerow ;; lower row
    mov dl,0 ;; right column
    dec lerow
    mov ch,lerow  ;;upper row
    int 10h


    dec lsrow
    
    mov ah,6
    mov al,0
    mov bh,01000000b
    mov ch,lsrow  ;;upper row
    mov cl,0  ;; left column
    mov dh,lerow ;; lower row
    mov dl,0 ;; right column
    int 10h  

jmp lbl 


movldown1:
jmp movldown


movlup1:
jmp movlup

movrup2:
jmp movrup1

movrdown2:
jmp movrdown1

movlupzero:
		mov mup,0
		mov mdown,1
		jmp anlbl
		
		
movldownzero:
		mov mup,1
		mov mdown,0
		jmp anlbl
				
		
movrupzero:
		mov mup,0
		mov mdown,1
		jmp anlbl
		
		
movrdownzero:
		mov mup,1
		mov mdown,0
		jmp anlbl


plusscore1:		
		mov ah,2h
		mov bh,0
		mov dh,1
        mov dl,55
		int 10h
inc score1
		lea dx,var2
		mov ah,9
		int 21h
		mov dl,score1
		add dl,48
		mov ah,2
		int 21h 
		
		;;bacground color
mov ah,6
mov al,0
mov bh,01110000b
mov ch,3  ;;upper row
mov cl,3  ;; left column
mov dh,3 ;; lower row
mov dl,11 ;; right column
int 10h
		mov ah,2h
		mov bh,0
		mov dh,3
		mov dl,3
		int 10h
		
		lea dx,mis
		mov ah,9
		int 21h
		
			mov ch, 32
			mov ah, 1
			int 10h
			
						
		cmp score1,10
		je lost1
		
		mov mleft,0
		mov mup,0
		mov mdown,1
		mov mright,1
		
		call bol
		
lost1:
call lost

gotodown11:
call gotodown1
gotoup1:
call gotoup

plusscore2:      
		mov ah,2h
		mov bh,0
		mov dh,1
		mov dl,10
		int 10h
inc score2
		lea dx,var1
		mov ah,9
		int 21h
        mov dl,score2
		add dl,48
		mov ah,2
		int 21h 
		
				;;bacground color
mov ah,6
mov al,0
mov bh,01110000b
mov ch,3  ;;upper row
mov cl,60  ;; left column
mov dh,3 ;; lower row
mov dl,69 ;; right column
int 10h

		mov ah,2h
		mov bh,0
		mov dh,3
		mov dl,60
		int 10h
		
		lea dx,mis
		mov ah,9
		int 21h
			mov ch, 32
			mov ah, 1
			int 10h

		cmp score2,10
		je lost

		mov mleft,1
		mov mup,0
		mov mdown,1
		mov mright,0
		call bol	
	
restart:
call main
	


gotodown1:
call gotodown



lost:

;;bacground color
	mov ah,6
	mov al,0
	mov bh,00001110b
	mov ch,0  ;;upper row
	mov cl,0  ;; left column
	mov dh,24 ;; lower row
	mov dl,79 ;; right column
	int 10h
	
	mov ah,2h
	mov bh,0
	mov dh,9
    mov dl,34
	int 10h
	
	lea dx,gm
	mov ah,9
	int 21h
	
	
	mov ah,6
	mov al,0
	mov bh,10001110b
	mov ch,17  ;;upper row
	mov cl,0  ;; left column
	mov dh,17 ;; lower row
	mov dl,79 ;; right column
	int 10h
	
		call player
	
	mov ch, 32
    mov ah, 1		; hide blinking text cursor:
    int 10h
	
	c1:
	mov ah,0h
    int 16h
	cmp al,13
	je restart
	jne c1

plusscore11:
call plusscore1

		
movlupzero1:
jmp movlupzero	
		
movleftzero:

;;;; Ball
mov ah,6
mov al,0
mov bh,01111100b
mov ch,bally  ;;upper row
mov cl,ballxs  ;; left column
mov dh,bally ;; lower row
mov dl,ballxe ;; right column
int 10h  


mov bl,lerow
mov cl,lsrow
		cmp bally,bl
		jg plusscore11
		cmp bally,cl
		jl plusscore11

		mov mright,1
		mov mleft,0
		cmp mup,1
		je gotodown
		cmp mdown,1
		je gotoup
		

		
gotodown:
		mov ah,2h
		mov bh,0
		mov dh,1
		mov dl,3
		int 10h

			
		mov mup,0
		mov mdown,1
		jmp anlbl
		
plusscore21:
call plusscore2	
		
gotoup:
		mov ah,2h
		mov bh,0
		mov dh,1
		mov dl,3
		int 10h
	
		mov mup,1
		mov mdown,0
		jmp anlbl
				
	
movlupzero2:
jmp movlupzero1

gotodown111:
call gotodown 
		
movrightzero:
;;;; Ball
mov ah,6
mov al,0
mov bh,01111100b
mov ch,bally  ;;upper row
mov cl,ballxs  ;; left column
mov dh,bally ;; lower row
mov dl,ballxe ;; right column
int 10h

mov bl,rerow
mov cl,rsrow
		cmp bally,bl
                jg plusscore21
		cmp bally,cl
                jl plusscore21


		mov mright,0
		mov mleft,1
		cmp mup,1
		je gotodown111
		cmp mdown,1
		je gotoup	

movldownzero1:
jmp movldownzero	

movrup1:
jmp movrup

movrdown1:
jmp movrdown		

movleftzero1:
jmp movleftzero



movlup:  
	call sleep
	cmp bally,2
        jl movlupzero2
	cmp ballxs,2
	jl movleftzero1
	

	inc golbl
	mov ah,6
	mov al,0
	mov bh,01111100b
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h
	
	mov ah,6
	mov al,0
	mov bh,00111100b
	dec bally
	dec ballxe
	dec ballxs
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h


	 

jmp anlbl


movrupzero1:
jmp movrupzero




movldown:  
	call sleep
	cmp bally,22
	jg movldownzero1
	cmp ballxs,2
	jl movleftzero1
	
	inc golbl
	mov ah,6
	mov al,0
	mov bh,01111100b
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h
	
	mov ah,6
	mov al,0
	mov bh,00111100b
	inc bally
	dec ballxe
	dec ballxs
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h
	 

jmp anlbl

movrightzero1:
jmp movrightzero

movrdownzero1:
jmp movrdownzero


movrup:  
	call sleep
	cmp bally,2
	jl movrupzero1
	cmp ballxe,77
	jg movrightzero1
	
	inc golbl
	mov ah,6
	mov al,0
	mov bh,01111100b
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h
	
	mov ah,6
	mov al,0
	mov bh,00111100b
	dec bally
	inc ballxe
	inc ballxs
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h


	 

jmp anlbl




movrdown:  
	call sleep
	cmp bally,22
	jg movrdownzero1
	cmp ballxe,77
	jg movrightzero1
	
	inc golbl
	mov ah,6
	mov al,0
	mov bh,01111100b
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h
	
	mov ah,6
	mov al,0
	mov bh,00111100b
	inc bally
	inc ballxe
	inc ballxs
	mov ch,bally  ;;upper row
	mov cl,ballxs  ;; left column
	mov dh,bally ;; lower row
	mov dl,ballxe ;; right column
	int 10h


	 

jmp anlbl



labl:
     jmp lbl

rupr:
     jmp ruper


lneche: 


    cmp lerow,22
    jg labl

    mov ah,6
    mov al,0
    mov bh,01110000b

    mov cl,0  ;; left column 
    mov ch,lsrow  ;;upper row

    mov dl,0 ;; right column
    inc lsrow
    mov dh,lsrow ;; lower row
    int 10h

    inc lerow
    
    mov ah,6
    mov al,0
    mov bh,01000000b
    mov ch,lsrow  ;;upper row
    mov cl,0  ;; left column
    mov dh,lerow ;; lower row
    mov dl,0 ;; right column
    int 10h 
    

jmp lbl    

nechh:

jmp rneche 

laabl:
     jmp lbl

ruper: 

    cmp rsrow,2
    jl labl

    mov ah,6
    mov al,0
    mov bh,01110000b

    mov cl,79  ;; left column
    mov dh,rerow ;; lower row
    mov dl,79 ;; right column
    dec rerow
    mov ch,rerow  ;;upper row
    int 10h


    dec rsrow
    
    mov ah,6
    mov al,0
    mov bh,01000000b
    mov ch,rsrow  ;;upper row
    mov cl,79  ;; left column
    mov dh,rerow ;; lower row
    mov dl,79 ;; right column
    int 10h  
    
 
jmp labl 


rneche: 


    cmp rerow,22
    jg laabl

    mov ah,6
    mov al,0
    mov bh,01110000b

    mov cl,79  ;; left column 
    mov ch,rsrow  ;;upper row

    mov dl,79 ;; right column
    inc rsrow
    mov dh,rsrow ;; lower row
    int 10h

    inc rerow
    
    mov ah,6
    mov al,0
    mov bh,01000000b
    mov ch,rsrow  ;;upper row
    mov cl,79  ;; left column
    mov dh,rerow ;; lower row
    mov dl,79 ;; right column
    int 10h 
    
jmp lbl




 main endp
 
 
 
sleep proc

  push cx

     mov cx, 2
 
     lb2:
          push cx
             mov cx, 65535
             lb1:
             loop lb1
             pop cx
      loop lb2


  pop cx
  
ret

sleep endp

player proc
	mov ah,2h
	mov bh,0
	mov dh,17
    mov dl,29
	int 10h
	
	lea dx,var
	mov ah,9
	int 21h
	 cmp score1,10
	 je pehlawala
	 jmp dusrawala
	 
pehlawala:
	mov ah,2h
	mov bh,0
	mov dh,12
    mov dl,34
	int 10h
		
	lea dx,var2
	mov ah,9
	int 21h
	lea dx,wns
	mov ah,9
	int 21h
	
	mov ah,2h
	mov bh,0
	mov dh,14
    mov dl,34
	int 10h
	
	lea dx,var1
	mov ah,9
	int 21h
	lea dx,lst
	mov ah,9
	int 21h
	ret
	
dusrawala:

	mov ah,2h
	mov bh,0
	mov dh,12
    mov dl,34
	int 10h
	
	lea dx,var1
	mov ah,9
	int 21h
	lea dx,wns
	mov ah,9
	int 21h
	
	mov ah,2h
	mov bh,0
	mov dh,14
    mov dl,34
	int 10h
	
	lea dx,var2
	mov ah,9
	int 21h
	lea dx,lst
	mov ah,9
	int 21h

ret
player endp


sleepforball proc

 push cx

     mov cx, 15
 
     outlbl:
          push cx
             mov cx, 65535
             inlbl:
             loop inlbl
             pop cx
      loop outlbl


  pop cx
  
ret

sleepforball endp
 end main  
