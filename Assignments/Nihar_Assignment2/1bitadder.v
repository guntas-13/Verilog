//ADDSUB1BIT
`timescale 1ns / 1ps
module FullAdder(input [2:0] A, output SUM, output carry);
// A[2] = A, A[1] = B, A[0] = C_in
xor (SUM, A[0], A[1], A[2]);
and (a1, A[2], A[1]);
and (a2, A[1], A[0]);
and (a3, A[0], A[2]);
or (carry, a1, a2, a3);
endmodule