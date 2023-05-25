;Chua Edric Jarvis S14

section .data
signal dd  -1, 3, 4, 0, 9, 0x80000000
scan db "%d",0

scan2 db '%s',0
sigal_Length dd 0
h0 dd 0 
h1 dd 0 
h2 dd 0 
strvar db 0 
counter dd 2
comma_counter dd 2

Ask_H0 db "Enter coefficient h0: ",10, 0
Ask_H1 db "Enter coefficient h1: ",10, 0
Ask_H2 db "Enter coefficient h2: ",10, 0

ecx_counter dd 0
clrstr db "cls",0
x_h0 dd 0
x_h1 dd 0
x_h2 dd 0
result dd 0
output_Sigal db "Filter output:", 10 ,0
Restart db 10, "Want to try again? (Y/N):", 10, 0
output_Length db "The signal has %d" , 0
answer dd "%d", 0
comma db ", ", 0
samples db " samples", 10,0


section .text

extern printf, system, scanf, gets
global main

main:

    mov ebp, esp ; for correct debugging
    push clrstr
    call system
    add esp, 4

starthere:    
       
    xor eax, eax 
    mov esi, signal
    mov dword [sigal_Length], 0
count:  
    mov eax, dword [esi]
    
    cmp eax, 0x80000000
    je count_end
  
    inc dword [sigal_Length]
    add esi, 4
    jmp count 
    
count_end:

    push dword [sigal_Length]
    push output_Length
    
    call printf
    add esp, 8
    
    Push samples
    call printf
    add esp, 4
    
;enter h's
    ;h0
    push Ask_H0
    call printf
    add esp, 4
    
    push h0
    push scan
    call scanf
    add esp, 8
    ;h1
    push Ask_H1
    call printf
    add esp, 4
    
    push h1
    push scan
    call scanf
    add esp, 8
    
    ;h2
    push Ask_H2
    call printf
    add esp, 4
    
    push h2
    push scan
    call scanf
    add esp, 8
   
 
    
    

  xor ebx, ebx
  xor ecx, ecx
  

  mov dword[ecx_counter], 0
  mov dword[comma_counter], 0
  mov dword[counter], 2

  
     push output_Sigal
     
     call printf
     add esp, 4
     
     
loop_start:
   mov esi, signal 
   mov ebx,  dword[counter]
   mov ecx , dword[ecx_counter]
   mov dword[result],0
   inc dword[comma_counter]
   
   cmp dword [esi+(ebx*4)], 0x80000000 ; check if the current element is the terminating value 
   je loop_end
   
  
   
   
   
   
   mov eax, [esi+ ecx*4 ]
   imul dword[h2]
   mov dword[x_h2], eax
   inc ecx
   


   mov eax, [esi + ecx*4]
   imul dword[h1]
   mov dword[x_h1], eax
   inc ecx
   
   mov eax, [esi + ecx*4]
   imul dword[h0]
   mov dword[x_h0], eax


   mov eax, dword[x_h0]
   add dword[result],eax
   
   mov eax, dword[x_h1]
   add dword[result],eax
   
   mov eax, dword[x_h2]
   add dword[result],eax
    
   inc dword[counter]
   sub ecx, 1
   mov dword[ecx_counter], ecx
   
   
   
    push dword[result]
    push answer
    call printf
    add esp, 8
    
    
    mov ebx,  dword[counter]
   
    cmp dword [esi+(ebx*4)], 0x80000000 ; check if the current element is the terminating value 
    je loop_end
    push comma
    call printf
    add esp, 4
    jmp loop_start 
 

loop_end:

    Push Restart
    call printf
    add esp, 4


    push strvar
    push scan2
    call scanf
    add esp, 8

   
  


    cmp byte [strvar], 'Y'
     je starthere
        

    cmp byte [strvar], 'y'
    je starthere
    

 
    
    
   
    
    ;write your code here
    xor eax, eax
    ret