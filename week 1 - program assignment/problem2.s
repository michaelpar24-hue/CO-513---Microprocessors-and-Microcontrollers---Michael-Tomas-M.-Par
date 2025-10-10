.global _start

_start:
     
		MOV R0, #147			
		MOV R1, #84				
		
loop:
        CMP     r0, r1  		      
        BEQ     done    		 

        BGT     greater_val 	  
		BLT		lower_val		 
		
lower_val:
       
        SUB     r1, r1, r0 		   
        B       loop			

greater_val:

        SUB     r0, r0, r1      
        B       loop

done:
         
        MOV     r7, #1          
        SWI     0

	