	ORG	0xC350 ;50000
	LD HL, udgs
	LD (23675), HL
	LD A, 2
	CALL 0x1601 ;call a rom routine in 5633 (to print in to left corner)
	LD DE, string
	LD BC, eostr-string
	CALL 0x203C ;8252
	LD A, 144
	RST 16
	RET
string	defb 16, 2, 17, 6, 22, 3, 11, "Hello World"
eostr	equ $
udgs	defb 0, 24, 60, 126, 126, 60, 24, 0 ;defb = not opcodes but data

