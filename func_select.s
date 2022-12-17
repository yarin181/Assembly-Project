	.data


	.section	.rodata			#read only data section
    .jump_table:
        .quad .opt_31
        .quad .opt_32_33
        .quad .opt_35
        .quad .opt_36
        .quad .opt_37
	########
.text	#the beginnig of the code

.globl	run_func	#the label "main" is used to state the initial point of this program
	//.type	main, @function	# the label "main" representing the beginning of a function
run_func:
    movq %rsp, %rbp #for correct debugging	# the main function:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer
	pushq	%rbx		#saving a callee save register.

    ##opt in rdi , p1 in rsi , p2 in rdx
    #leaq -31(%rdi),%rsi
     cmpq   $34,%rdi
     je .Error
     cmpq   $32,%rdi
     je .32_33
     cmpq   $33,%rdi
     je .32_33
     cmp    $31,%rdi
     je .31
     jb .Error
     cmp    $38,%rdi
     jae    .Error
    jmp .continue
    .32_33:
        movq $34,%rdi
        jmp .continue
    .31:
        movq $33,%rdi
    .continue:
        leaq   -33(%rdi),%rsi
        jmp    .jump_table(,%rsi,8)

    .opt_31:
        movq $31,%rax
        jmp .End
    .opt_32_33:
        #33_32
        movq $32,%rax
        jmp .End
    .opt_35:
        movq $34,%rax
        jmp .End
    .opt_36:
        movq $36,%rax
        jmp .End
    .opt_37:
        #37
        movq $37,%rax
        jmp .End
    .Error:
        movq $38,%rax

        #print invalid number.
.End:


	movq	$0, %rax      	#return value is zero.
	movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).