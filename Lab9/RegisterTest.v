`timescale 1ns / 1ps

module sim_reg_file;
    reg [3:0] s0;
    reg [3:0] s1;
    reg [3:0] s2;
    reg [1:0] mode;
    wire Cy;
    reg rstn;
    reg clk;
    wire [31:0] reg1;
    wire [31:0] reg2;
    wire [31:0] destprev;
    wire [31:0] destnew;
    MOV obj(.s0(s0),
            .s1(s1),
            .s2(s2),.mode(mode),
            .rstn(rstn),
            .clk(clk),.reg1(reg1),.reg2(reg2),.destprev(destprev),.destnew(destnew)
            ,.Cy(Cy));

always #1 clk = ~clk;
    
initial begin

$monitor($time, " x=%d, y=%d, z=%d, mode=%b, Rx=%d, Ry=%d, RzOLD=%d, RzNEW=%d, Carry=%b", s0, s1, s2, mode, reg1, reg2, destprev, destnew, Cy);
clk = 1'b0;
rstn = 1'b1; // initialise the Registers
s0 = 4'b0101; s1 = 4'b0100; s2 = 4'b0011; mode = 2'b10;  // AND R5 R4 R3 => Initially R5 = 32, R4 = 16, R3 = 8 => New R3 = 0
#5 rstn = 1'b0; s0 = 4'b0010; s1 = 4'b0001; s2 = 4'b0011; mode = 2'b10;  // AND R2 R1 R3 => Initially R2 = 4, R1 = 2, R3 = 0 => New R3 = 0
#5 s0 = 4'b0000; s1 = 4'b0101; s2 = 4'b0011;  mode = 2'b01; // ADD R0 R5 R3 => Initially R0 = 1, R5 = 32, R3 = 0 => New R3 = 33
#5 s0 = 4'b1100; s1 = 4'b1001; s2 = 4'b1011;  mode = 2'b01; // ADD R12 R9 R11 => Initially R12 = 4096, R9 = 512, R11 = 33 => New R11 = 4129
#5 $finish();
end

endmodule