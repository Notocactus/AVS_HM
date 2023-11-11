.macro StrCpy %s %c
.text
mv	t0, %s
mv 	t1, %c
# Цикл, который копирует каждый символ до символа конца строки 
loop: 
	lb	t3, (t0)
	sb	t3, (t1)
	beqz	t3, fin
	addi	t0, t0, 1
	addi 	t1, t1, 1
	b loop
fin: 
.end_macro
