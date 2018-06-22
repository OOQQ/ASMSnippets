	ORG 50000
last_k	equ 23560

	LD HL, udgs
	LD (23675), HL

	LD A, 2
	CALL 5633

;draw game title
	LD DE, banner
	LD BC, eobanr-banner
	CALL 8252

;draw board
bdraw	LD DE, board
	LD BC, eoboard-board
	CAlL 8252
	LD HL, board+1
	LD A, (HL)
	INC A
	LD (HL), A
	CP 16
	JR NZ, bdraw

;draw player line
	LD DE, player
	LD BC, eoplyr-player
	CALL 8252

;show player
ploop	LD HL, 22816
	LD BC, (ppos)
	ADD HL, BC
	LD A, (pcol)
	LD (HL), A

;invite player input
	LD HL, last_k
	LD A, (HL)
	CP 112
	JR Z, pright
	CP 111
	JR Z, pleft
	CP 32
	JR Z, pfire
	CP 114
	JR Z, newgame
	JR ploop

;restart
newgame	LD HL, drop
	LD B, 7
rstdrp	LD (HL), 6
	INC HL
	DJNZ rstdrp

;clear board
	LD A, 6
	LD B, 7
	LD HL, 22860
	LD DE, 25
empty	LD (HL), 15
	INC HL
	DJNZ empty
	LD b, 7
	ADD HL, DE
	DEC A
	CP 0
	JP Z, clrkey
	JR empty

;player moves right
pright	LD A, (ppos)
	CP 18
	JR Z, ploop
	LD HL, 22816
	LD BC, (ppos)
	ADD HL, BC
	LD (HL), 63
	LD A, (ppos)
	INC A
	LD (ppos), A
	JP clrkey

;player moves left
pleft	LD A, (ppos)
	CP 12
	JR Z, ploop
	LD HL, 22816
	LD BC, (ppos)
	ADD HL, BC
	LD (HL), 63
	LD A, (ppos)
	DEC A
	LD (ppos), A
	JP clrkey

;player fires
pfire	LD A, (ppos)
	SUB 11
	LD HL, drop-1
	LD B, A
cnrt	INC HL
	DJNZ cnrt
	LD A, (HL)
	LD (tdrop), A
	CP 0
	JP Z, clrkey
	LD HL, 22816
	LD BC, (ppos)
	ADD HL, BC
	LD (HL), 63

;counter drops
	LD A, (tdrop)
desnd	LD BC, 32
	ADD HL, BC
	LD D, A
	LD A, (pcol+1)
	LD (HL), A
	LD A, D
	LD B, 5
stall	HALT
	DJNZ STALL
	LD (HL), 15
	DEC A
	JR NZ, desnd
	LD A, (pcol+1)
	LD (HL), A
;decrement remaining slots by 1
	LD A, (ppos)
	SUB 11
	LD HL, drop-1
	LD B, A
cntr2	INC HL
	DJNZ cntr2
	LD A, (tdrop)
	DEC A
	LD (tdrop), A
	LD (HL), A
;change color for other player
	LD HL, ppos
	LD (HL), 15
	LD A, (pcol)
	ADD A, 4
	LD (pcol), A
	LD A, (pcol+1)
	ADD A, 4
	LD (pcol+1), A
	CP 18
	JR Z, badcol
	JR clrkey
badcol	LD A, 58
	LD (pcol), A
	LD A, 10
	LD (pcol+1), A
	JR clrkey

;clear last keypress and loop back
clrkey	LD HL, last_k
	LD (HL), 0
	JP ploop

;variables
ppos	defb 15, 0
pcol	defb 58, 10
drop	defb 6, 6, 6, 6, 6, 6, 6
tdrop	defb 0

banner defb 22, 3, 11, "Conecta 4"
eobanr equ $

;board setup
board	defb 22, 10, 12
	defb 16, 7, 17, 1, 144, 144, 144, 144, 144, 144, 144
eoboard equ $

player defb 22, 9, 12
	defb 16, 7, 17, 7, 144, 144, 144, 144, 144, 144, 144
eoplyr equ $

;grph setup
udgs	defb 0, 24, 60, 126, 126, 60, 24, 0
