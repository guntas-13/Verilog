module shiftreg(
    input En,
    input clk,
    input [3:0] preset,
    input [1:0] SEL3,
    output reg [3:0] Q
    );

// SEL3 = 0 -> PARALLEL SHIFT
// SEL3 = 1 -> RIGHT SHIFT
// SEL3 = 2 -> LEFT SHIFT
// En = 0 -> Shift Register brings down its values from the received 4 bits of Counter

and (pr1, En, preset[0]);
and (pr2, En, preset[1]);
and (pr3, En, preset[2]);
and (pr4, En, preset[3]);

always @(posedge clk) begin
    if (SEL3 == 2'b00) begin
        Q <= {pr4, pr3, pr2, pr1};
    end

    else if (SEL3 == 2'b01) begin
        Q <= Q >> 1;
    end

    else if (SEL3 == 2'b10) begin
        Q <= Q << 1;
    end
    
end


endmodule