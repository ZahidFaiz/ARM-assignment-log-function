     area     appcode, CODE, READONLY
     export __main
	 ENTRY 
__main  function		 
       VLDR.F32   s4, = 0	; Result
       VLDR.F32   s5, =0.3	; value x
	   VLDR.F32   s14, = 1	; denominator
	   VLDR.F32   s7, = 0	; intermediate register a
	   VLDR.F32	  s8, = 1	; flag for the sign 
	   VLDR.F32   s9, = 1   ; for increment
	   VADD.F32	  s4, s5, s4 ; first number
	   VLDR.F32   s10, =0.3
	; This loop will calculate each term one by and 
	; either add or substract from the result register s4
	
	   
loop	VMUL.F32 s10, s10, s5
		VMUL.F32 s7, s10, s9     ; Calculate the next term od the series 
		VADD.F32 s14, s14, s9		; increment the denominator value
		VDIV.F32 s7, s7, s14		; divide the denominator, and the result will be next term
			
		; This s7 register holds the next term of the series which has to either added or subtracted 
		VCMP.F32 s8, s9          ; For this s8 is used as a flag register which toogles between 0, 1 
		VMRS APSR_nzcv,FPSCR
		VADDNE.F32 s4, s4, s7     ; then the next term is added if the s8 is equal to 0
		VADDNE.F32 s8, s8, s9
   		VSUBEQ.F32 s4, s4, s7		; then the next term is substracted if the s8 is equal to 1
		VSUBEQ.F32 s8, s8, s9
		B loop 
		
		; After testing the values for two series results are log(1 + 0.5 ) = 0.17609 and log (1 + 2) = 0.47712
     endfunc
     end
