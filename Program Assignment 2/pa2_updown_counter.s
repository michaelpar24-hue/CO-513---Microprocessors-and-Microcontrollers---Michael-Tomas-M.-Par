.global _start

/* ===== Base address for HEX0 ===== */

.equ HEX0_BASE, 0xFF200020
.equ HEX1_BASE, 0xFF200030
.equ KEY0_BASE, 0xFF200050
.equ SW0_BASE,	0xFF200040

_start:

start_loop:

 	LDR r1, =KEY0_BASE
	
	MOV r0, #40000
	
delay_loop_5ms:

    SUB r0, r0, #1
	CMP r0, #0
    BNE delay_loop_5ms
	
    LDR r0, [r1]          
    AND r0, r0, #1        

    CMP r0, #1
	BEQ loop
/* =====	
	LDR r1, =HEX0_BASE
	LDR r2, =HEX1_BASE 

    STR r3, [r1]
	STR r6, [r2]
					===== */
    B start_loop

back_to_zero:

	LDR r7, =SEG_PATTERNS   
    MOV r8, #0           	 
	MOV r9, #0   

	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	B loop

loop:

	LDR r7, =SEG_PATTERNS  
	
/* ===== increment or decrement ===== */

	LDR r1, =SW0_BASE
    LDR r0, [r1]          
    AND r0, r0, #1        
    CMP r0, #1
	BNE loop_dec

/* ===== code for key ===== */

	LDR r1, =KEY0_BASE
    LDR r0, [r1]          
    AND r0, r0, #1        
    CMP r0, #1
	BNE start_loop
	
/* ===== delay 1 second while counting ===== */		
	
	BL delay_1sec

/* ===== code for key1 to reset ===== */

	BL key1_reset
	
/* ===== code for hex0 general ===== */	

	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	ADD r8, r8, #1
	CMP r8, #10
	BEQ HEX1_loop
	BLT loop
	
/* ===== code for hex1 ===== */

HEX1_loop:

	BL delay_1sec
	
	MOV r8, #0
	
	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	ADD r9, r9, #1
	
	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	MOV r8, #9
	MOV r10, #10
	MOV r11, r9
	MUL r11, r11, r10
	SUB r8, r8, #2
	ADD r11, r11, r8
	MOV r12, #59

	CMP r11, r12 
	BGT back_to_zero
	B outer_loop
	
/* ===== additonal loop para sa pag back to zero after reaching no. 9 ===== */

outer_loop:

	MOV r8, #1 	

	B loop
	
/* ===== delay section ===== */

delay_1sec:

	LDR r12, =10000000
	

delay_main_loop:

	SUBS r12, r12, #2
	BNE delay_main_loop	
	BX lr
	
/* ===== code for key1 to reset ===== */

key1_reset:

	LDR r0, =KEY0_BASE
	
	MOV r1, #40000
	
delay_loop_5ms_key1:

    SUB r1, r1, #1
	CMP r1, #0
    BNE delay_loop_5ms_key1
	
	LDR r1, [r0]
	
    AND r2, r1, #0x02     
    CMP r2, #0   
	
	BEQ back_to_zero
	BX lr

key1_reset_dec:

	LDR r0, =KEY0_BASE 
	
	MOV r1, #40000
	
delay_loop_5ms_dec:

    SUB r1, r1, #1
	CMP r1, #0
    BNE delay_loop_5ms_dec
	
	LDR r1, [r0]
    AND r2, r1, #0x02     
    CMP r2, #0   
	
	BEQ back_to_zero_dec
	BX lr

/* ===== decrement ===== */

loop_dec:


/* ===== increment or decrement ===== */

	LDR r1, =SW0_BASE
    LDR r0, [r1]          
    AND r0, r0, #1        
    CMP r0, #1
	BEQ loop

/* ===== code for key ===== */

	LDR r1, =KEY0_BASE
    LDR r0, [r1]          
    AND r0, r0, #1        
    CMP r0, #1
	
	BNE start_loop
	
/* ===== delay 1 second while counting ===== */		
	
	BL delay_1sec

/* ===== code for key1 to reset ===== */

	BL key1_reset_dec
	
/* ===== code for hex0 general ===== */	

	CMP r8, #0
	BLT countdown_zero

loop_dec_inner:

	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	SUB r8, r8, #1
	CMP r8, #0
	BEQ HEX1_loop_dec
	B loop_dec
	
/* ===== code for hex1 ===== */

HEX1_loop_dec:

	BL delay_1sec

	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	

	CMP r9, #0
	BEQ loop_dec

	MOV r3, #0x6F
	STR r3, [r4]
	
	SUB r9, r9, #1
	
	
	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	MOV r8, #9
	CMP r8, #9
	BEQ loop_dec_inner 
	
	CMP r9, #0 	
	BEQ if_r9_zero 
	B loop_dec
	
	
back_to_zero_dec:

	LDR r7, =SEG_PATTERNS   
    MOV r8, #0           	 
	MOV r9, #0   

	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	B loop_dec
	
if_r9_zero:

	MOV r9, #6
	B loop_dec
	
countdown_zero:

	MOV r8, #9
	MOV r9, #5
	
	LDR r4, =HEX0_BASE
	LDR r5, [r7, r9, LSL #2]
	LSL r6, r5, #8
	LDR r2, [r7, r8, LSL #2]
	
	ADD r6, r6, r2
	
	STR r6, [r4]
	
	B loop_dec_inner
	
SEG_PATTERNS:
    .word 0x3F  // 0: abcdef
    .word 0x06  // 1: bc
    .word 0x5B  // 2: abdeg
    .word 0x4F  // 3: abcdg
    .word 0x66  // 4: bcfg
    .word 0x6D  // 5: acdfg
    .word 0x7D  // 6: acdefg
    .word 0x07  // 7: abc
    .word 0x7F  // 8: abcdefg
    .word 0x6F  // 9: abcdfg


		
