	.data

	.section	.rodata			#read only data section
invalid: .string "invalid input!\n"

.text

.globl	pstrlen
	.type	pstrlen, @function	# the label "main" representing the beginning of a function
pstrlen:
   // movq    %rsp, %rbp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp	#create the new frame pointer
    //pushq	%rbx		#saving a callee save register.


    movq   (%rdi),%r10
    movq    $0,%rax
    movb    %r10b,%al

	//movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).

.global replaceChar
    .type	replaceChar, @function
replaceChar:
    //movq    %rsp, %rbp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp	#create the new frame pointer

    movq    $0,%r8
    movb  (%rdi),%r8b   #storing the string length in r8 register.
.Loop_start:
    cmp $0,%r8
    jz  .End            #continue if the value of r8 is zero and were iterate all over the string.
    cmp    (%rdi,%r8),%sil  #compare the value of sil(the old char) to the current char.
    jne     .not_equal
    movb    %dl,(%rdi,%r8)  #if both char are equale than replace with the new char (on %dl)
.not_equal:
    dec    %r8              #decrement the value of %r8 to get the next char.
    jmp    .Loop_start
.End:

    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret

.global pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
    //movq    %rsp, %rbp #for correct debugging	# the main function:
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp	#create the new frame pointer


    #p1 in rdi,p2 in rsi, i in rdx ,j in rcx
    movq    $0,%r8
    movb  (%rdi),%r8b   #storing the first string length in r8 register.
    movq    $0,%r9
    movb  (%rsi),%r9b   #storing the secound string length in r9 register.
    movq    $0,%r10       #init the r10 for future use.

   #input validation
    cmp     %rdx,%rcx   #comare between j and i  should be i<=j
    js      .Error
    cmp     $0,%rcx     # sould be 0<=i
    js      .Error
    cmp     %r8,%rcx    #length of the first and the scound string sould be smaller than j.
    jge     .Error
    cmp     %r9,%rcx
    jge     .Error


    inc     %rdx        #because in the first byte theres the string length i'm
    inc     %rcx        #will add one to the i and j to mach the actual indexes.
.loop_start:
    cmp %rcx,%rdx
    jg      .End_loop
    movb    (%rsi,%rdx),%r10b
    movb    %r10b,(%rdi,%rdx)
    inc     %rdx
    jmp     .loop_start
.Error:
    movq    $invalid,%rdi
    movq    $0,%rax
    call    printf
    movq    $0,%rax
    jmp     .End_func
.End_loop:
    movq    %rdi,%rax   #store the return value in rax.
.End_func:
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret			#return to caller function (OS).




.global swapCase
    .type	swapCase, @function
swapCase:
     //movq %rsp, %rbp #for correct debugging	# the main function:
     pushq	%rbp		#save the old frame pointer
     movq	%rsp, %rbp	#create the new frame pointer

         #p in rdi
     movq    $0,%r8
     movb  (%rdi),%r8b   #storing the string length in r8 register.
     inc    %r8         #now r8 is at the index of the null char.
     movq    $0,%r9      #intiate a varibale to the first char .

.loop:
     inc    %r9
     cmp    %r9,%r8
     je     .End_s

     movq   $0,%r11
     movb   (%rdi,%r9),%r11b
     cmp    $0x41,%r11b
     jl     .loop           #if the char is less than 65 than in is not a letter
     cmp    $0x5A,%r11b
     jle    .U2L            #if the char is higer than 65 and less than or equal to 90 than it is a upper case.
     cmp    $0x61,%r11b
     jl     .loop           #if the char is higer than 90 and less than 97 than it is not a letter.
     cmp    $0x7A,%r11b
     jle    .L2U            #if the char is higer than 97 and less than or equal to 122 than it is a lower case.
     jmp    .loop           #if all the above not true than the char is higer than 122 so it is not a letter.
.U2L:
    add     $0x20,(%rdi,%r9)  #20 is the gap in hexadecimal between upper and lower case letter.
    jmp     .loop
.L2U:
    sub     $0x20,(%rdi,%r9)    #20 is the gap in hexadecimal between upper and lower case letter.
    jmp     .loop

.End_s:
     movq %rdi,%rax

     movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
     popq	%rbp		#restore old frame pointer (the caller function frame)
     ret			#return to caller function (OS).


.global pstrijcmp
    .type	pstrijcmp, @function
pstrijcmp:
     //movq %rsp, %rbp #for correct debugging	# the main function:
     pushq	%rbp		#save the old frame pointer
     movq	%rsp, %rbp	#create the new frame pointer
     pushq  %r12        #save calee save register
     pushq  $0x43

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
    cmp     %r9,%rcx
    jge     .Error_c
    inc     %rcx
.loop_c:
    inc     %rdx
    cmp     %rdx,%rcx
    jb      .equals         #if i =j+1 its mean than were iterate over both strings and they were equal.
    movq    $0,%r11
    movq    $0,%r12
    movb   (%rdi,%rdx),%r11b
    movb   (%rsi,%rdx),%r12b

    cmp    %r11,%r12
    jb     .p1_big
    jg     .p2_big
    jmp    .loop_c

.p1_big:
    movq    $1,%rax
    jmp     .End_c
.p2_big:
    movq    $-1,%rax
    jmp     .End_c
.equals:
    movq    $0,%rax
    jmp     .End_c
.Error_c:
    movq $invalid,%rdi
    movq  $0,%rax
    call  printf
    movq    $-2,%rax
.End_c:
     pop    %r11
     pop    %r12        #restore the value of r12
     movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
     popq	%rbp		#restore old frame pointer (the caller function frame)
     ret			#return to caller function (OS).


