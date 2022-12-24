.data

.section	.rodata			#read only data section
invalid_option:    .string "invalid option!\n"
opt_31_string:     .string "first pstring length: %d, second pstring length: %d\n"
opt_32_33_string:  .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
char_scan:         .string " %c"
decimal_scan:      .string "%d"
length_string:     .string "length: %d, string: %s\n"
opt_37_string:     .string "compare result: %d\n"

.jump_table:
    .quad .opt_31
    .quad .opt_32_33
    .quad .opt_32_33
    .quad .invalid_option
    .quad .opt_35
    .quad .opt_36
    .quad .opt_37
	########
.text

.globl	run_func
    .type	run_func, @function
run_func:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer
	pushq	%rbx		#saving a callee save registers.
	push    %r12
	push    %r13
    push    %r14

    ##opt in rdi , p1 in rsi , p2 in rdx
    #leaq -31(%rdi),%rsi
    movq    %rsi,%r12               #move p1 pointer to calee saved regiter.
    movq    %rdx,%r13               #move p2 pointer to calee saved regiter.
    movq   %rdi,%r8                 #storing the foption in r8 register.
    cmpq   $31,%r8
    jb     .invalid_option          #if the selection is below 31 than its not a valid option.
    cmpq   $37,%r8
    ja     .invalid_option          #if the opt is over 37 than it is not a valid selection.

    movq    $0,%r10
    leaq   -31(%r8),%r10            #put the numeric value of opt to be in the rnge of 0-6.
    jmp    *.jump_table(,%r10,8)    #jumping to the required location acording to the jump table.

.opt_31:
    movq    %r12,%rdi               #put p1 as the function argument.
    call    pstrlen
    movq    %rax,%rbx               #put the return value of the function in calee save register.
    movq    %r13,%rdi               #put p2 as the function argument.
    call    pstrlen
    movq    $opt_31_string,%rdi     #put the output format as the first argument.
    movq    %rbx,%rsi               #put the p1 as the 2 argument.
    movq    %rax,%rdx               #put the p2 as the 3 argument.
    movq    $0,%rax
    call    printf
    jmp     .End
.opt_32_33:
    leaq    -16(%rsp),%rsp            #allocate 16 byte on the stack.
    movq    $char_scan,%rdi         #put the char scan as the first argument.
    leaq    (%rsp),%rsi             #set a value on the stack as the 2 argument.
    movq    $0,%rax
    call    scanf
    movq    $char_scan,%rdi         #put the char scan as the first argument.
    leaq    1(%rsp),%rsi            #set a value on the stack as the 2 argument.
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%rbx             #new char in rbx (calle saved)
    movzbq  1(%rsp),%r14            #old char in r14 (calle saved)
    movq    %r12,%rdi               #put p1 as the first argument.
    movq    %rbx,%rsi               #put the old char as the 2 argument.
    movq    %r14,%rdx               #put the new char as the 3 argument.
    call    replaceChar
    movq    %r13,%rdi               #put p2 as the first argument.
    movq    %rbx,%rsi               #put the old char as the 2 argument.
    movq    %r14,%rdx               #put the new char as the 3 argument
    call    replaceChar
    movq    $opt_32_33_string,%rdi  #put the string as the 1 argument
    movq    %rbx,%rsi               #put the old char as the 2 argument.
    movq    %r14,%rdx               #put the new char as the 3 argument
    leaq    1(%r12),%rcx            #put the adreass of p1 string as the 4 argument
    leaq    1(%r13),%r8             #put the adreass of p1 string as the 5 argument
    movq    $0,%rax
    call    printf
    leaq    16(%rsp),%rsp           #dealocate 16 bytes
    jmp     .End
.opt_35:
    leaq    -16(%rsp),%rsp          #allocate 16 byte on the stack.
    movq    $0,%rax
    movq    $decimal_scan,%rdi      #put the decimal scan as the first argument.
    leaq    (%rsp),%rsi             #set a adress on the stack as the 2 argument.
    call    scanf                   #scan the first decimal
    movq    $0,%rax
    movq    $decimal_scan,%rdi      #put the decimal scan as the first argument.
    leaq    8(%rsp),%rsi
    call    scanf                   #scan the secound decimal
    movq    %r12,%rdi               #p1 as the first argument
    movq    %r13,%rsi               #p2 as the secound argument
    movzbq  (%rsp),%rdx           #put the start index as the 3 argument.
    movzbq  8(%rsp),%rcx          #put the end index as the 4 argument.
    call    pstrijcpy
    movq    $length_string,%rdi
    movzbq  (%r12),%rsi            #put the string length as the first argument.
    leaq    1(%r12),%rdx            #put the string as the secound argument.
    movq    $0,%rax
    call    printf
    movq    $length_string,%rdi
    movzbq  (%r13),%rsi             #put the string length as the first argument.
    leaq    1(%r13),%rdx            #put the string as the secound argument.
    movq    $0,%rax
    call    printf
    leaq    16(%rsp),%rsp           #dealocate 16 bytes
    jmp     .End
.opt_36:
    movq    %r12,%rdi               #put p1 as the first argument for the swap case function.
    call    swapCase
    movq    %r13,%rdi               #put p1 as the first argument for the swap case function.
    call    swapCase
    movq    $length_string,%rdi
    movzbq  (%r12),%rsi             #put the string length as the first argument.
    leaq    1(%r12),%rdx            #put the string as the secound argument.
    movq    $0,%rax
    call    printf
    movq    $length_string,%rdi
    movzbq  (%r13),%rsi             #put the string length as the first argument.
    leaq    1(%r13),%rdx            #put the string as the secound argument.
    movq    $0,%rax
    call    printf

    jmp     .End
.opt_37:
    leaq    -16(%rsp),%rsp        #allocate 16 byte on the stack.
    movq    $0,%rax
    movq    $decimal_scan,%rdi    #set the decimal scan as the 1 argument.
    leaq    (%rsp),%rsi           #set an adress on the stack for the scanning.
    call    scanf                 #scan the first decimal
    movq    $0,%rax
    movq    $decimal_scan,%rdi    #set the decimal scan as the 1 argument.
    leaq    8(%rsp),%rsi
    call    scanf                 #scan the secound decimal
    movq    %r12,%rdi             #p1 as the first argument
    movq    %r13,%rsi             #p2 as the secound argument
    movzbq  (%rsp),%rdx         #put the start index as the 3 argument.
    movzbq  8(%rsp),%rcx        #put the end index as the 4 argument.
    leaq    16(%rsp),%rsp         #dealocate 16 bytes
    call    pstrijcmp
    movq    %rax,%rsi             #set the function return value as the 2 argument.
    movq    $opt_37_string,%rdi   #set the printf first arguement to be the required format.
    movq    $0,%rax
    call    printf

    jmp     .End
.invalid_option:
    movq    $invalid_option,%rdi   #set the invaliid format as the first argument.
    movq    $0,%rax
    call    printf
.End:

    popq    %r14                #restoring the save register for the caller function.
    popq    %r13
    popq    %r12
	movq	-8(%rbp), %rbx
	movq	$0, %rax      	   #return value is zero.
	movq	%rbp, %rsp	       #restore the old stack pointer - release all used memory.
	popq	%rbp		       #restore old frame pointer (the caller function frame)
	ret
