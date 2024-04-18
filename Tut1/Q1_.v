module mod1(A, OUT);

input [3:0] A;
output OUT;

assign OUT = (~A[2] & ~A[0]) | (A[1] & A[0]) | (~A[3] & ~A[1] & ~A[0]);

endmodule