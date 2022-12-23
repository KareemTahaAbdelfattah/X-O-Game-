    org 100h

.data


prompt_1 db 'player','$'
prompt_2 db ' : please enter a position', 0AH, 0DH, '$' 
err_msg db 'the position is already taken', 0AH,0DH,'$'
invalid_msg db 'Invalid position', 0AH, 0DH, '$'

counter dw 0
;----------------\\
letter db  'X'
position db 2
player db 2
flag db 0   
status db 0
 
SQUARE	DB  '0','1','2','3','4','5','6','7','8','9' ; define the square board  


.code       
call clear ; clear the screen  

MOV AL, player
cmp AL, 1 ; if(option!= 1 )
jne else 

MOV SI, offset letter
MOV [SI], 'X'

end_if:
MOV BL, [SI] 
MOV BH, 00H                                       
outter_while:                                     
    call prompt
    ; take input  
    MOV AH, 1H
    int 21H  
    call new_line  
    MOV [position], AL

    ; ==> get square[position]
    ; get square offset
    MOV SI, offset SQUARE
    ; get position value 
    MOV AL, [position]
    ; clear AH
    MOV AH, 00H
    ; get square at [position] value
    SUB AX, 30H  ; ASCII Value to normal value
    ADD SI, AX
    MOV AL, [SI] 
    ;ADD AL, 30H      ; convert ascii to char
    ;MOV AH, 0EH
    ;int 10H
    ; ==> if/else check with square[position]
    ; compare it with 'x'
    CMP AL, 'X'    
    ; move to body_1 if it is true
    JE body_1
    ; compare it with 'O'
    CMP AL, '0'
    ; move to body_1 if it's true
    JE body_1
    ; else to else_1
    JMP else_1
    
    body_1: 
        MOV DX, offset err_msg
        call print_DX    
        MOV [flag], 1
    
    else_1:
    inner_while:
        MOV AL, [position]
        cmp AL, '1'
        je case_success
        cmp AL, '2'
        je case_success
        cmp AL, '3'
        je case_success
        cmp AL, '4'
        je case_success
        cmp AL, '5'
        je case_success
        cmp AL, '6'
        je case_success            
        cmp AL, '7'
        je case_success
        cmp AL, '8'
        je case_success
        cmp AL, '9'
        je case_success
        ; ***done*** TODO implement case failure
        MOV DX, offset invalid_msg   
        MOV AH, 09H
        int 21H    
        ; call board()
        MOV [flag], 1        
        jmp after_switch
        case_success:
            ; TODO implement case success
            ; ==> get square[position]
            ; get square offset
            MOV SI, offset SQUARE
            ; get position value 
            MOV AL, [position]
            ; clear AH
            MOV AH, 00H
            ; get square at [position] value
            SUB AX, 30H  ; ASCII Value to normal value
            ADD SI, AX
            Mov AH, [letter] 
            ; save value of letter into square[position]
            MOV [SI], AH     
            MOV [flag], 0
        after_switch:
        ; inner while  
        ;jmp inner_while
        ; outter while
        MOV AL, [flag]
        cmp AL, 1
        je  outter_while
        MOV AL, [status]
        cmp AL, 1
        jne outter_while 


jmp exit  

prompt:           
    pusha    
    
    MOV DX, offset prompt_1
    call print_dx
    
    MOV AL, [player]
    MOV AH, 0EH     
    ADD AL, 48     ; add 48 to convert to ascii
    int 10H        
    
    MOV DX, offset prompt_2
    call print_dx
    
    popa
    ret





else:
    pusha
    MOV AL, player
    cmp AL, 2
    jne end_if
    
    MOV SI, offset letter
    MOV [SI], 'O'

    popa  
    jmp end_if 


print_dx:  
    push ax
    mov ah,09H  ; print a string
    int 21h     ; bios interrupt 21 read the wiki for more
    pop ax
    ret         ; return to caller



    
new_line:
    pusha
    ;MOV DL, 0EH
    MOV AH, 0EH
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