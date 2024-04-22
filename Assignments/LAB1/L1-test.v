module testbench;

reg A, B, C, D;
wire OUT;

Lab1 Obj(.A(A), .B(B), .C(C), .D(D), .OUT(OUT));

    initial begin
        $monitor($time, " ABCD = %b%b%b%b, RES = %b", A, B, C, D, OUT);
        #5 A = 0; B = 0; C = 0; D = 0;
        #5 D = 1;
        #5 C = 1; D = 0;
        #5 D = 1;
        #5 B = 1; C = 0; D = 0;
        #5 D = 1;
        #5 C = 1; D = 0;
        #5 D = 1;
        #5 A = 1; B = 0; C = 0; D = 0;
        #5 D = 1;
        #5 C = 1; D = 0;
        #5 D = 1;
        #5 B = 1; C = 0; D = 0;
        #5 D = 1;
        #5 C = 1; D = 0;
        #5 D = 1;
        #5 $finish;
    end

endmodule