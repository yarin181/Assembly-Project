.data

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

    leaq    -16(%rsp),%rsp
    movq    $0,%rax
    movq    $scan_intger,%rdi
    leaq    (%rsp),%rsi
    call    scanf
    movsbq  (%rsp),%rdi
    leaq    16(%rsp),%rsp

    leaq    256(%rsp),%rsi
    leaq    (%rsp),%rdx

    call run_func

	movq	$0, %rax    #return value is zero.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret
