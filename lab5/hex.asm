PUBLIC UHex
EXTRN x:word

CSEG SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG
		
UHex PROC NEAR
    mov ax, x ; перемещяю введенное число в регистр ах       
    xor cx, cx ;обнуляю сх
    mov bx, 16 ; основание сс в которую я перевожу
metka_2:
    xor dx,dx
    div bx
; Делю число на основание сс. В остатке получается последняя цифра. Сохраняю её в стек
    push dx
    inc cx

; А с частным повторяю то же самое, отделяя от него очередную цифру справа, пока не останется ноль
    
    test ax, ax; поднимается флаг zf = 0. проверяется  равен ли нулю
    jnz metka_2

    mov ah, 02h ; вывод.
metka_3:
    pop dx
; Извлекаю очередную цифру, переводя её в символ и деляю вывод.
   cmp dl, 9; смотрю если больше 9, то надо написать буквы
   jbe metka_4
   add dl, 7; между цифрами и буквами в таблице 7 символов которые надо пропустить
metka_4:
    add dl, '0'
    int 21h
; Повторю столько раз, сколько цифр насчитал.
    loop metka_3
    ret
UHex	ENDP
		
		
CSEG	ENDS
END