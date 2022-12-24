.data

.section	.rodata			#read only data section
invalid: .string "invalid input!\n"

.text

.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp	#create the new frame pointer

    movq   (%rdi),%r10     #put the pstring length in r10
    movq    $0,%rax        #set the return value to be zero.
    movb    %r10b,%al      #put the numeric value for the pstring in the first byte of the return value.

	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret

.globl replaceChar
    .type	replaceChar, @function
replaceChar:
    pushq	%rbp		  #save the old frame pointer
    movq	%rsp, %rbp	  #create the new frame pointer

    movq    $0,%r8        #set the r8 refister to be zero.
    movb    (%rdi),%r8b   #storing the string length in r8 register.
.Loop_start:
    cmp     $0,%r8
    jz      .End             #continue if the value of r8 is zero and were iterate all over the string.
    cmp     (%rdi,%r8),%sil  #compare the value of sil(the old char) to the current char.
    jne     .not_equal
    movb    %dl,(%rdi,%r8)   #if both char are equale than replace with the new char (on %dl)
.not_equal:
    dec    %r8               #decrement the value of %r8 to get the next char.
    jmp    .Loop_start
.End:

    movq	%rbp, %rsp	     #restore the old stack pointer - release all used memory.
    popq	%rbp		     #restore old frame pointer (the caller function frame)
    ret

.globl pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
    pushq	%rbp		        #save the old frame pointer
    movq	%rsp, %rbp	        #create the new frame pointer
    pushq   %r12                #backup calle save register.
    pushq   %r13

    #p1 in rdi,p2 in rsi, i in rdx ,j in rcx
    movq    $0,%r8
    movb    (%rdi),%r8b         #storing the first string length in r8 register.
    movq    $0,%r9
    movb    (%rsi),%r9b         #storing the secound string length in r9 register.
    movq    $0,%r10             #init the r10 for future use.
    movq    %rdi,%r12           #put the dst in a calle saved registe.

   #input validation
    cmp     %rdx,%rcx           #comare between j and i  should be i<=j
    js      .Error
    cmp     $0,%rcx             # sould be 0<=i
    js      .Error
    cmp     %r8,%rcx            #length of the first and the scound string sould be greater than j.
    jge     .Error
    cmp     %r9,%rcx            #length of the first and the scound string sould be greater than j.
    jge     .Error


    inc     %rdx                #because in the first byte theres the string length i'm
    inc     %rcx                #will add one to the i and j to mach the actual indexes.
.loop_start:
    cmp     %rcx,%rdx            #check if we already ierate over all chars.
    jg      .End_loop            #if we i>j we finsh with the process.
    movb    (%rsi,%rdx),%r10b    #put the i char of p2 insted of the i char of p1.
    movb    %r10b,(%rdi,%rdx)
    inc     %rdx                 #i++
    jmp     .loop_start
.Error:
    movq    $invalid,%rdi       #put the invalid templet as the first argument for printf.
    movq    $0,%rax
    call    printf              #print an invalid message.
    movq    %r12,%rax
    jmp     .End_func
.End_loop:
    movq    %rdi,%rax           #store the return value in rax.
.End_func:

    popq    %r13                #restore calee save regisers.
    popq    %r12
    movq	%rbp, %rsp	        #restore the old stack pointer - release all used memory.
    popq	%rbp		        #restore old frame pointer (the caller function frame)
    ret




.globl swapCase
    .type	swapCase, @function
swapCase:
     pushq	%rbp		        #save the old frame pointer
     movq	%rsp, %rbp	        #create the new frame pointer

         #p in rdi
     movq    $0,%r8
     movb  (%rdi),%r8b          #storing the string length in r8 register.
     inc    %r8                 #now r8 is at the index of the null char.
     movq    $0,%r9             #intiate a varibale to the first char ,i=0 .

.loop:
     inc    %r9                 # i++, the first char is on the 1 index.
     cmp    %r9,%r8             # check if i is stil smaller than j.
     je     .End_s

     movq   $0,%r11
     movb   (%rdi,%r9),%r11b   #put in the r11 register the value of the current char.
     cmp    $0x41,%r11b
     jl     .loop              #if the char is less than 65 than in is not a letter
     cmp    $0x5A,%r11b
     jle    .U2L               #if the char is higer than 65 and less than or equal to 90 than it is a upper case.
     cmp    $0x61,%r11b
     jl     .loop              #if the char is higer than 90 and less than 97 than it is not a letter.
     cmp    $0x7A,%r11b
     jle    .L2U               #if the char is higer than 97 and less than or equal to 122 than it is a lower case.
     jmp    .loop              #if all the above not true than the char is higer than 122 so it is not a letter.
.U2L:
    addq     $0x20,(%rdi,%r9)   #20 is the gap in hexadecimal between upper and lower case letter.
    jmp     .loop
.L2U:
    subq     $0x20,(%rdi,%r9)   #20 is the gap in hexadecimal between upper and lower case letter.
    jmp     .loop

.End_s:
     movq   %rdi,%rax           #set the pstring adress as the return value.

     movq	%rbp, %rsp	       #restore the old stack pointer - release all used memory.
     popq	%rbp		       #restore old frame pointer (the caller function frame)
     ret


.globl pstrijcmp
    .type	pstrijcmp, @function
pstrijcmp:
     pushq	%rbp		#save the old frame pointer
     movq	%rsp, %rbp	#create the new frame pointer
     pushq  %r12        #save calee save register
     pushq  $0x43       #allign the stack.

    #p1 in rdi,p2 in rsi, i in rdx ,j in rcx
    movq    $0,%r8
    movb  (%rdi),%r8b   #storing the first string length in r8 register.
    movq    $0,%r9
    movb  (%rsi),%r9b   #storing the secound string length in r9 register.

   #input validation
    cmp     %rdx,%rcx   #comare between j and i , should be i<=j
    js      .Error_c
    cmp     $0,%rcx     # sould be 0<=i
    js      .Error_c
    cmp     %r8,%rcx    #length of the first and the scound string sould be smaller than j.
    jge     .Error_c
    cmp     %r9,%rcx    #length of the first and the scound string sould be smaller than j.
    jge     .Error_c
    inc     %rcx
.loop_c:
    inc     %rdx        #increment the index value.
    cmp     %rdx,%rcx   #comare i and j .
    jb      .equals                #if i =j+1 its mean than were iterate over both strings and they were equal.
    movq    $0,%r11
    movq    $0,%r12
    movb    (%rdi,%rdx),%r11b      #put p1 char in the i index value in r11
    movb    (%rsi,%rdx),%r12b      #put p2 char in the i index value in r12

    cmp    %r11,%r12              #comare between the two char.
    jb     .p1_big                #if p1[i] > p2[i] p1 is bigger
    jg     .p2_big                #if p1[i] < p2[i] p2 is bigger
    jmp    .loop_c

.p1_big:
    movq    $1,%rax             #the return value is 1 if p1 is bigger.
    jmp     .End_c
.p2_big:
    movq    $-1,%rax            #the return value is -1 if p2 is bigger.
    jmp     .End_c
.equals:
    movq    $0,%rax
    jmp     .End_c
.Error_c:
    movq    $invalid,%rdi          #templet for invalid as the first argument.
    movq    $0,%rax
    call    printf
    movq    $-2,%rax            # return value is -2 in invalid senerio.
.End_c:
     pop    %r11
     pop    %r12        #restore the value of r12
     movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
     popq	%rbp		#restore old frame pointer (the caller function frame)
     ret



