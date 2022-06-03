module VGA_stripes_v2(input wire vidon,
                      input wire [10:0] hc,
                      vc,
                      output reg [3:0] red,
                      green,
                      output reg [3:0] blue);
    
    reg [2:0] RGB = 3'b000; // 0-7
    
    always @(*) begin
        red = 0;
        green = 0;
        blue = 0;

        if (vidon == 1) begin
            if (hc > 215 && hc < 316) RGB       = 3'b000;
            else if (hc > 315 && hc < 416) RGB  = 3'b111;
            else if (hc > 415 && hc < 516) RGB  = 3'b100;
            else if (hc > 515 && hc < 616) RGB  = 3'b010;
            else if (hc > 615 && hc < 716) RGB  = 3'b001;
            else if (hc > 715 && hc < 816) RGB  = 3'b011;
            else if (hc > 815 && hc < 916) RGB  = 3'b101;
            else if (hc > 915 && hc < 1016) RGB = 3'b110;
            
            red   = {RGB[2],RGB[2],RGB[2],RGB[2]};
            green = {RGB[1],RGB[1],RGB[1],RGB[1]};
            blue  = {RGB[0],RGB[0],RGB[0],RGB[0]};
        end
    end
    
endmodule // VGA_stripes_v2
