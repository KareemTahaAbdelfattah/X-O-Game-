

org  100h	; set location counter to 100h

.data
  msg1 DB 'player no 1 enter a number to bid on', '$'
  msg2 DB  'player no 2 enter a number to bid on', '$'
 bid_player1 db 1 dup<?> 
 bid_player2 db 1 dup<?>


.code 
   
   
  
   
 main proc


        
     call bidding_board
      
    Exit:       ;Mark exit of code segment
    MOV AH, 4CH ;4CH = DOS exit fuction. Handover the control to OS and exit program
    INT 21H    
           
      main endp 
     
  
    ;newline function  
    newline proc   
        
        mov ah, 02h
        mov dl, 13
        int 21h
        mov dl, 10
        int 21h 
    
    ret   
    newline endp  
    
    
    
    ;bidding function
    
    bidding_board proc 
        
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
         
         
        ;take multiple character input from user and save it in a variable 
        mov ax,@data
        mov ds,ax
        mov ax,0000
        
        
        mov si,offset bid_player1
        
        l1: 
        mov ah,01h
        int 21h
        mov [si],al
        inc si
        cmp al,'$'
        jne l1
          
        call newline  
       
        mov ah,09h
        lea dx,bid_player1
        int 21h   
        
        
        
         ; display the second message for the user 
         call newline
           
         MOV AX,@DATA 
         MOV DS,AX 
          
         ; load address of the string1
         LEA DX,msg2
          
         ;output the string
         ;loaded in dx 
         MOV AH,09H
         INT 21H 
         ;call function to print new line between the strings   
         call newline   
            
        ;take multiple character input from user and save it in a variable 
        mov ax,@data
        mov ds,ax
        mov ax,0000
        
        
        mov si,offset bid_player2
        
        l2: 
        mov ah,01h
        int 21h
        mov [si],al
        inc si
        cmp al,'$'
        jne l2
          
        call newline  
       
        mov ah,09h
        lea dx,bid_player2
        int 21h   

      ret 
      
     bidding_board endp
    
    
    
     
  end main

ret  

























