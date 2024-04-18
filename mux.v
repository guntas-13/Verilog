`timescale 1ns/10ps
module mux2(A, B, SEL, OUT);

    input A, B, SEL;
    output OUT;

    and (g, A, ~SEL);
    and (f, B, SEL);
    or (OUT, f, g);

endmodule