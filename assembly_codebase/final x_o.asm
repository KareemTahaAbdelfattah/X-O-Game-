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

vc db 0
    
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
    
    mov cl, al
    
    mov al, player  
    sub al, 1
    mov si,offset player
    mov BYTE PTR [si], al   
    
    cmp cl, 0
    je Equal
    
    mov dx, 0
    mov ah, 0
    mov dl, 2
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
    
    mov ax, 13h     ; Clear Screen
    int 10h 
    call board
    
    
    mov ah,09h      ; print phrase
    mov dx, offset Player1 
    int 21h    
    jmp bot
    
    
S1:

    mov ax, 13h     ; Clear Screen
    int 10h 
    call board
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
    
P2:    
    mov ax, 13h     ; Clear Screen
    int 10h 
    
    mov al, player  
    add al, 1
    mov si,offset player
    mov BYTE PTR [si], al 
    
    call check
  
    cmp ax, -1
    
    je do2           ; while loop
     
    mov cl, al 
     
    mov al, player  
    sub al, 1
    mov si,offset player
    mov BYTE PTR [si], al   
    
    
    
    cmp cl, 0
    je Equal
    
    mov dx, 0
    mov ah, 0
    mov dl, 2
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
  
    ;newline function  
    newline proc   
        
        mov ah, 02h
        mov dl, 13
        int 21h
        mov dl, 10
        int 21h 
    
    ret   
    newline endp  
     
    ;************************func to convert string to integer value ***************************
     
    ;CONVERT STRING TO NUMBER IN BX.
proc string_to_number         
        ;MAKE SI TO POINT TO THE LEAST SIGNIFICANT DIGIT.
           
          mov si, offset string+1         
          mov  cl, [ si ]                                        
          mov  ch, 0 
          add  si, cx 

        
        ;CONVERT STRING.
          mov  bx, 0
          mov  bp, 1 ;MULTIPLE OF 10 TO MULTIPLY EVERY DIGIT.
        repeat:         
        ;CONVERT CHARACTER.                      
          mov  al, [ si ] ;CHARACTER TO PROCESS. 
          sub  al, 48 
          mov  ah, 0
          mul  bp ;AX*BP = DX:AX.
          add  bx,ax         
          mov  ax, bp
          mov  bp, 10
          mul  bp 
          mov  bp, ax  
        ;CHECK IF WE HAVE FINISHED.
          dec  si 
          loop repeat   ; Cx is used as counter by default in loop and will be decremneted each time the loop is repeated
        
      ret 
    string_to_number endp  
    
 
    ;bidding function
    bidding_board proc  
         label1:    
         call newline  
         MOV AX,@DATA 
         MOV DS,AX 
         
         ; load address of the string1
         LEA DX,msg1
         
         ;output the string
         ;loaded in dx 
         MOV AH,09H
         INT 21H 
         ;call function to print new line between the strings   
         call newline   
         
         
         
         ;*********************** new code ******************************************* 
         
                  ;------------------------------------------
        ;CAPTURE CHARACTERS (THE NUMBER).
          mov  ah, 0Ah
          mov  dx, offset string
          int  21h  
          mov di,offset string+2
          mov dl,[di]
          cmp dl,'A'
          JGE label1
        ;------------------------------------------
          call string_to_number
          mov di,BX       
          cmp di,100 ; Di contain the first player bid number
          JG label1  
          jmp label2  
             
             
         ;*************** ask the second user for bidding number *****************
         
             
         label2:       
         ; display the second message for the user 
         call newline
;           
;         MOV AX,@DATA 
;         MOV DS,AX 
;                   
         ; load address of the string1
         LEA DX,msg2
          
         ;output the string
         ;loaded in dx 
         MOV AH,09H
         INT 21H 
         ;call function to print new line between the strings   
         call newline   
            
          ;CAPTURE CHARACTERS (THE NUMBER).
          mov  ah, 0Ah
          mov  dx, offset string
          int  21h 
          
          mov si,offset string+2
          mov dl,[si]
          cmp dl,'A'
         
          JGE label2 
        ;------------------------------------------
          call string_to_number
          call newline      
          cmp BX,100 ; Bx contain the second player bid number
          JG label2  
          jmp check_label 
          
         
       ;***************** check who has the right to play ****************** if else statement***********
         ;Di =bid_player1 BX=bid_player2 
         check_label:
         mov AX,0 ;player1_count
         mov dx,0 ;player2_count
          
         cmp Di,BX 
         JG check_label2 ;if di> bx means bid number of player 1 is greater
         JL check_label3  
         
         ;if the numbers are equal will execute those lines 
         ;******************************************************
         ; load address of the msg3
         LEA DX,msg3
         
         ;output the string
         ;loaded in dx 
         MOV AH,09H
         INT 21H 
        
         Jmp label1
         ;***********************************************
          
        check_label2: ;if di>bx 
        sub AX,di
        add AX,di 


        mov si,offset playerbidding
        mov BYTE PTR [si], 1
          
        ;here we need to call board function to play   
        mov si,offset player
        mov BYTE PTR [si], 1
        
        call play_board 
      
         ret
        check_label3: ;if di<bx
        sub dx,BX
        add AX,BX  
        mov si,offset playerbidding
        mov BYTE PTR [si],2
            
        ;here we need to call board function to play   
         mov si,offset player
         mov BYTE PTR [si], 2
         call play_board 
         

 
      ret 
      
     bidding_board endp
     
     
     
     
check proc
          
     mov si,offset SQUARE     
     mov cx,0
          
     mov dh,0
L0:  mov si,offset SQUARE
     mov cl,dh
     mov dl,0
L1:  mov si,offset SQUARE
     add si,cx
     mov al,[si]
     inc cl 
     mov si,offset SQUARE
     add si,cx
     mov bl,[Si]
     cmp al,bl
     jne next1
     inc dl
     cmp dl,2
     jne L1
     jmp R1 
           
 
next1:
      cmp dh,6
      je cond2
      add dh,3
      jmp L0

cond2:   mov si,offset SQUARE 
         mov dh,0 
   L2:   mov si,offset SQUARE
         mov cl,dh
         mov dl,0
   L3:   mov si,offset SQUARE
         add si,cx
         mov al,[si]
         add cl,3
         mov si,offset SQUARE
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne next2
         inc dl
         cmp dl,2
         jne L3
         jmp R1 
           
 
next2:
      cmp dh,2
      je cond3
      inc dh
      jmp L2 
      
      
cond3:   mov si,offset SQUARE
         mov dh,0 
   L4:   mov si,offset SQUARE
         mov cl,dh
         mov dl,0 
   L5:   mov si,offset SQUARE
         add si,cx
         mov al,[si]
         add cl,4
         mov si,offset SQUARE 
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne cond4
         inc dl
         cmp dl,2
         jne L5
         jmp R1
         
         
cond4:   mov si,offset SQUARE
         mov dh,2
   L6:   mov si,offset SQUARE
         mov cl,dh
         mov dl,0
   L7:   mov si,offset SQUARE
         add si,cx
         mov al,[si]
         add cl,2
         mov si,offset SQUARE 
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne final
         inc dl
         cmp dl,2
         jne L7
         jmp R1 


final:  jmp isEmpty
   f1:  cmp ax,1
        je  R3
        jmp R2    
    
 R1:
    mov ax,1
    ret
 R2:
    mov ax,0 
    ret
 R3:
    mov ax,1
    neg ax 
    ret



check_valid:  
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
    
    mov cx,9
    
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
    
    ret
    
    
  
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
    sub al, 49 
    cmp al, 0
    jb C31
    cmp al, 8
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
    mov si, offset SQUARE
    add si, cx
    mov al, [si]
    cmp al, bl
    je C31     
    
    
    mov BYTE PTR [si], 'X'
    
    ret
    

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
    sub al, 49
    cmp al, 0
    jb C41
    cmp al, 8
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
    ret

C44:
    mov BYTE PTR [si], 'X'       
    ret



isEmpty: mov si,offset SQUARE
         mov cl,-1 
     E1: mov si,offset SQUARE
         inc cl
         cmp cl,9
         je E2
         mov dl,88
         add si,cx
         cmp dl,[si]
         je E1
         mov si,offset SQUARE
         mov dl,79
         add si,cx
         cmp dl,[si]
         je E1
         jmp E3
     
     
     E2: mov ax,0
         jmp f1
         
     E3: mov ax,1
         jmp f1 
bot: 


.exit:
END
