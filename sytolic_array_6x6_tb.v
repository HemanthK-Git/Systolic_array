`timescale 1ns / 1ps

module tb_matrix_selector;

  reg clk;
  reg reset;
  reg [1:0] select;
  wire [31:0] a0_out, a1_out, a2_out;
  wire [31:0] b0_out, b1_out, b2_out;

  // Instantiate the module
  matrix_selector uut (
    .clk(clk),
    .reset(reset),
    .select(select),
    .a0_out(a0_out), .a1_out(a1_out), .a2_out(a2_out),
    .b0_out(b0_out), .b1_out(b1_out), .b2_out(b2_out)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    select = 2'b00;
    #10;
    
    reset = 0;

    // Test all select values
    select = 2'b00; #60;
    

    $finish;
  end

 

endmodule
