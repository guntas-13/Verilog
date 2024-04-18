module AdderSub8Bit(input [7:0] A, input [7:0] B, input mode, output [7:0] C, output carry_borrow_out);
wire s1, s2, s3, s4, s5 , s6, s7, s8, c1, c2, c3, c4,c5, c6, c7, c8;

FullAdder res1(.A({A[0], B[0] ^ mode, mode}), .SUM(s1), .carry(c1));
FullAdder res2(.A({A[1], B[1] ^ mode, c1}), .SUM(s2), .carry(c2));
FullAdder res3(.A({A[2], B[2] ^ mode, c2}),.SUM(s3), .carry(c3));
FullAdder res4(.A({A[3], B[3] ^ mode, c3}),.SUM(s4), .carry(c4));
FullAdder res5(.A({A[4], B[4] ^ mode, c4}),.SUM(s5), .carry(c5));
FullAdder res6(.A({A[5], B[5] ^ mode, c5}),.SUM(s6), .carry(c6));
FullAdder res7(.A({A[6], B[6] ^ mode, c6}),.SUM(s7), .carry(c7));
FullAdder res8(.A({A[7], B[7] ^ mode, c7}),.SUM(s8), .carry(c8));

assign C = {s8, s7, s6, s5, s4, s3, s2, s1};
assign carry_borrow_out = c8;

endmodule