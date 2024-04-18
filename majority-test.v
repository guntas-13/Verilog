module testbench;

reg [2:0] A;
wire OUT;

majority majOb(.A(A), .OUT(OUT));

    initial begin
        $dumpfile("gtkmajority.vcd");
        $dumpvars(0, testbench);
        $monitor($time, " W = %b%b%b, F = %b", A[2], A[1], A[0], OUT);
        #5 A = 3'b000;
        #5 A = 3'b001;
        #5 A = 3'b010;
        #5 A = 3'b011;
        #5 A = 3'b100;
        #5 A = 3'b101;
        #5 A = 3'b110;
        #5 A = 3'b111;
        #5 $finish;
    end

endmodule
