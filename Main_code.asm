org 100h 
 
.data


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


msg1 DB 'player no 1 enter a number to bid on', '$'
msg2 DB  'player no 2 enter a number to bid on', '$'
msg3 DB  'bidding numbers are equal please re enter the numbers','$'
string db 5 ;MAX NUMBER OF CHARACTERS ALLOWED (4).
        db ? ;NUMBER OF CHARACTERS ENTERED BY USER.
        db 5 dup (?) ;CHARACTERS ENTERED BY USER. 




enter_choice db 'Enter your Choice = ',0dh,0ah,'$' 
enter_valid db 'Enter Valid number',0dh,0ah,'$'


prompt_1 db 'player','$'
prompt_2 db ' : please enter a position', 0AH, 0DH, '$' 
err_msg db 'the position is already taken', 0AH,0DH,'$'
invalid_msg db 'Invalid position', 0AH, 0DH, '$'

counter dw 0
;----------------\\
letter db  'X'
position db 0
flag db 0   
JUMP db 0

empty_line db '     |     |     ',0Ah,0DH,'$'   ;0DH moves to the curser to the beginning
                                                                                                                  
empty_line_dashed db '_____|_____|_____',0Ah,0DH,'$'

option_1 db 'Player 1 (X) - Player 2 (O)',0AH, 0DH, 0AH, 0DH, 0AH, 0DH, '$'
option_2 db 'Player 1 (X) - Player 2 (O)',0AH, 0DH ,'         (Bidding) ',0AH, 0DH,0AH, 0DH,0AH, 0DH, '$'
option_3 db 'Player (X) - Computer (O)', 0AH, 0DH,0AH, 0DH, '$'


SQUARE	db  '1','2','3','4','5','6','7','8','9'


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
    je Else2 
    cmp bl, 3
    je Else_If 
     
do: 
    mov ax, 13h     ; Clear Screen
    int 10h     
    call board
    call check_valid
    mov ax, 13h     ; Clear Screen
    int 10h  
    call board
    mov ax, 13h     ; Clear Screen
    int 10h 
    
    mov al, player  
    add al, 1
    mov si,offset player
    mov BYTE PTR [si], al 
    
    call check 
     
     
    cmp ax, -1
    je do           ; while loop
    
    mov al, player  
    sub al, 1
    mov si,offset player
    mov BYTE PTR [si], al   
    
    cmp ax, 0
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
    
    
       
    
    
Else2: 
     call isEmpty        ; get value if 1 or 0
     cmp ax, 0
     je bot
     
     mov ax, 13h     ; Clear Screen
     int 10h 
     call board
     call bidding_board
     
     call check

     cmp ax, -1
     je Else2
     
     cmp ax, 0
     jne Print
     mov ah,09h      ; print phrase
     mov dx, offset Draw 
     int 21h
     jmp bot   



Print:
    mov al, playerbidding
    cmp al, 2
    je  S1
    mov ah,09h      ; print phrase
    mov dx, offset Player1 
    int 21h    
    jmp bot
    
    
S1:
    mov ah,09h      ; print phrase
    mov dx, offset Player2 
    int 21h    
    jmp bot  
    
    

Else_If:
 
    
do2:    
    mov ax, 13h     ; Clear Screen
    int 10h   
    call board
P1: 
    call check_valid  
    mov ax, 13h     ; Clear Screen
    int 10h  
    call board
p2:    
    mov ax, 13h     ; Clear Screen
    int 10h 
    
    mov al, player  
    add al, 1
    mov si,offset player
    mov BYTE PTR [si], al 
    
    call check
  
    cmp ax, -1
    
    je do2           ; while loop
    
    mov al, player  
    sub al, 1
    mov si,offset player
    mov BYTE PTR [si], al   
    
    cmp ax, 0
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
