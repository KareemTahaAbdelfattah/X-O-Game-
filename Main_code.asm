org 100h 
 
.data



enter_choice db 'Enter your Choice = ',0dh,0ah,'$' 
enter_valid db 'Enter Valid number',0dh,0ah,'$'
Tic_tac db 'Tic Tac Toe',0dh,0ah,'$'  
choose_mode db 'Choose mode of Game :- ',0dh,0ah,'$'  
playervsplayer db '(1) ----->     Player Vs Player       <------',0dh,0ah,'$' 
playervsplayerB db '(2) -----> Player Vs Player (Bidding) <------',0dh,0ah,'$'
playervscomputer db '(3) -----> Player Vs Computer (Easy)  <------',0dh,0ah,'$'
ReEnter db 're enter option again: ',0dh,0ah,'$'
Draw db 'Game Draw',0dh,0ah,'$'
Player1 db 'Player 1 won!',0dh,0ah,'$'
Player2 db 'Player 2 won!',0dh,0ah,'$' 
Computer db 'Computer won!',0dh,0ah,'$'
PlayerWon db 'Player won!',0dh,0ah,'$'

  
SQUARE	db  0,1,2,3,4,5,6,7,8,9 


player db 0
option db 0
player1count db 64
player2count db 64
input   db  0
temp    db  0
status  db  0   
playerbidding   db  0
 
    
.code 


main:
    mov ax, @data
    mov ds, ax
    mov ax, 0
    mov ax, 13h     ; Clear Screen
    int 10h 
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h      ; print phrase
    mov dx, offset Tic_tac 
    int 21h
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h      ; print phrase
    mov dx, offset choose_mode 
    int 21h
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h      ; print phrase
    mov dx, offset playervsplayer 
    int 21h
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h      ; print phrase
    mov dx, offset playervsplayerB 
    int 21h
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h               
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    mov ah,09h      ; print phrase
    mov dx, offset playervscomputer 
    int 21h
    
    
Re: 
    MOV dl, 10      ; make a new line
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    MOV AH,01h      
    INT 21h
    Sub al, 48
    cmp al, 1
    jb R9
    cmp al, 3
    ja R9    
    mov si,offset option
    mov BYTE PTR [si], al
    mov bl, option
    cmp bl, 2
    je Else 
    cmp bl, 3
    je Else_If 
     
do:     
    ;jmp Board()
    ;jmp check_valid() 
    ;jmp Board()
    
    mov al, player  
    add al, 1
    mov si,offset player
    mov BYTE PTR [si], al 
    
    ;jmp checkwin() then take ret value at cx
    
    cmp cx, -1
    je do           ; while loop
    
    mov al, player  
    sub al, 1
    mov si,offset player
    mov BYTE PTR [si], al   
    
    cmp cx, 0
    je Equal
    
    mov dl, al
    mov ax, 0
    div dl
    cmp ah, 0
    je NEqual
    cmp ah, 0
    jne NNEqual    
    
    
    
R9: 
    mov ah,09h              ; print phrase
    mov dx, offset ReEnter 
    int 21h
    jmp Re 
    
    
       
    
    
Else: 
    





       
       
       
      
    jmp bot   
    
    

Else_If: 

    ;jmp Board()
    ;jmp check_valid() 
    ;jmp Board()
    
    mov al, player  
    add al, 1
    mov si,offset player
    mov BYTE PTR [si], al 
    
    ;jmp checkwin() then take ret value at cx
    
    cmp cx, -1
    je do           ; while loop
    
    mov al, player  
    sub al, 1
    mov si,offset player
    mov BYTE PTR [si], al   
    
    cmp cx, 0
    je Equal
    
    mov dl, al
    mov ax, 0
    div dl
    cmp ah, 0
    je NEqual2
    cmp ah, 0
    jne NNEqual2

            
    jmp bot 
    
    
Equal:
    mov ah,09h      ; print phrase
    mov dx, offset Draw 
    int 21h  
    
    jmp bot
    
NEqual:
    mov ah,09h      ; print phrase
    mov dx, offset Player2 
    int 21h 
     
    jmp bot 
    
NNEqual:               
    mov ah,09h      ; print phrase
    mov dx, offset Player1 
    int 21h   
       
    jmp bot  
    
    
NEqual2:
    mov ah,09h      ; print phrase
    mov dx, offset Computer 
    int 21h 
     
    jmp bot 
    
NNEqual2:               
    mov ah,09h      ; print phrase
    mov dx, offset PlayerWon 
    int 21h   
       
    jmp bot    
        


    
bot:
    
 

.exit:
END
