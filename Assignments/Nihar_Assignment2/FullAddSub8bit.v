`timescale 1ns / 1ps

module Adder_sub8bit(
  input [7:0] A,
  input [7:0] B,
  input mode,
  output [7:0] SUM,
  output [7:0] gray,
  output carry
);
wire s1, s2, s3, s4, s5, s6, s7, s8, c1, c2, c3, c4, c5, c6, c7, c8;
wire S1, S2, S3, S4, S5, S6, S7, S8, C1, C2, C3, C4, C5, C6, C7, C8;
reg [7:0] SUM1;
reg carry1;
wire [7:0] gray0; 

FullAdder add1(.A({A[0], B[0] ^ mode, mode}), .SUM(s1), .carry(c1));
FullAdder add2(.A({A[1], B[1] ^ mode, c1}), .SUM(s2), .carry(c2));
FullAdder add3(.A({A[2], B[2] ^ mode, c2}), .SUM(s3), .carry(c3));
FullAdder add4(.A({A[3], B[3] ^ mode, c3}), .SUM(s4), .carry(c4));
FullAdder add5(.A({A[4], B[4] ^ mode, c4}), .SUM(s5), .carry(c5));
FullAdder add6(.A({A[5], B[5] ^ mode, c5}), .SUM(s6), .carry(c6));
FullAdder add7(.A({A[6], B[6] ^ mode, c6}), .SUM(s7), .carry(c7));
FullAdder add8(.A({A[7], B[7] ^ mode, c7}), .SUM(s8), .carry(c8));

FullAdder add9(.A({~s1, 1'b0 , 1'b1}), .SUM(S1), .carry(C1));
FullAdder add10(.A({~s2, 1'b0, C1}), .SUM(S2), .carry(C2));
FullAdder add11(.A({~s3, 1'b0, C2}), .SUM(S3), .carry(C3));
FullAdder add12(.A({~s4, 1'b0, C3}), .SUM(S4), .carry(C4));
FullAdder add13(.A({~s5, 1'b0, C4}), .SUM(S5), .carry(C5));
FullAdder add14(.A({~s6, 1'b0, C5}), .SUM(S6), .carry(C6));
FullAdder add15(.A({~s7, 1'b0, C6}), .SUM(S7), .carry(C7));
FullAdder add16(.A({~s8, 1'b0, C7}), .SUM(S8), .carry(C8));

always @* begin
  if (mode == 1 & c8 == 0) begin
    SUM1 = {S8, S7, S6, S5, S4, S3, S2, S1};
    carry1 = C8;
  end
  
  else begin
    SUM1 = {s8, s7, s6, s5, s4, s3, s2, s1};
    carry1 = c8;
  end
end

assign SUM = SUM1;
assign carry = carry1;

GrayConverter gray1(.binary(SUM), .gray(gray0));
assign gray = gray0;
endmodule
