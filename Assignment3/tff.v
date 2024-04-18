module tff(
    input T, 
    input rstn, preset, clk,
    output reg Q
    );

    always @(posedge clk or negedge rstn or negedge preset) begin
        if (!rstn) begin
            Q <= 0;
        end
        else if (!preset) begin
            Q <= 1;
        end
        else begin
            Q <= (T ? ~Q : Q);
        end
    end

endmodule