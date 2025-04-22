module matrix_selector (
    input clk,
    input reset,
    input [1:0] select, 
    output  [31:0] a0_out,a1_out,a2_out,  // Outputs from memory_a (32 bits)
    output  [31:0] b0_out,b1_out, b2_out   // Outputs from memory_b (32 bits)
);

  reg [31:0] memory_a [0:5][0:5];  // 32-bit wide memory_a
  reg [31:0] memory_b [0:5][0:5];  // 32-bit wide memory_b
  
  reg [31:0] out_a0, out_a1, out_a2; // Outputs from memory_a (32 bits)
  reg [31:0] out_b0, out_b1, out_b2;

  reg [2:0] row_counter;   // Counter for row selection in memory_a
  reg [2:0] col_counter;   // Counter for column selection in memory_b

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset outputs
      out_a0 <= 32'd0;
      out_a1 <= 32'd0;
      out_a2 <= 32'd0;
      out_b0 <= 32'd0;
      out_b1 <= 32'd0;
      out_b2 <= 32'd0;

      // Reset counters
      row_counter <= 3'd0;
      col_counter <= 3'd0;

      // Initialize memory_a
      memory_a[0][0] <= 32'd1; memory_a[0][1] <= 32'd0; memory_a[0][2] <= 32'd1; memory_a[0][3] <= 32'd1; memory_a[0][4] <= 32'd2; memory_a[0][5] <= 32'd2;
      memory_a[1][0] <= 32'd3; memory_a[1][1] <= 32'd2; memory_a[1][2] <= 32'd1; memory_a[1][3] <= 32'd2; memory_a[1][4] <= 32'd1; memory_a[1][5] <= 32'd1;
      memory_a[2][0] <= 32'd1; memory_a[2][1] <= 32'd0; memory_a[2][2] <= 32'd2; memory_a[2][3] <= 32'd1; memory_a[2][4] <= 32'd2; memory_a[2][5] <= 32'd1;
      memory_a[3][0] <= 32'd2; memory_a[3][1] <= 32'd1; memory_a[3][2] <= 32'd0; memory_a[3][3] <= 32'd1; memory_a[3][4] <= 32'd0; memory_a[3][5] <= 32'd0;
      memory_a[4][0] <= 32'd3; memory_a[4][1] <= 32'd3; memory_a[4][2] <= 32'd3; memory_a[4][3] <= 32'd1; memory_a[4][4] <= 32'd1; memory_a[4][5] <= 32'd1;
      memory_a[5][0] <= 32'd2; memory_a[5][1] <= 32'd2; memory_a[5][2] <= 32'd2; memory_a[5][3] <= 32'd2; memory_a[5][4] <= 32'd2; memory_a[5][5] <= 32'd2;

      // Initialize memory_b
      memory_b[0][0] <= 32'd2; memory_b[0][1] <= 32'd2; memory_b[0][2] <= 32'd3; memory_b[0][3] <= 32'd3; memory_b[0][4] <= 32'd1; memory_b[0][5] <= 32'd1;
      memory_b[1][0] <= 32'd3; memory_b[1][1] <= 32'd2; memory_b[1][2] <= 32'd1; memory_b[1][3] <= 32'd2; memory_b[1][4] <= 32'd1; memory_b[1][5] <= 32'd0;
      memory_b[2][0] <= 32'd2; memory_b[2][1] <= 32'd2; memory_b[2][2] <= 32'd2; memory_b[2][3] <= 32'd1; memory_b[2][4] <= 32'd1; memory_b[2][5] <= 32'd2;
      memory_b[3][0] <= 32'd2; memory_b[3][1] <= 32'd3; memory_b[3][2] <= 32'd2; memory_b[3][3] <= 32'd1; memory_b[3][4] <= 32'd2; memory_b[3][5] <= 32'd1;
      memory_b[4][0] <= 32'd2; memory_b[4][1] <= 32'd3; memory_b[4][2] <= 32'd2; memory_b[4][3] <= 32'd1; memory_b[4][4] <= 32'd1; memory_b[4][5] <= 32'd3;
      memory_b[5][0] <= 32'd3; memory_b[5][1] <= 32'd3; memory_b[5][2] <= 32'd3; memory_b[5][3] <= 32'd2; memory_b[5][4] <= 32'd1; memory_b[5][5] <= 32'd1;
    end 
    else if (1) begin
      // Handle the memory selection logic based on select
      case (select)
        2'b00: begin
          out_a0 <= memory_a[0][row_counter];
          out_a1 <= memory_a[1][row_counter];
          out_a2 <= memory_a[2][row_counter];

          out_b0 <= memory_b[col_counter][0];
          out_b1 <= memory_b[col_counter][1];
          out_b2 <= memory_b[col_counter][2];
        end
        2'b01: begin
          out_a0 <= memory_a[0][row_counter];
          out_a1 <= memory_a[1][row_counter];
          out_a2 <= memory_a[2][row_counter];

          out_b0 <= memory_b[col_counter][3];
          out_b1 <= memory_b[col_counter][4];
          out_b2 <= memory_b[col_counter][5];
        end
        2'b10: begin
          out_a0 <= memory_a[3][row_counter];
          out_a1 <= memory_a[4][row_counter];
          out_a2 <= memory_a[5][row_counter];

          out_b0 <= memory_b[col_counter][0];
          out_b1 <= memory_b[col_counter][1];
          out_b2 <= memory_b[col_counter][2];
        end
        2'b11: begin
          out_a0 <= memory_a[3][row_counter];
          out_a1 <= memory_a[4][row_counter];
          out_a2 <= memory_a[5][row_counter];

          out_b0 <= memory_b[col_counter][3];
          out_b1 <= memory_b[col_counter][4];
          out_b2 <= memory_b[col_counter][5];       
        end
      endcase

      // Increment counters (row and col independently)
      if (row_counter < 5)
        row_counter <= row_counter + 1;
      else
        row_counter <= 0;

      if (col_counter < 5)
        col_counter <= col_counter + 1;
      else
        col_counter <= 0;
    end
  end
  
      assign a0_out = out_a0;
      assign a1_out = out_a1;
      assign a2_out = out_a2;
      assign b0_out = out_b0;
      assign b1_out = out_b1;
      assign b2_out = out_b2;

endmodule
