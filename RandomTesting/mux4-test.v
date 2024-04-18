module testbench_mux4;

reg [3:0] A;
reg [1:0] SEL; 
wire OUT;

    mux4 MUX4x1(.A(A), .SEL(SEL), .OUT(OUT));

    initial
        begin
            $monitor($time, "  A = %b%b%b%b, SEL = %b%b, OUT = %b", A[0], A[1], A[2], A[3], SEL[0], SEL[1], OUT);
            #10 A = 4'b1010; SEL = 2'b11;
            #10 SEL = 2'b10;
            #10 SEL = 2'b01;
            #10 SEL = 2'b00;
            #10 $finish;
        end

endmodule
