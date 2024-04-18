module mux4(A, SEL, OUT);
    input [0:3] A;
    input [0:1] SEL;
    output OUT;

    assign OUT = SEL[1] ? (SEL[0] ? A[3] : A[2]) : (SEL[0] ? A[1] : A[0]);
endmodule