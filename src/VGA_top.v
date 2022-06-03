`include "VGA_800x600.v"
`include "VGA_display_v2.v"
`include "Binary_To_7Segment.v"
`include "Binary_To_7Segments.v"

module VGA_top (input wire mclk,
                (* dont_touch = "true" *) input wire [7:0] btn,
                (* dont_touch = "true" *) input wire [3:0] move,
                input wire rotate,
                output wire hsync,
                vsync,
                output wire [3:0] red,
                green,
                blue,
                output wire [7:0] lights,
                output      o_Segment_A,
   output      o_Segment_B,
   output      o_Segment_C,
   output      o_Segment_D,
   output      o_Segment_E,
   output      o_Segment_F,
   output      o_Segment_G,
   output [1:0] digit_cath,
   output      Segment_A,
   output      Segment_B,
   output      Segment_C,
   output      Segment_D,
   output      Segment_E,
   output      Segment_F,
   output      Segment_G
                );
    
    wire clk_out, clr, vidon;
    wire [10:0] hc, vc;
    assign clr = btn[0];
    assign lights = btn;
    
    clk_wiz_0 U1(
    .clk_in1(mclk),//100MHz
    .clk_out1(clk_out)//40MHz
    );
    
    VGA_800x600 U2(
    .clk(clk_out),
    .clr(clr),
    .hsync(hsync),
    .vsync(vsync),
    .hc(hc),
    .vc(vc),
    .vidon(vidon)
    );
    
    VGA_display_v2 U3(
    .vidon(vidon),
    .hc(hc),
    .vc(vc),

    .red(red),
    .green(green),
    .blue(blue),
    
    .btn(btn),
    .move(move),
    .rotate(rotate),
    .clk(clk_out)
    );

    Binary_To_7Segment U4(
        .i_Clk(clk_out),
        .move(move),
        .rotate(rotate),
        .o_Segment_A(o_Segment_A),
        .o_Segment_B(o_Segment_B),
        .o_Segment_C(o_Segment_C),
        .o_Segment_D(o_Segment_D),
        .o_Segment_E(o_Segment_E),
        .o_Segment_F(o_Segment_F),
        .o_Segment_G(o_Segment_G),
        .digit_cath(digit_cath[0])
    );
    Binary_To_7Segments U5(
        .i_Clk(clk_out),
        .i_Binary_Num(btn),
        .Segment_A(Segment_A),
        .Segment_B(Segment_B),
        .Segment_C(Segment_C),
        .Segment_D(Segment_D),
        .Segment_E(Segment_E),
        .Segment_F(Segment_F),
        .Segment_G(Segment_G),
        .digit_cath(digit_cath[1])
    );
endmodule // VGA_top