.data
	hello: db "Hi Mom!", 10
	helloLen: equ $-hello ; length

.text 
	global _start ;entry point for linker

	_start: 
		mov rax,1
		mov rdi,1		;stdout
		mov rsi,hello
		mov rdx,helloLen
		syscall

		; end program
		mov rax,60
		mov rdi,0
		syscall
