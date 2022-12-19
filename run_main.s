.data
a:	.quad	1000


.section	.rodata			#read only data section
format:	.string	"%x !\n"
scan_intger:  .string "%d"
scan_string:	.string	"%s"

.text

.globl	run_main
	.type	main, @function
run_main:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer

    leaq    -256(%rsp),%rsp     #allocate 256 bytes on the stack for p1.
    movq    $0,%rax
    movq    $scan_intger,%rdi
    leaq    (%rsp),%rsi
    call    scanf              #read the first pstring length.
    movq    $0,%rax
    movq    $scan_string,%rdi
    leaq    1(%rsp),%rsi
    call    scanf              #read the first pstring string.

    leaq    -256(%rsp),%rsp     #allocate 256 bytes on the stack for p2.
    movq    $0,%rax
    movq    $scan_intger,%rdi
    leaq    (%rsp),%rsi
    call    scanf              #read the first pstring length.
    movq    $0,%rax
    movq    $scan_string,%rdi
    leaq    1(%rsp),%rsi
    call    scanf              #read the first pstring string.



    leaq    256(%rsp),%rsi
    leaq    (%rsp),%rdx


















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
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).
