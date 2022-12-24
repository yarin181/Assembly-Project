.data

.section	.rodata			#read only data section
scan_intger:  .string "%d"
scan_string:	.string	"%s"

.text

.globl	run_main
	.type	run_main, @function
run_main:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer

    leaq    -256(%rsp),%rsp     #allocate 256 bytes on the stack for p1.
    movq    $0,%rax
    movq    $scan_intger,%rdi   #put scan templet as the first first argument.
    leaq    (%rsp),%rsi         #put the adress for the intger as the 2 argumnt.
    call    scanf               #read the first pstring length.
    movq    $0,%rax
    movq    $scan_string,%rdi   #put scan templet as the first first argument.
    leaq    1(%rsp),%rsi        #put the adress for the string as the 2 argumnt.
    call    scanf               #read the first pstring string.

    leaq    -256(%rsp),%rsp     #allocate 256 bytes on the stack for p2.
    movq    $0,%rax
    movq    $scan_intger,%rdi   #put scan templet as the first first argument.
    leaq    (%rsp),%rsi         #put the adress for the intger as the 2 argumnt.
    call    scanf               #read the first pstring length.
    movq    $0,%rax
    movq    $scan_string,%rdi   #put scan templet as the first first argument.
    leaq    1(%rsp),%rsi        #put the adress for the string as the 2 argumnt.
    call    scanf               #read the first pstring string.

    leaq    -16(%rsp),%rsp      #allocate 16 bytes on the stack
    movq    $0,%rax
    movq    $scan_intger,%rdi   #put scan templet as the first first argument.
    leaq    (%rsp),%rsi         #put the adress for the intger as the 2 argumnt.
    call    scanf
    movzbq  (%rsp),%rdi         #put the scaned value as the first argument in run_func function.
    leaq    16(%rsp),%rsp       #deallocate bytes.

    leaq    256(%rsp),%rsi      #put p1 as the first argument.
    leaq    (%rsp),%rdx         #put p2 as the first argument.

    call run_func

	movq	$0, %rax    #return value is zero.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret
