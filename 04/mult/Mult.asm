// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// R0 will be added to itself R1 times
// sum starts as 0 so that if (R0 || R1) == 0 then R2=0

@i // iterator
M=0
@sign // tracks negative val
M=1
@R2 // where final result is stored
M=0

@R0 // determine final sign val from both starting values
D=M // this is done by looking at the sign of each of the given
@ar0 // args stored in R0 and R1, respectively
M=D
@NEXTARG
D; JGE
@ar0
M=-M
@sign
M=-M
(NEXTARG)
@R1
D=M
@ar1
M=D
@LOOP
D; JGE
@ar1
M=-M
@sign
M=-M

(LOOP)  // "multiply"
@i
D=M
@ar1
D=D-M // D=i-ar1, (times R0 added to R2)-(vale of R1)
@EXITMULT
D;JGE // If (i-ar1)>=0; goto EXITMULT and exit "multiply"
@ar0
D=M
@R2
M=D+M // sum=R0+sum
@i
M=M+1 // i++
@LOOP
0;JMP // goto LOOP


(EXITMULT) // if sign is negative then R2 will have its sign flipped
@sign
D=M
@FS
D; JLT  // if sign is neg then flip sign of R2
@END
0;JMP
(FS)
@R2
M=-M


(END)
@END
0;JMP // Infinite loop
