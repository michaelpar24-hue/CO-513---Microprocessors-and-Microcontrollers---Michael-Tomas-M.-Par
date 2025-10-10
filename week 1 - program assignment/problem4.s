.global _start
_start:
        MOV     R0, #11				        

        
        AND     R2, R0, #0x0F    	
        LSL     R2, R2, #4			       

        
        AND     R3, R0, #0xF0    	
        LSR     R3, R3, #4       	

       
        ORR     R1, R2, R3       	

end:    B       end              
