module division(A, B, Res, Rem);

  // the size of input and output ports of the division module is generic.
  parameter WIDTH = 8;

  // input and output ports.
  input [WIDTH-1:0] A;
  input [WIDTH-1:0] B;
  output [WIDTH-1:0] Res;
  output reg [WIDTH-1:0] Rem;

  // internal variables
  reg [WIDTH-1:0] Res;
  reg [WIDTH-1:0] a1, b1;
  reg [WIDTH:0] p1;
  integer i;

  always @(A or B)
    begin
      // initialize the variables.
      a1 = A;
      b1 = B;
      p1 = 0;

      for (i = 0; i < WIDTH; i = i + 1) begin
        // Shift in the next bit of the dividend and subtract the divisor.
        p1 = {p1[WIDTH-2:0], a1[WIDTH-1]};
        a1[WIDTH-1:1] = a1[WIDTH-2:0];
        p1 = p1 - b1;

        // Check if the result is negative (borrow occurred).
        // If so, add the divisor back and set the corresponding bit of a1 to 1.
        if (p1[WIDTH-1] == 1'b1) begin
          a1[0] = 0;
          p1 = p1 + b1;
        end else begin
          a1[0] = 1;
        end
      end

      // After the loop, the quotient is in a1 and the remainder is in p1.
      Res = a1;
      Rem = p1;
    end

endmodule