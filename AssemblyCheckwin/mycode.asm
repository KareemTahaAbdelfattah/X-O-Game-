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
L0:  mov si,offset BOARD
     mov cl,dh
     mov dl,0
L1:  mov si,offset BOARD
     add si,cx
     mov al,[si]
     inc cl 
     mov si,offset BOARD
     add si,cx
     mov bl,[Si]
     cmp al,bl
     jne next1
     inc dl
     cmp dl,2
     jne L1
     jmp R1 
           
 
next1:
      cmp dh,7
      je cond2
      add dh,3
      jmp L0

cond2:   mov si,offset BOARD 
         mov dh,1 
   L2:   mov si,offset BOARD
         mov cl,dh
         mov dl,0
   L3:   mov si,offset BOARD
         add si,cx
         mov al,[si]
         add cl,3
         mov si,offset BOARD
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne next2
         inc dl
         cmp dl,2
         jne L3
         jmp R1 
           
 
next2:
      cmp dh,3
      je cond3
      inc dh
      jmp L2 
      
      
cond3:   mov si,offset BOARD
         mov dh,1 
   L4:   mov si,offset BOARD
         mov cl,dh
         mov dl,0 
   L5:   mov si,offset BOARD
         add si,cx
         mov al,[si]
         add cl,4
         mov si,offset BOARD 
         add si,cx
         mov bl,[si]
         cmp al,bl
         jne cond4
         inc dl
         cmp dl,2
         jne L5
         jmp R1
         
         
cond4:   mov si,offset BOARD
         mov dh,3
   L6:   mov si,offset BOARD
         mov cl,dh
         mov dl,0
   L7:   mov si,offset BOARD
         add si,cx
         mov al,[si]
         add cl,2
         mov si,offset BOARD 
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
         jmp f1
         
     E3: mov ax,1
         jmp f1          