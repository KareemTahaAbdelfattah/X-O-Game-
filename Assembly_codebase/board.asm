org 100h

.data

option  DB  2; option chosen   

empty_line db '     |     |     ',0Ah,0DH,'$'   ;0DH moves to the curser to the beginning
                                                                                                                  
empty_line_dashed db '_____|_____|_____',0Ah,0DH,'$'

option_1 db 'Player 1 (X) - Player 2 (O)',0AH, 0DH, 0AH, 0DH, 0AH, 0DH, '$'
option_2 db 'Player 1 (X) - Player 2 (O)',0AH, 0DH ,'         (Bidding) ',0AH, 0DH,0AH, 0DH,0AH, 0DH, '$'
option_3 db 'Player (X) - Computer (O)', 0AH, 0DH,0AH, 0DH, '$'
counter dw 0

 
SQUARE	DB  '1','2','3','4','5','6','7','8','9' ; define the square board    


.code 
call clear ; clear the screen  



MOV AL, option
cmp AL, 1 ; if(option!= 1 )
jne first_else
;****doone*** TODO printf("Player 1 (X) - Player 2 (O)\n\n\n"); 
MOV DX, offset option_1                          
call print_DX
end_if_else:                                        
             
MOV DX, offset empty_line                          
call print_DX

call print_char_line

MOV DX, offset empty_line_dashed 
call print_DX

MOV DX, offset empty_line
call print_DX

call print_char_line   

MOV DX, offset empty_line_dashed
call print_DX  

MOV DX, offset empty_line
call print_DX

call print_char_line

MOV DX, offset empty_line
call print_DX


jmp exit  




second_else:
    pusha
    MOV AL, option
    cmp AL, 3
    jne end_if_else
    ; TODO:  printf("Player   (X)  -  Computer (O)\n\n\n");
    MOV DX, offset option_3                          
    call print_DX
    popa
    jmp end_if_else


first_else:
    pusha
    MOV AL, option
    cmp AL, 2
    jne second_else
    ;***done*** TODO:  printf("Player 1 (X)  -  Player 2 (O)\n           (Bidding) \n\n\n");
    MOV DX, offset option_2                          
    call print_DX
    popa  
    jmp end_if_else 


print_dx:  
    pusha
    mov ah,09H  ; print a string
    int 21h     ; bios interrupt 21 read the wiki for more
    popa
    ret         ; return to caller

print_char_line: 
    pusha
    MOV AH, 0EH 
    MOV AL, ' '
    int 10H
    int 10H 
    MOV SI, offset SQUARE 
    MOV BX, offset counter
    MOV CX, [BX]
    ADD SI, CX
    ADD CX, 3
    MOV [BX], CX    
    call print_char_incr_SI
    MOV AL, ' '
    int 10H
    int 10H
    MOV AL, '|'
    int 10H
    MOV AL, ' '
    int 10H
    int 10H 
    call print_char_incr_SI
    MOV AL, ' '
    int 10H
    int 10H
    MOV AL, '|'
    int 10H
    MOV AL, ' '
    int 10H
    int 10H
    call print_char_incr_SI 
    call new_line    
    popa
    ret
print_char_incr_SI:
    MOV AH, 0EH
    MOV AL, [SI] 
    ADD SI, 1
    int 10H 
    ret
new_line:
    pusha
    MOV DL, 0EH
    MOV AL, 0AH
    int 10H
    MOV AL, 0DH
    int 10H
    popa
    ret
    

;clear screen
clear:
    pusha
    mov AX, 0600H ;
    mov BH, 07
    mov CX, 0000
    mov DX, 184FH
    INT 10H 
    popa
    ret

exit: