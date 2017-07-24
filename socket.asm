global _start

_start:
	push rbp 							;prologue
	mov rbp, rsp
	sub rsp, 0xb0
	
	mov rax, 41							;systemcall socket
	mov rdi, 0x2						
	mov rdx, 0x0
	mov rsi, 0x1

	syscall	

	mov DWORD[rbp-0x10], eax				; fd  	: sokcet 	
	mov DWORD[rbp-0x20], 0x39050002
	mov DWORD[rbp-0x1c], 0x144b7c0d 	; addr: 0xd7cdb14 port 	: 1337
	mov DWORD[rbp-0x18], 0x555547c0
	mov DWORD[rbp-0x14], 0x00005555	
	lea rcx, [rbp-0x20]

	mov rax, 42							; systemcall connect
	mov edi, DWORD[rbp-0x10]				; socket
	mov rsi, rcx					; 
	mov rdx, 0x10  						; size
	
	syscall				

	mov rax, 0						; recv system call
	mov edi, DWORD[rbp-0x10]
	lea rsi, [rbp-0xa0]			
	mov rdx, 0x32
	
	syscall 						

	mov rax, 1							; write system call
	mov rdi, 1
	lea rsi, [rbp-0xa0]
	mov rdx, 0x32

	syscall 							; rev print

	mov DWORD[rbp-0x4],0x0 				; strlen, strrev impletation
	jmp .L1
	.L2:
	add DWORD[rbp-0x4], 0x1
	.L1:	
	mov eax, DWORD[rbp-0x4]
	cdqe
	movzx eax, BYTE[rbp+rax*1-0xa0]
	test al,al
	jne .L2
	mov eax, DWORD[rbp-0x4]
	sub eax, 0x1
	mov DWORD[rbp-0x8],eax
	mov DWORD[rbp-0xc],0x0
	jmp .L3
	.L5:
	mov eax, DWORD[rbp-0x8]
	cdqe
	movzx edx, Byte [rbp+rax*1-0xa0]
	mov eax, DWORD[rbp-0xc]
	cdqe
	mov byte[rbp+rax*1-0x60],dl
	sub DWORD[rbp-0x8],0x1
	add DWORD[rbp-0xc],0x1
	.L3:
	cmp DWORD[rbp-0x8],0x0
	js	.L4
	mov eax, DWORD[rbp-0x4]
	sub eax, 0x1
	cmp eax, DWORD[rbp-0xc]
	jge .L5
	.L4:
	mov eax, DWORD[rbp-0xc]
	cdqe
	mov Byte[rbp+rax*1-0x60], 0x00

	mov rax, 1						; reverse message print
	mov rdi, 1
	lea rsi, [rbp-0x60]	
	mov rdx, [rbp-0x4]

	syscall
		
	mov rax, 1						; send sysem call
	mov edi, DWORD[rbp-0x10]
	lea rsi, [rbp-0x60]
	mov rdx, [rbp-0x4]	

	syscall

	mov rax, 0						; receve system call
	mov edi, DWORD[rbp-0x10]
	lea rsi, [rbp-0xa0]
	mov edx, 0x32		
	
	syscall

	mov rax, 1						; recve message print
	mov rdi, 1
	lea rsi, [rbp-0xa0]	
	mov rdx, 0x3

	syscall

	mov rax, 3						; socket close system call
	mov edi, DWORD[rbp-0x10]	

	syscall

	mov eax,0x0 					; epilogue
	mov rsp, rbp
	pop rbp
	
	mov rax,60
	syscall
