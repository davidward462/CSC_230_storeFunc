;
; storeFunc.asm
;
; Created: 08/03/2020 14:36:54
; Author : nkfyn
;

.cseg
.org 0

;stack pointer
ldi r16, high(RAMEND)
out SPH, r16
ldi r16, low(RAMEND)
out SPL, r16

;arguments
ldi r16, 0xDD ;value 
push r16
ldi r16, low(0x0200) ;address
push r16
ldi r16, high(0x0200) ;address
push r16

call store

done:
	rjmp done

store:
	.equ offset = 6
	;preserve
	push XL
	push XH
	push r16

	;init Y
	in YL, SPL
	in YH, SPH

	;store address
	ldd XH, Y+offset+1
	ldd XL, Y+offset+2

	;value
	ldd r16, Y+offset+3

	;process
	st X, r16

	;restore
	pop r16
	pop XH
	pop XL

	ret 

.dseg
.org 0x0200
