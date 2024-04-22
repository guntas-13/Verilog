module mealy(clk, 
             rstn, 
             w, 
             z);

input clk, rstn, w;
output reg z;

reg [2:0] y, Y;
parameter [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

always @(w or y) begin
    case(y)
        A: if(w) begin Y = B; z = 0; end else begin Y = A; z = 0; end
        B: if(w) begin Y = B; z = 0; end else begin Y = C; z = 0; end
        C: if(w) begin Y = B; z = 0; end else begin Y = D; z = 0; end
        D: if(w) begin Y = E; z = 0; end else begin Y = A; z = 0; end
        E: if(w) begin Y = B; z = 0; end else begin Y = C; z = 1; end
        default: Y = 3'bxxx; z = 0;
    endcase
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'b0) y <= A;
    else y <= Y;
end

endmodule