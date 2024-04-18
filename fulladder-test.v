module testbench;
reg A, B, C_in;
wire C_out, Sum;

fullAdder FAdd(.A(A), .B(B), .C_in(C_in), .C_out(C_out), .Sum(Sum));

    initial begin
        $dumpfile("gtkAdder.vcd");
        $dumpvars(0, testbench);
        $monitor($time, " ABC_in = %b%b%b, SUM = %b, C_out = %b", A, B, C_in, Sum, C_out);
        #5 A = 0; B = 0; C_in = 0;
        #5 C_in = 1;
        #5 B = 1; C_in = 0;
        #5 C_in = 1;
        #5 A = 1; B = 0; C_in = 0;
        #5 C_in = 1;
        #5 B = 1; C_in = 0;
        #5 C_in = 1;
        #5 $finish;
    end

endmodule