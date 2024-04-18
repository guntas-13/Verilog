module bin_mul(Multiplicand, Multiplier, P);

parameter N = 8;
input [N - 1 : 0] Multiplicand, Multiplier;
output reg [2 * N - 1 : 0] P;

reg [2 * N - 1 : 0] MultiplicandC;
reg [2 * N - 1 : 0] MultiplierC;
integer i;

always @(*) begin
    P = 0;
    MultiplicandC = Multiplicand;
    MultiplierC = Multiplier;
    for (i = 0; i < N; i = i + 1) begin
        if (MultiplierC[0] == 1) begin
            P = P + MultiplicandC;
        end
        MultiplicandC = MultiplicandC << 1;
        MultiplierC = MultiplierC >> 1;
    end
end

endmodule