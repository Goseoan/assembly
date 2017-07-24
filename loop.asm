section .data
ast:	db 0x2A
lf :	db 0x0A

section .text
global _start

_start:
	
	push rbp
	mov rbp, rsp
	sub rsp, 0x20
	mov rax, QWORD[rbp+0x18]

	movzx eax, BYTE[rax]
	movsx eax, al
	sub eax,0x30
	mov DWORD[rbp-0xc], eax
	cmp DWORD[rbp-0xc], 0x9
	jg .L1
	cmp DWORD[rbp-0xc], 0x0
	jns .L2	
.L2:
	mov DWORD[rbp-0x4], 0x1		
	jmp .L3
.L6:
	mov DWORD[rbp-0x8], 0x1	
	jmp .L4
.L5:
	mov rax, 1
	mov rdi, 1
	mov rsi, ast
	mov rdx, 1
	syscall

	add DWORD[rbp-0x8], 0x1
.L4:	
	mov eax, DWORD[rbp-0x8]
	cmp eax, DWORD[rbp-0x4]
	jle .L5		
	
	mov rax, 1
	mov rdi, 1
	mov rsi, lf
	mov rdx, 1
	syscall

	add DWORD[rbp-0x4], 0x1
.L3:
	mov eax, DWORD[rbp-0x4]
	cmp eax, DWORD[rbp-0xc]
	jle .L6
	mov eax, DWORD[rbp-0xc]
	sub eax, 0x1
	mov DWORD[rbp-0x4],eax
	jmp .L7
.L10:
	mov DWORD[rbp-0x8],0x1
	jmp .L8
.L9:
	mov rax, 1
	mov rdi, 1
	mov rsi, ast
	mov rdx, 1
	syscall

	add DWORD[rbp-0x8],0x1	
.L8:
	mov eax, DWORD[rbp-0x8]
	cmp eax, DWORD[rbp-0x4]
	jle .L9
	
	mov rax, 1
	mov rdi, 1
	mov rsi, lf
	mov rdx, 1

	syscall

	sub DWORD[rbp-0x4], 0x1
.L7:
	cmp DWORD[rbp-0x4], 0x0	
	jg .L10
	mov eax, 0x0
	jmp .L1
.L1:
	mov rsp, rbp
	pop rbp
	
	mov rax,60
	syscall
