module testbench;

reg [7:0] A, B;
reg mode;

wire [7:0] C;
wire carry_borrow_out;

AdderSub8Bit obj(.A(A), .B(B), .mode(mode), .C(C), .carry_borrow_out(carry_borrow_out));

initial begin
    // mode = 1 -> Subtract
    // mode = 0 -> Add
    $monitor($time, " A = %d, B = %d, MODE = %b, Carry = %b, WOCarry = %b%b%b%b%b%b%b%b", A, B, mode, carry_borrow_out, C[7], C[6], C[5], C[4], C[3], C[2], C[1], C[0]);
       A = 8'b00001001; B = 8'b0000100x; mode = 1'b0; // A = 138, B = 161
    #5 A = 8'b10010001; B = 8'b01010110; mode = 1'b1; // A = 145, B = 86
    #5 A = 8'b01010110; B = 8'b10010001; mode = 1'b1; // A = 86, B = 145
    #5 A = 8'b00001011; B = 8'b00101101; mode = 1'b0; // A = 11, B = 45
    #5 A = 8'b00001010; B = 8'b00010110; mode = 1'b1; // A = 10, B = 22
    #5 A = 8'b00010110; B = 8'b00001010; mode = 1'b1; // A = 10, B = 22
end

endmodule