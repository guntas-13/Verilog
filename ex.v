module deco(I, O);
input [1:0] I;
output [3:0] O;

assign O = I[0] ? (I[1] ? 4'b1000 : 4'b0010) : (I[1] ? 4'b0100 : 4'b0001);

endmodule