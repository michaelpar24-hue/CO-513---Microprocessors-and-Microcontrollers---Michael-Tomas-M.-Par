.global _start
_start:
        MOV     R0, #10          
        MOV     R1, #1          

loop:
        CMP     R0, #1          
        BLE     end_loop        
        MUL     R1, R1, R0      
        SUB     R0, R0, #1      
        B       loop            

end_loop:

 		MOV     R7, #1
        SWI     0