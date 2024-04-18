module GrayConverter(input [8:0] binary, output [8:0] gray);
    assign gray[8] = binary[8];
    assign gray[7] = binary[7] ^ binary[8];
    assign gray[6] = binary[6] ^ binary[7];
    assign gray[5] = binary[5] ^ binary[6];
    assign gray[4] = binary[4] ^ binary[5];
    assign gray[3] = binary[3] ^ binary[4];
    assign gray[2] = binary[2] ^ binary[3];
    assign gray[1] = binary[1] ^ binary[2];
    assign gray[0] = binary[0] ^ binary[1];
endmodule