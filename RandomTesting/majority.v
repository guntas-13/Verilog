module majority(input [2:0] A, output reg OUT);

    // assign OUT = (A[2] & A[1]) | (A[0] & A[1]) | (A[2] & A[0]);
    
    always @( *) begin
        if (A[2] & A[1])
            OUT = 1;
        else
            if (A[2] | A[1])
                OUT = A[0];
            else
                OUT = 0;
    end

endmodule
