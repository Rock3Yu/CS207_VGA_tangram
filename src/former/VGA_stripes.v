module VGA_stripes(input wire vidon,
                   input wire [10:0] hc,
                   vc,
                   output reg [3:0] red,
                   green,
                   output reg [3:0] blue);
    
    // 输出16行宽的红绿条wen
    
    always @(*) begin
        red   = 0;
        green = 0;
        blue  = 0;
        
        if (vidon == 1) begin
        red   = {vc[4],vc[4],vc[4],vc[4]};
        green = ~{vc[4],vc[4],vc[4],vc[4]};
        end
    end
    
endmodule // VGA_stripes
