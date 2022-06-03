`include "triangle.v"
`include "triangle_x.v"
`include "square.v"
`include "parallelogram.v"

module VGA_display_v2(input wire vidon,
                   input wire [10:0] hc,
                   vc,
                   (* dont_touch = "true" *) input wire [7:0] btn,
                   (* dont_touch = "true" *) input wire [3:0] move,
                   input wire rotate,
                   input wire clk,
                   output reg [3:0] red,
                   green,
                   blue);

    wire [7:0] color;

//     the middle one, which right edge are both along axis (h or v)
    triangle U_100(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .btn(btn[4]),
        .move(move),
        .rotate(rotate),
        .color(color[4]),
        .clk(clk)
    );

    // the follows 4 triangle's long edge all are along axis
    // small
   triangle_x U_110(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .sb(0),
        .btn(btn[6]),
        .move(move),
        .rotate(rotate),
        .color(color[6]),
        .clk(clk)
   );

   // small
   triangle_x U_001(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .sb(0),
        .btn(btn[1]),
        .move(move),
        .rotate(rotate),
        .color(color[1]),
        .clk(clk)
   );

   // big
   triangle_x U_010(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .sb(1),
        .btn(btn[2]),
        .move(move),
        .rotate(rotate),
        .color(color[2]),
        .clk(clk)
   );
    
   // big
   triangle_x U_111(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .sb(1),
        .btn(btn[7]),
        .move(move),
        .rotate(rotate),
        .color(color[7]),
        .clk(clk)
   );

   square U_101(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .btn(btn[5]),
        .move(move),
        .color(color[5]),
        .clk(clk)
   );
    
   parallelogram U_011(
        .vidon(vidon),
        .hc(hc),
        .vc(vc),
        .btn(btn[3]),
        .move(move),
        .rotate(rotate),
        .color(color[3]),
        .clk(clk)
   );

    // sum up all the color
    always @(*) begin
        red   = 0;
        green = 0;
        blue  = 0;

        if(vidon) begin
           if (color[4] == 1 || color[5] == 1 || color[6] == 1 || color[7] == 1) 
               red = 4'b1111;
           if (color[2] == 1 || color[3] == 1 || color[6] == 1 || color[7] == 1) 
               green = 4'b1111;
           if (color[1] == 1 || color[3] == 1 || color[5] == 1 || color[7] == 1) 
               blue = 4'b1111;
        end
    end

endmodule //VGA_display_v2