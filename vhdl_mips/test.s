A:
	lui	$0,-1			# $0=0
	lui	$1,-1			# $1=4294901760
	ori	$1,$1,-1		# $1=4294967295
	j	B				# skip
	lui	$2,1			# $2=65536
B:
	addi	$3,$0,42	# $3=42
	addiu	$4,$3,-6	# $4=36
	jr	$4				# skip
C: 
	j	C				# 			loop
	add	$5,$4,$3		# $5=78
	addu	$6,$5,$5	# $6=156
	and	$7,$6,$3		# $7=8
	andi	$8,$1,-23	# $8=65513
	nor	$9,$8,$6		# $9=4294901762
	or	$10,$9,$5		# $10=4294901838
	srl	$11,$10,8		# $11=16776960
	sll	$12,$11,4		# $12=268431360
	sub	$13,$12,$3		# $13=268431318
	subu	$14,$12,$13	# $14=42
	xori	$15,$14,7	# $15=45
	xor	$16,$15,$14		# $16=7
D:
	beq	$14,$5,D		#			loop
	beq	$14,$3,F		# skip
E:
	j	E				#			loop
F:
	bne	$4,$5,H			# skip
G:
	j	G				#			loop
H:
	bne	$3,$14,H		#			loop
	bgez	$0,J		# skip
I:
	j	I				#			loop
J:
	bgez	$1,J		#			loop
	bgez	$3,L		# skip
K:
	j	K				#			loop
L:
	bgtz	$0,L		# 			loop
M:
	bgtz	$1,M		#			loop
	bgtz	$3,O		# skip
N:
	j	N				#			loop
O:
	blez	$0,Q		# skip
P:
	j	P				#			loop
Q:
	blez	$3,Q		#			loop
	blez	$1,S		# skip
R:
	j	R				#			loop
S:
	bltz	$0,S		# 			loop
T:
	bltz	$3,T		#			loop
	bltz	$1,V		# skip
U:
	j	U				#			loop
V:
	addi	$17,$0,248	# $17=248
	sw	$1,-4 ($17)		# store 4294967295 at 244
	sw	$3,0($17)		# store 42 at 248
	sw	$4,4($17)		# store 36 at 252
	j	X
W:
	addi	$17,$17,-8	# $17=240
	j	Y
X:
	lw	$18,-4($17)		# $18=4294967295
	lw	$19,0($17)		# $19=42
	j	W
Y:
	lw	$20,12($17)		# $21=36
Z:
	j	Z				# loop
