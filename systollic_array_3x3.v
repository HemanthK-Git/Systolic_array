`timescale 1ns / 1ps

module systolic_array(
    input [31:0] a1,a2,a3,
    input [31:0] b1,b2,b3,
    input rst, clk,
    output [63:0] c1,c2,c3,c4,c5,c6,c7,c8,c9
    );
    
    wire [31:0] m1h,m2h,m1v,m2v,m3v,m4h,m4v,m5h,m5v,m6v,m3h,m6h,m7v,m7h,m8h,m8v,m9h,m9v,b2d,b3d,b33d,a2d,a3d,a33d;
    

    mac m1(.clk(clk),.rst(rst),.in_a(a1),.in_b(b1),.out_a(m1h),.out_b(m1v),.out_c(c1));
    
    d_ff d1(.d(b2),.clk(clk),.rst(rst),.q(b2d));
    mac m2(.clk(clk),.rst(rst),.in_a(m1h),.in_b(b2d),.out_a(m2h),.out_b(m2v),.out_c(c2));
    
    d_ff d2(.d(b3),.clk(clk),.rst(rst),.q(b3d));
    d_ff d3(.d(b3d),.clk(clk),.rst(rst),.q(b33d));
    mac m3(.clk(clk),.rst(rst),.in_a(m2h),.in_b(b33d),.out_a(m3h),.out_b(m3v),.out_c(c3));
    
    d_ff d4(.d(a2),.clk(clk),.rst(rst),.q(a2d));  
    mac m4(.clk(clk),.rst(rst),.in_a(a2d),.in_b(m1v),.out_a(m4h),.out_b(m4v),.out_c(c4));    
    mac m5(.clk(clk),.rst(rst),.in_a(m4h),.in_b(m2v),.out_a(m5h),.out_b(m5v),.out_c(c5));    
    mac m6(.clk(clk),.rst(rst),.in_a(m5h),.in_b(m3v),.out_a(m6h),.out_b(m6v),.out_c(c6)); 
    
    d_ff d5(.d(a3),.clk(clk),.rst(rst),.q(a3d));  
    d_ff d6(.d(a3d),.clk(clk),.rst(rst),.q(a33d));  
    mac m7(.clk(clk),.rst(rst),.in_a(a33d),.in_b(m4v),.out_a(m7h),.out_b(m7v),.out_c(c7));    
    mac m8(.clk(clk),.rst(rst),.in_a(m7h),.in_b(m5v),.out_a(m8h),.out_b(m8v),.out_c(c8));    
    mac m9(.clk(clk),.rst(rst),.in_a(m8h),.in_b(m6v),.out_a(m9h),.out_b(m9v),.out_c(c9));
    

endmodule

module d_ff(
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

