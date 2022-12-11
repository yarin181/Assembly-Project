	.data

	.section	.rodata			#read only data section

	########
.text	#the beginnig of the code

.globl	run_func	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function
pstrlen:
    movq %rsp, %rbp #for correct debugging	# the main function:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer

    movq    $0,%rax
    movb   (%rdil),%al

	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).