.global _start
_start:
        MOV     R0, #11  			
        MOV     R1, #0            	
        MOV     R2, #32				  

loop:
        AND     R3, R0, #1        
        ADD     R1, R1, R3        
        LSR     R0, R0, #1        
        SUBS    R2, R2, #1        
        BNE     loop        
		BEQ		output
		
output:		
        
        AND     R1, R1, #1       
                                                                
END:    B       END    
	