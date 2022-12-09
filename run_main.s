	.data
a:	.quad	1000


	.section	.rodata			#read only data section
format:	.string	"%x !\n"	 
intger:  .string "%d"    
string:	.string	"%s"
	########
	.text	#the beginnig of the code

.globl	run_main	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function
run_main:
    movq %rsp, %rbp #for correct debugging	# the main function:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer
	pushq	%rbx		#saving a callee save register.
        
        
	movq	$intger,%rdi	#the string is the first paramter passed to the printf function.
	leaq    -8(%rsp),%rsp     #allocate eight byte on the stack.
    leaq    4(%rsp),%rsi      #set the nuncer of chars in rsi
    movq    $0,%rax
    call    scanf
    leaq    8(%rsp),%rsp     #free the alocaed bytes.
    movq    %rsi,%r13           #pass the value of r13 of rsi to r13 refister.
    addq    $2,%rsi
    movq    %rsi,%rax
    movq    $16,%rbx
    divq    %rbx
    incq    %rax
    imulq   $-1,%rax
    leaq    (%rsp,%rax,8),%rsp      #allocate bytes according to the word size with 8 elignment.

    movq    $string,%rdi
    leaq    1(%rsp),%rsi
    movq    $0,%rax
    call    scanf

    movb    %r13b,(%rsp)

    movq	$intger,%rdi	#the string is the first paramter passed to the printf function.
	leaq    -8(%rsp),%rsp     #allocate eight byte on the stack.
    leaq    4(%rsp),%rsi      #set the nuncer of chars in rsi
    movq    $0,%rax
    pushq   $0x33
    call    scanf
    leaq    8(%rsp),%rsp     #free the alocaed bytes.
    movq    %rsi,%r13
    addq    $2,%rsi
    movq    %rsi,%rax
    movq    $16,%rbx
    divq    %rbx
    incq    %rax
    imulq   $-1,%rax
    leaq    (%rsp,%rax,8),%rsp      #allocate bytes according to the word size with 8 elignment.

    movq    $string,%rdi
    leaq    1(%rsp),%rsi
    movq    $0,%rax
    call    scanf

    movb    %r13b,(%rsp)
                                        
	movq	$0, %rax      	#return value is zero.
	movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).

