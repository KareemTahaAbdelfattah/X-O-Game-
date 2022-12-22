org 100h

.data

option  DB  1; option chosen   

empty_line db '    |    |    ',0Ah,0DH,'$'   ;0DH moves to the curser to the beginning
                                         ;0AH also invisible and moves to next line
                                                                                                                  
empty_line_dashed db '____|____|____',0Ah,0DH,'$'
 
SQUARE	DB  0,1,2,3,4,5,6,7,8,9 ; define the square board


.code
call clear ; clear the screen

; if(op == 1)
MOV AL, option
cmp AL, 1 
jne  first_else
; TODO: printf("Player 1  (X)  -  Player 2 (O)\n\n\n");
end_if_else:


mov dx,offset empty_line 
call print_dx; handles the interrupt and returns here


; TODO : print first char of square array


mov dx,offset empty_line_dashed 
call print_dx; handles the interrupt and returns here 
call print_dx  
MOV AH, 02h
MOV SI, offset square
MOV DL, [SI]
int 21
; TODO rest of program
 
 
jmp exit 
second_else:
    pusha
    MOV AL, option
    cmp AL, 3
    jne end_if_else
    ; TODO:  printf("Player   (X)  -  Computer (O)\n\n\n");
    popa
    jmp end_if_else


first_else:
    pusha
    MOV AL, option
    cmp AL, 2
    jne second_else
    ; TODO:  printf("Player 1 (X)  -  Player 2 (O)\n           (Bidding) \n\n\n");
    popa  
    jmp end_if_else 


print_dx:  
    pusha
    mov ah,09H  ; print a string
    int 21h     ; bios interrupt 21 read the wiki for more
    popa
    ret         ; return to caller

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