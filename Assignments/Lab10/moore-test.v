module testbench;

reg clk;
reg rstn;
reg w;
wire z;

moore obj(.clk(clk), .rstn(rstn), .w(w), .z(z));

always #2.5 clk = ~clk;

initial begin
    $monitor($time, " w=%b, z=%b", w, z);
    clk = 1'b0;
    rstn = 1'b0; w = 1'b0;
    #5 rstn = 1'b1; 
    #5 w = 1'b1;
    #5 w = 1'b0;
    #5 w = 1'b0;
    #5 w = 1'b1;
    #5 w = 1'b0;
    #5 w = 1'b0;
    #5 w = 1'b1;
    #5 w = 1'b0;
    #5 w = 1'b1;
    #5 w = 1'b1;
    #5 w = 1'b0;
    #5 $finish();
end
    
endmodule