/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    cbz R2, 0f
    movs R12,#0
1:
    ldrb R3,[R0],#1 //Carga el valor de 8 bits de R0 en R3 y el resto lo rellena con 0
    strb R3,[R1],#1 //Guarda el valor de 8 bits de R3 en R1 y el resto lo rellena con 0
    adds R12,#1
    cmp  R12,R2
    b 1b
0:
    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
    cbz R2, 0f
    movs R12,#0
1:
    ldrb R3,[R0],#1 
    strb R3,[R1],#1 
    cmp R3,#0
    beq 0f
    adds R12,#1
    cmp  R12,R2
    b 1b
    movs R3,#0
    strb R3,[R1,#(-1)]
0:
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cbz R1, 0f //Cadena Nula
   
    //Utilizo los numeros 97 y 122 ya que entre esos valores en codigo ascii estan comprendidas las minusculas
1:

    ldrb R3,[R0],#1
    cmp R3,#97 
    bmi 2f
    cmp R3,#122
    bpl 2f
    subs R3,#32 //resto 32
    strb R3,[R0,#(-1)]

2: // si no es letra analizo el siguiente byte

    subs R1,#1
    bne 1b

0:  

    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima

    cbz R1, 0f //Cadena Nula
    
    //Utilizo los numeros 65 y 90 ya que entre esos valores en codigo ascii estan comprendidas las mayusculas
1:

    ldrb R3,[R0],#1
    cmp R3,#65 
    bmi 2f
    cmp R3,#90
    bpl 2f
    add R3,#32 //Sumo 32
    strb R3,[R0,#(-1)]

2: // si no es letra analizo el siguiente byte

    subs R1,#1
    bne 1b

0:  

    bx lr
endfun minusculaEnLugar
