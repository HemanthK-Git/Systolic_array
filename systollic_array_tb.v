`timescale 1ns / 1ps

module systolic_array_tb;

    reg clk, rst;
    reg [31:0] a1, a2, a3;
    reg [31:0] b1, b2, b3;
    wire [63:0] c1, c2, c3, c4, c5, c6, c7, c8, c9;

    // Instantiate the systolic_array module
    systolic_array uut (
        .clk(clk), .rst(rst),
        .a1(a1), .a2(a2), .a3(a3),
        .b1(b1), .b2(b2), .b3(b3),
        .c1(c1), .c2(c2), .c3(c3),
        .c4(c4), .c5(c5), .c6(c6),
        .c7(c7), .c8(c8), .c9(c9)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        rst = 1;
        a1 = 0; a2 = 0; a3 = 0;
        b1 = 0; b2 = 0; b3 = 0;

        #10 rst = 0;

        // First clock input (Row 1 of A, Column 1 of B)
        a1 = 32'd1; a2 = 32'd2; a3 = 32'd3;
        b1 = 32'd9; b2 = 32'd6; b3 = 32'd3;

        #10;
        // Second clock input (Row 2 of A, Column 2 of B)
        a1 = 32'd4; a2 = 32'd5; a3 = 32'd6;
        b1 = 32'd8; b2 = 32'd5; b3 = 32'd2;

        #10;
        // Third clock input (Row 3 of A, Column 3 of B)
        a1 = 32'd7; a2 = 32'd8; a3 = 32'd9;
        b1 = 32'd7; b2 = 32'd4; b3 = 32'd1;

        #100;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | C1=%d C2=%d C3=%d | C4=%d C5=%d C6=%d | C7=%d C8=%d C9=%d",
                  $time, c1, c2, c3, c4, c5, c6, c7, c8, c9);
    end

endmodule
