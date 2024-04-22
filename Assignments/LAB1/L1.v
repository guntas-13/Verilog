module Lab1(A, B, C, D, OUT);
input A, B, C, D;
output OUT;

and (out1, A, D);
and (out2, B, ~C, D);
and (out3, ~A, ~B, ~D);
or (OUT, out1, out2, out3);

endmodule