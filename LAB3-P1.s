# Registros fijos:
    #   x10 = a            (a0)
    #   x11 = b            (a1)
    #   x12 = resultado    (a2)
    #   x13 = j            (a3)

.text
.globl  main

main:                     
    li x10, 10     # Asignan inmediatos a cada registro 
    li x11, 3
    li x12, 0

    li t0, 0       # i = 0
    li t1, 8       # cargar imm 8 en registro temporal para comparar despuess

loop_for:
    bge t0, t1, end_for    # if i >= 8 -> sale del for
    add x12, x12, x10      # resultado += a
    sub x12, x12, x11      # resultado -= b

    andi t2, x12, 3        # resultado & 3  → (t1 == 0) ⇒ múltiplo de 4
    bnez t2, else_1
    slli x12, x12, 1       # resultado *=2
    j increment            # salta a incremetar i++

else_1:
    addi x12, x12, -1      # resultado -=1

increment:
    addi t0, t0, 1
    j loop_for

end_for:
    li x13, 0              # int j = 0
    li t3, 10              # cargar imm 10 en registro temporal para comparar despues

loop_while:
    bge x13, t3, end_while   # j < 10, si es mayor o igual, manda al final del ciclo
    addi x12, x12, -3        # resultado -= (a/b) --> 10/3 = 3

    li t4, 6
    rem t5, x12, t4           # t5= resultado % 6
    beq t5, x0, if_2         # si se cumple resultado & 6 == 0, hace lo necesario

    andi t5, x12, 1          # t5=resultado % 2
    bnez t5, else_if
    add x12, x12, x11         # resultado +=b
    j after_if

if_2:
    addi x12, x12, 6
    j after_if

else_if:
    neg x12, x12              # resultado * = -1

after_if:
    addi x13, x13, 1          # j++
    j loop_while

end_while:
    blt x12, x0, is_negative
    srai x12, x12, 1
    j done

is_negative:
    neg x12, x12 # resultado = -resultado

done:
    li a7, 1        # syscall: print_int
    mv a0, x12      # imprimir resultado
    ecall

    li a7, 11       # syscall: print_char
    li a0, 10       # salto de línea
    ecall

    li a7, 10       # syscall: exit
    ecall



