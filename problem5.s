.global _start
_start:
	
	LDR R0, =my_array			
	LDR R1, =array_size			
	LDR R2, [R0]				
	LDR R4, [R1]
	
loop:
	CMP R4, #0					
	BEQ done
	
	LDR R3, [R0]				
	CMP R3, R2					
	MOVGT R2, R3
	
	ADD R0, R0, #4
	SUB R4, R4, #1				
	
	B loop
done:	
	B done
	
.data
my_array: .word 4, 5, 9, 1, 0, -2, 3
array_size: .word 7