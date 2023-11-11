.include "macro.asm"

.eqv 	SIZE 100
.data
str: 	.space SIZE
copy: 	.space SIZE
test1: 	.asciz ""
test2: 	.asciz "Hello World!" 
test3: 	.asciz "Hello \0 World!"
n: 	.asciz "\n"
.text 
main: 
	# Запишем адреса начала зарешервированной памяти для строк
	la 	a0, str
	la	a1, copy 
	
	# Чтение строки с консоли 
	li	a7, 8
	ecall
	
	jal 	CopyStr
	
	jal 	Output
	
	# Tests
	#_________________________
	# test1
	la 	a0, test1
	li 	a7, 4
	ecall
	
	# Макрос копирования
	StrCpy a0 a1
	
	jal 	Output
	
	# test2
	la 	a0, test2
	li 	a7, 4
	ecall
	
	# Макрос копирования
	StrCpy a0 a1
	
	jal 	Output
	
	# test2
	la 	a0, test3
	li 	a7, 4
	ecall
	
	# Макрос копирования
	StrCpy a0 a1
	
	jal 	Output
	#_________________________
	
	# Конец программы
	li 	a7, 10
	ecall
	
CopyStr: 
	la 	t0, str
	la	t1, copy
	loop: 
	lb	t3, (t0)
	sb	t3, (t1)
	beqz	t3, fin
	addi	t0, t0, 1
	addi 	t1, t1, 1
	b loop
	fin:
	ret

Output: 
	la 	a0, n
	li	a7, 4
	ecall
	
	# Вывод скопированной строки для проверки
	la 	a0, copy
	li 	a7, 4
	ecall 
	
	la 	a0, n
	li	a7, 4
	ecall
	ret