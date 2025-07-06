# Registros fijos:
    #   x10 = a            (a0)
    #   x11 = b            (a1)
    #   x12 = resultado    (a2)
    #   x13 = j            (a3)

.text
.globl  main

main:              # Inicio de main  
    li x10, 10     # carga inmediato 10 en x10 (a = 10) 
    li x11, 3      # carga inmediato 3 en x11 (b = 3)
    li x12, 0      # inicializa resultado = 0

    li t0, 0       # inicializa i = 0
    li t1, 8       # cargar imm 8 en registro temporal para comparar después

loop_for:                  # incio del bucle for
    bge t0, t1, end_for    # si i >= 8 salta a end_for
    add x12, x12, x10      # resultado += a
    sub x12, x12, x11      # resultado -= b

    andi t2, x12, 3        # t2 = resultado & 3 (¿múltiplo de 4?)
    bnez t2, else_1        # si t2 ≠ 0 salta a else_1
    slli x12, x12, 1       # resultado *=2
    j increment            # salta a incremetar i

else_1:                    # ruta else del múltiplo de 4
    addi x12, x12, -1      # resultado -=1

increment:                 # etiqueta para i++
    addi t0, t0, 1         # i += 1
    j loop_for             # vuelve al inicio del for

end_for:                   # fin del bucle for
    li x13, 0              # inicializa j = 0
    li t3, 10              # cargar imm 10 en registro temporal t3 para comparar despues

loop_while:                  # inicio del bucle while
    bge x13, t3, end_while   # si j >= 10 salta a end_while
    addi x12, x12, -3        # resultado -= (a/b) --> 10/3 = 3

    li t4, 6                 # carga inmediato 6 en t4 para módulo
    rem t5, x12, t4          # t5= resultado % 6
    beq t5, x0, if_2         # si t5 == 0 salta a if_2

    andi t5, x12, 1          # t5=resultado % 2
    bnez t5, else_if         # si t5 ≠ 0 salta a else_if
    add x12, x12, x11        # resultado +=b
    j after_if               # salta a after_if

if_2:                        # ruta cuando múltiplo de 6
    addi x12, x12, 6         # resultado += 6
    j after_if               # salta a after_if

else_if:                     # ruta else de paridad
    neg x12, x12             # resultado = -resultado
 
after_if:                    # etiqueta after_if
    addi x13, x13, 1         # j+=1
    j loop_while             # vuelve al inicio del while

end_while:                            # fin del bucle while
    blt x12, x0, is_negative          # si resultado < 0 salta a is_negative
    srai x12, x12, 1                  # resultado >>= 1 (aritmético)
    j done                            # salta a terminar

is_negative:                                      # etiqueta is_negative
    neg x12, x12 # resultado = -resultado         # resultado = -resultado

done:               # final de la función
    li a7, 1        # syscall: imprimir entero         
    mv a0, x12      # pepara resultado en a0
    ecall           #llamada al sistema

    li a7, 11       # syscall: imprimir carácter
    li a0, 10       # salto de línea (solo por temas de orden visual al momento de ejecutar)
    ecall           #llamada al sistema

    li a7, 10       # syscall: exit
    ecall           # llamada al sistema para terminar



