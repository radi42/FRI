	.file	"ripv2-recv.c"
	.section	.rodata
.LC0:
	.string	"224.0.0.9"
	.align 8
.LC1:
	.string	"Error: %s is not a valid IPv4 address.\n\n"
.LC2:
	.string	"veth1"
.LC3:
	.string	"socket"
.LC4:
	.string	"bind"
.LC5:
	.string	"setsockopt"
.LC6:
	.string	"malloc"
.LC7:
	.string	"recvfrom"
	.align 8
.LC8:
	.string	"Corrupted (truncated) RIP message from %s\n"
	.align 8
.LC9:
	.string	"Corrupted RIP message with incomplete header from %s\n"
	.align 8
.LC10:
	.string	"Unknown RIP message type %hhu from %s\n"
	.align 8
.LC11:
	.string	"Unknown RIP message version %hhu from %s\n"
.LC12:
	.string	"RIP message from %s:\n"
	.align 8
.LC13:
	.string	"\t%s/%s, metric=%u, nh=%s, tag=%hu\n"
.LC14:
	.string	"\tUnknown address family %hu\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$168, %rsp
	.cfi_offset 3, -24
	leaq	-96(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	call	inet_aton
	testl	%eax, %eax
	jne	.L2
	movq	stderr(%rip), %rax
	movl	$.LC0, %edx
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L2:
	movl	$0, -92(%rbp)
	movl	$.LC2, %edi
	call	if_nametoindex
	movl	%eax, -88(%rbp)
	movl	$0, %edx
	movl	$2, %esi
	movl	$2, %edi
	call	socket
	movl	%eax, -36(%rbp)
	cmpl	$-1, -36(%rbp)
	jne	.L3
	movl	$.LC3, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L3:
	movw	$2, -80(%rbp)
	movl	$520, %edi
	call	htons
	movw	%ax, -78(%rbp)
	movl	$0, -76(%rbp)
	leaq	-80(%rbp), %rcx
	movl	-36(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind
	cmpl	$-1, %eax
	jne	.L4
	movl	$.LC4, %edi
	call	perror
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L4:
	leaq	-96(%rbp), %rdx
	movl	-36(%rbp), %eax
	movl	$12, %r8d
	movq	%rdx, %rcx
	movl	$35, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	setsockopt
	cmpl	$-1, %eax
	jne	.L5
	movl	$.LC5, %edi
	call	perror
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L5:
	movl	$1472, %edi
	call	malloc
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.L6
	movl	$.LC6, %edi
	call	perror
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L6:
	movq	$0, -32(%rbp)
	movq	-48(%rbp), %rax
	movl	$1472, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	movl	$16, -116(%rbp)
	leaq	-116(%rbp), %rcx
	leaq	-112(%rbp), %rdx
	movq	-48(%rbp), %rsi
	movl	-36(%rbp), %eax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$1472, %edx
	movl	%eax, %edi
	call	recvfrom
	movq	%rax, -56(%rbp)
	cmpq	$-1, -56(%rbp)
	jne	.L7
	movl	$.LC7, %edi
	call	perror
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L7:
	movq	-56(%rbp), %rax
	leaq	-4(%rax), %rcx
	movabsq	$-3689348814741910323, %rdx
	movq	%rcx, %rax
	mulq	%rdx
	shrq	$4, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	subq	%rax, %rcx
	movq	%rcx, %rdx
	testq	%rdx, %rdx
	je	.L8
	movl	-108(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rsi
	movl	$.LC8, %edi
	movl	$0, %eax
	call	printf
	jmp	.L17
.L8:
	movq	-56(%rbp), %rax
	cmpq	$3, %rax
	ja	.L10
	movl	-108(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rsi
	movl	$.LC9, %edi
	movl	$0, %eax
	call	printf
	jmp	.L17
.L10:
	movq	-48(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$2, %al
	je	.L11
	movl	-108(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rdx
	movq	-48(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC10, %edi
	movl	$0, %eax
	call	printf
	jmp	.L17
.L11:
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	cmpb	$2, %al
	je	.L12
	movl	-108(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rdx
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC11, %edi
	movl	$0, %eax
	call	printf
	jmp	.L17
.L12:
	movq	-32(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -32(%rbp)
	movq	-48(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -24(%rbp)
	movl	-108(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rsi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	jmp	.L13
.L16:
	movq	-24(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs
	cmpw	$2, %ax
	jne	.L14
	leaq	-144(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	leaq	-160(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	leaq	-176(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rcx
	leaq	-144(%rbp), %rax
	movl	$15, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncpy
	movq	-24(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rcx
	leaq	-160(%rbp), %rax
	movl	$15, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncpy
	movq	-24(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rcx
	leaq	-176(%rbp), %rax
	movl	$15, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncpy
	movq	-24(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs
	movzwl	%ax, %ebx
	movq	-24(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %edi
	call	ntohl
	movl	%eax, %esi
	leaq	-176(%rbp), %rcx
	leaq	-160(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movl	%ebx, %r9d
	movq	%rcx, %r8
	movl	%esi, %ecx
	movq	%rax, %rsi
	movl	$.LC13, %edi
	movl	$0, %eax
	call	printf
	jmp	.L15
.L14:
	movq	-24(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs
	movzwl	%ax, %eax
	movl	%eax, %esi
	movl	$.LC14, %edi
	movl	$0, %eax
	call	printf
.L15:
	movq	-32(%rbp), %rax
	addq	$20, %rax
	movq	%rax, -32(%rbp)
	addq	$20, -24(%rbp)
.L13:
	movq	-32(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jl	.L16
.L17:
	jmp	.L6
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Debian 5.3.1-11) 5.3.1 20160307"
	.section	.note.GNU-stack,"",@progbits
