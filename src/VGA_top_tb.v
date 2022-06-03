`timescale 1ns / 1ps
`include "VGA_top.v"

module VGA_top_tb();
    reg smclk;
    reg [7:0] sbtn;
    reg [3:0] smove;
    reg srotate;
    wire shsync, svsync;
    wire [3:0] sred, sgreen, sblue;
    
    VGA_top U(smclk, sbtn, smove, srotate, shsync, svsync, sred, sgreen, sblue);
    
    initial begin
        $dumpfile("VGA_top_tb.vcd");
        $dumpvars;
        smclk  = 0;
        sbtn   = 0;
        smove  = 0;
        srotate = 0;
        repeat(100000) # 5 smclk = ~smclk;
        # 5 sbtn = 16;
        # 5 smove = 1;
        # 5 srotate = 1;
        # 5000 srotate = 0;
        repeat(100000000) # 5 smclk = ~smclk;
        
        repeat(100000) # 5 smclk = ~smclk;

        
        # 10 $finish;
    end
endmodule // VGA_top_tb
