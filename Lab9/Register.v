`timescale 1ns / 1ps


module MOV(s0, s1, s2, mode, rstn, clk, destprev, reg1, reg2, destnew, Cy);

input [3:0] s0, s1, s2;
input [1:0] mode;
input rstn, clk;
reg [15:0] RegFile [31:0];
output reg [31:0] destprev;
output reg [31:0] reg1;
output reg [31:0] reg2;
output reg [31:0] destnew;
output reg Cy;
reg [32:0] temp;
integer i;
always @(posedge clk or posedge rstn) begin 
    
    if (rstn) begin
        for (i = 0; i < 16; i = i + 1) begin
            RegFile[i] = 32'b1 << i;
        end
        reg1 = RegFile[s0];
        reg2 = RegFile[s1];
        destprev = RegFile[s2];
        destnew = RegFile[s2];
        Cy = 1'b0;
    end
    else begin
        if (mode == 2'b01) begin
            // ADD Rx Ry Rz
            reg1 = RegFile[s0];
            reg2 = RegFile[s1];
            destprev = RegFile[s2];
            temp = RegFile[s0] + RegFile[s1];
            RegFile[s2] = temp[31:0];
            Cy = temp[32];
            destnew = RegFile[s2];
        end

        else if (mode == 2'b10) begin
            // AND Rx Ry Rz
            reg1 = RegFile[s0];
            reg2 = RegFile[s1];
            destprev = RegFile[s2];
            RegFile[s2] = RegFile[s0] & RegFile[s1];
            destnew = RegFile[s2];
        end
    end
end
endmodule
