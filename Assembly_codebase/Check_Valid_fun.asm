 org 100h 
 
.data



enter_choice db 'Enter your Choice = ',0dh,0ah,'$' 
enter_valid db 'Enter Valid number',0dh,0ah,'$'

  
SQUARE	db  0,1,2,3,4,5,6,7,8,9 


player db 1
option db 2
player1count db 64
player2count db 64
input   db  0
temp    db  0
status  db  0   
playerbidding   db  0
 
    
.code 


check_valid:  
    mov ax, @data
    mov ds, ax
    mov ax, 0
    mov al, option
    cmp al, 3  
    jne C4
    mov al, player
    mov bl, 2
    div bl
    cmp ah, 0
    jne C3 
    
RANDGEN:        ; generate a rand no using the system time
RANDSTART: 

    MOV AH, 00h  ; interrupts to get system time        
    INT 1AH      ; CX:DX now hold number of clock ticks since midnight      
                 ; lets just take the lower bits of DL for a start..
    mov ax,dx

    xor dx,dx
    
    mov cx,6
    
    div cx ; here dx contains the remainder of the division - from 0 to 9
    
    add dx,1
    
    MOV bl, 'X'
    mov cx, 0  
    mov cl, dl 
    mov si, offset SQUARE
    add si, cx
    mov al, [si]
    cmp al, bl
    je RANDSTART
    
    MOV bl, 'O'
    mov cx, 0
    mov cl, dl      
    mov si, offset SQUARE
    add si, cx 
    mov al, [si]
    cmp al, bl
    je RANDSTART
       

    mov BYTE PTR [si], 'O'
    
    jmp bot
    
    
  
C31:
    MOV dl, 10
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h 
    mov dx, offset enter_valid 
    int 21h 
    jmp C3             
          
C3: 
    mov ah,09h 
    mov dx, offset enter_choice 
    int 21h
    MOV AH,01h      
    INT 21h
    sub al, 48 
    mov bl, 1
    cmp al, bl
    jb C31
    mov bl, 9
    cmp al, bl
    ja C31
      
    mov bl, 'O'
    mov cx, 0  
    mov cl, al
    mov si, offset SQUARE
    add si, cx
    mov al, [si]
    cmp al, bl
    je C31
    
    mov bl, 'X'
    mov cx, 0  
    mov cl, al
    mov si, offset SQUARE
    add si, cx
    mov al, [si]
    cmp al, bl
    je C31     
    
    
    mov BYTE PTR [si], 'X'
    
    jmp bot
    

C41:
    MOV dl, 10
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h 
    mov dx, offset enter_valid 
    int 21h 
    jmp C4
             
C4:
    mov ah,09h 
    mov dx, offset enter_choice 
    int 21h
    MOV AH,01h      
    INT 21h
    sub al, 48
    cmp al, 1
    jb C41
    cmp al, 9
    ja C41
    
    mov bl, 'O'
    mov cx, 0  
    mov cl, al
    mov si, offset SQUARE
    add si, cx
    mov al, [si]  
    cmp al, bl
    je C41
    
    mov bl, 'X'
    mov cx, 0  
    mov cl, al
    mov si, offset SQUARE
    add si, cx
    mov al, [si]
    cmp al, bl
    je C41  

    mov ax, 0  
    mov al, player
    mov dx, 0
    mov dl, 2
    div dl
    cmp ah, 0
    jne C44 
    mov BYTE PTR [si], 'O'
    jmp bot

C44:
    mov BYTE PTR [si], 'X'       
    jmp bot
 
bot:
    jmp check_valid
 

.exit:
END
