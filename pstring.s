	.data

	.section	.rodata			#read only data section

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



        movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
        popq	%rbp		#restore old frame pointer (the caller function frame)
        ret			#return to caller function (OS).