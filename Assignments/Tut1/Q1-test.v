module testbench;

reg [3:0] A;
wire OUT;

logc logi(.A(A), .OUT(OUT));

initial begin
    $monitor($time, " A = %b, OUT = %b", A, OUT);
    A = 4'b0000;
    #1 A = 4'b0001;
    #1 A = 4'b0010;
    #1 A = 4'b0011;
    #1 A = 4'b0100;
    #1 A = 4'b0101;
    #1 A = 4'b0110;
    #1 A = 4'b0111;
    #1 A = 4'b1000;
    #1 A = 4'b1001;
    #1 A = 4'b1010;
    #1 A = 4'b1011;
    #1 A = 4'b1100;
    #1 A = 4'b1101;
    #1 A = 4'b1110;
    #1 A = 4'b1111;
    #1 $finish;
end

endmodule