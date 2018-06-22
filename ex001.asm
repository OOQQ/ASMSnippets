	ORG 0xC350 ;50000
	LD HL, 0x5800 ;22528
	LD A, 0xC ;10
loop	LD B, 0x10 ;16
row0	LD (HL), 0
	INC HL
	LD (HL), 0x7F ;127
	INC HL
	DJNZ row0
	LD B, 0x10
row1	LD (HL), 0x7F ;127
	INC HL
	LD (HL), 0
	INC HL
	DJNZ row1
	DEC A
	JR NZ, loop
	RET
