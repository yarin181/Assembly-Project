	.data

	.section	.rodata			#read only data section
invalid: .string "invalid input!\n"
.text

.globl	pstrlen
	.type	pstrlen, @function	# the label "main" representing the beginning of a function
pstrlen:
    movq %rsp, %rbp #for correct debugging	# the main function:
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp	#create the new frame pointer
    pushq	%rbx		#saving a callee save register.


    movq    $0,%rax
    movq   (%rdi),%r10
    movb    %r10b,%al

	movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).

.global replaceChar
    .type	replaceChar, @function
replaceChar:
    movq %rsp, %rbp #for correct debugging	# the main function:
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp	#create the new frame pointer

    movq    $0,%r8
    movb  (%rdi),%r8b   #storing the string length in r8 register.
.Loop_start:
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
    ret			#return to caller function (OS).

.global pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
        movq %rsp, %rbp #for correct debugging	# the main function:
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
        #input validation
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
        movq $invalid,%rdi
        movq  $0,%rax
        call  printf
        movq  $0,%rax
        jmp   .End_func
.End_loop:
        movq    %rdi,%rax   #store the return value in rax.
.End_func:
        movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
        popq	%rbp		#restore old frame pointer (the caller function frame)
        ret			#return to caller function (OS).


.global swapCase
    .type	swapCase, @function
swapCase:
         movq %rsp, %rbp #for correct debugging	# the main function:
         pushq	%rbp		#save the old frame pointer
         movq	%rsp, %rbp	#create the new frame pointer

         #p in rdi
     movq    $0,%r8
     movb  (%rdi),%r8b   #storing the string length in r8 register.
     inc    %r8         #now r8 is at the index of the null char.
     movq    $1,%r9      #intiate a varibale to the first char (rdi+1)

.loop:
     inc    %r9
     cmp    %r9,%r8
     je     .End_s
     cmp    $65,(%rdi,%r9)
     jl     .loop
     cmp    $90,(%rdi,%r9)
     jle    .U2L



.U2L:
    #convert


.End_s:
     movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
     popq	%rbp		#restore old frame pointer (the caller function frame)
     ret			#return to caller function (OS).




