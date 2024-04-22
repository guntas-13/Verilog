//TESTBENCH
module AdderTest4();

reg [7:0] A, B;
wire [7:0] SUM;
wire carry;
reg mode;

wire [7:0] gray;

Adder_sub8bit adder1(.A(A), .B(B), .mode(mode), .SUM(SUM),.gray(gray), .carry(carry));

initial begin
    // mode = 1 -> Subtract
    // mode = 0 -> Add
       A = 8'b10001010; B = 8'b10100001; mode = 1'b0; // A = 138, B = 161
    #5 A = 8'b10010001; B = 8'b01010110; mode = 1'b1; // A = 145, B = 86
    #5 A = 8'b01010110; B = 8'b10010001; mode = 1'b1; // A = 86, B = 145
    #5 A = 8'b00001011; B = 8'b00101101; mode = 1'b0; // A = 11, B = 45
    #5 A = 8'b00001010; B = 8'b00010110; mode = 1'b1; // A = 10, B = 22
    #5 A = 8'b00010110; B = 8'b00001010; mode = 1'b1; // A = 22, B = 10
end

endmodule