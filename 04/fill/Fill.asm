// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.


//-----------------------
// Initialize vars
@24575  // last register in screen mem map
D=A
@screenend
M=D
//-----------------------


(LOOP)  // "screen changing loop"
// reset LOOP vars
@SCREEN  //  reg address at start of screen mem map
D=A
@address
M=D //

@KBD
D=M
@IFKEY  // if keypress set state=-1, else set state=0, and redraw
D; JGT
@state  // draw white
M=0
@REDRAW
0; JMP
(IFKEY)
@state  // draw black
M=-1
@REDRAW
0; JMP


(REDRAW)
@address
D=M
@screenend
D=D-M // D=address-24575
@LOOP
D;JGT // If (i-endofscreenmm)>=0; goto LOOP and exit REDRAW
@state
D=M
@address
A=M
M=D
@address
M=M+1
@REDRAW
0;JMP // goto LOOP
