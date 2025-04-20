// multiply Acumulate Array

`timescale 1ns/1ps

module mac(
    input wire clk,
    input wire rst,
    input wire signed [31:0] in_a,
    input wire signed [31:0] in_b,
    output wire signed [31:0] out_a,
    output wire signed [31:0] out_b,
    output wire signed [63:0] out_c
);

  // Intermediate signals
  wire signed [63:0] mul;
  wire signed [63:0] add;

  // Instantiate D flip-flops for inputs and accumulator
  d_ff_32 d1 (.d(in_a), .clk(clk), .rst(rst), .q(out_a));
  d_ff_32 d2 (.d(in_b), .clk(clk), .rst(rst), .q(out_b));

  assign mul = in_a * in_b;       // 32x32 multiplication ? 64 bits
  assign add = out_c + mul;       // Accumulate result

  d_ff_64 d3 (.d(add), .clk(clk), .rst(rst), .q(out_c));

endmodule


// 32-bit D flip-flop module
module d_ff_32(
    input wire signed [31:0] d,
    input wire clk,
    input wire rst,
    output reg signed [31:0] q
);
    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule


// 64-bit D flip-flop module
module d_ff_64(
    input wire signed [63:0] d,
    input wire clk,
    input wire rst,
    output reg signed [63:0] q
);
    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule
