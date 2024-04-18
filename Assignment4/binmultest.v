module testbench;

reg [7 : 0] a, b;
wire [15 : 0] p;

bin_mul obj(.Multiplicand(a), .Multiplier(b), .P(p));

initial begin
    $monitor($time, " A = %d (%b), B = %d (%b), P = %d (%b)", a, a, b, b, p, p);
    a = 8'b00000000; b = 8'b00000000;
    #100 a = 8'b00000110; b = 8'b00000101;
    #100 a = 8'b10010110; b = 8'b01101001;
    #100 a = 8'b11011010; b = 8'b00110101;
    #100 a = 8'b11111110; b = 8'b11111111;
    #100 a = 8'b11111111; b = 8'b11111111;
    #100 $finish;
end

endmodule