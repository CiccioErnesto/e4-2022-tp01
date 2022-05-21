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
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun minusculaEnLugar
