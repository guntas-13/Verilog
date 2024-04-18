module fullAdder(input A, input B, input C_in, output C_out, output Sum);

assign {C_out, Sum} = A + B + C_in;

endmodule