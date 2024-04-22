module moore(input clk, 
             input rstn, 
             input w, 
             output z);

reg [2:0] y, Y;
parameter [2:0] q0 = 3'b000, q1 = 3'b001, q2 = 3'b010, q3 = 3'b011, q4 = 3'b100, q5 = 3'b101;

always @(w or y) begin
    case(y)
        q0: if(w) Y = q1; else Y = q0;
        q1: if(w) Y = q1; else Y = q2;
        q2: if(w) Y = q1; else Y = q3;
        q3: if(w) Y = q4; else Y = q0;
        q4: if(w) Y = q1; else Y = q5;
        q5: if(w) Y = q1; else Y = q3;
        default Y = 3'bxxx;
    endcase
end

always @(negedge rstn or posedge clk) begin
    if(rstn == 1'b0) y <= q0;
    else y <= Y;
end

assign z = (y == q5);

endmodule