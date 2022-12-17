.data

.section	.rodata			#read only data section
invalid_option:    .string "invalid option!\n"
opt_31_string:     .string "first pstring length: %d, second pstring length: %d\n"
.jump_table:
    .quad .opt_31
    .quad .opt_32_33
    .quad .opt_32_33
    .quad .invalid_option
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
	push    %r8

    ##opt in rdi , p1 in rsi , p2 in rdx
    #leaq -31(%rdi),%rsi
    movq   %rdi,%r8   #storing the foption in r8 register.
    cmpq   $31,%r8
    jb     .invalid_option
    cmpq   $37,%r8
    ja     .invalid_option

    movq    $0,%r10
    leaq   -31(%r8),%r10
    jmp    .jump_table(,%r10,8)

.opt_31:
    movq
    call pstlen
    jmp .End
.opt_32_33:
    movq $32,%rax
    jmp .End
.opt_35:
    movq $34,%rax
    jmp .End
.opt_36:
    movq $36,%rax
    jmp .End
.opt_37:
    movq $37,%rax
    jmp .End
.invalid_option:
    movq $invalid_option,%rdi
    movq  $0,%rax
    call  printf
.End:
    popq    %r8
	movq	$0, %rax      	#return value is zero.
	movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).