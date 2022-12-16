org 100h

.data

  BOARD DB 0,1,2,3,4,5,6,7,8,9


.code



check proc
  mov ax,@data
  mov ds,ax  
          
     mov si,offset BOARD     
     mov cx,0
          
     mov dh,1
L0:  mov cl,dh
     mov dl,0
L1:  add si,cx
     mov al,[si]
     inc cl
     add si,cx
     mov bl,[Si]
     cmp al,bl
     jne next1
     inc dl
     cmp dl,2
     jne L1
     jmp R1 
           
 
next1:
      cmp cl,9
      je cond2
      add dh,3
      jmp L0


cond2:   mov dh,1
   L2:   mov cl,dh
         mov dl,0
   L3:   add si,cx
         mov al,[si]
         add cl,3
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne next2
         inc dl
         cmp dl,2
         jne L3
         jmp R1 
           
 
next2:
      cmp cl,9
      je cond3
      inc dh
      jmp L2 
      
      
 
cond3:   mov dh,1
   L4:   mov cl,dh
         mov dl,0
   L5:   add si,cx
         mov al,[si]
         add cl,4 
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne cond4
         inc dl
         cmp dl,2
         jne L5
         jmp R1
         
         
         
cond4:   mov dh,3
   L6:   mov cl,dh
         mov dl,0
   L7:   add si,cx
         mov al,[si]
         add cl,2 
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne final
         inc dl
         cmp dl,2
         jne L5
         jmp R1 


final:  jmp isEmpty
        cmp ax,1
        je  R3
        jmp R2    
    
 R1:
    mov ax,1
    endp
 R2:
    mov ax,0 
    endp
 R3:
    mov ax,1
    neg ax 
    endp




isEmpty: mov cl,0 
     E1: inc cl
         cmp cl,10
         je E2
         mov dl,88
         add si,cx
         cmp dl,[si]
         je E1
         mov dl,79
         add si,cx
         cmp dl,[si]
         je E1
         jmp E3
     
     
     E2: mov ax,0
         ret
         
     E3: mov ax,1
         ret          