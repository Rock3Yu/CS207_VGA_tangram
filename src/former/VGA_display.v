module VGA_display(input wire vidon,
                   input wire [10:0] hc,
                   vc,
                   input wire [7:0] btn,
                   input wire [3:0] move,
                   output reg [3:0] red,
                   green,
                   blue);
    
    parameter [9:0] size_1   = 100;
    parameter [9:0] size_r2  = 141;
    parameter [9:0] size_2   = 200;
    parameter [9:0] size_2r2 = 283;
    parameter [9:0] size_4   = 400;
    
    parameter [9:0] ori_pos_h = 215; // original of h
    parameter [9:0] ori_pos_v = 26;  // original of v

    reg [9:0] pos_trian_h;
    reg [9:0] pos_trian_v;
    // reg [9:0] pos_square_h;
    // reg [9:0] pos_square_v;
    // reg [9:0] pos_circle_h;
    // reg [9:0] pos_circle_v;

    reg [3:0] cnt;
    
    initial begin
        cnt = 0;
        pos_trian_h = ori_pos_h + 100;
        pos_trian_v = ori_pos_v + 100;
    end

  always @(*) begin
      if (hc == 666) begin
          if (move[0] == 1 && move[1] == 1 && move[2] == 1 || move[3] == 1) cnt <= cnt + 1;
        end
      if (cnt == 4'b1111) begin
          if (move[0] == 1) pos_trian_h <= pos_trian_h - 1;
          else if (move[1] == 1) pos_trian_h <= pos_trian_h + 1;
          else if (move[2] == 1) pos_trian_v <= pos_trian_v - 1;
          else if (move[3] == 1) pos_trian_v <= pos_trian_v + 1;
      end
  end
    
    always @(*) begin
        red   = 0;
        green = 0;
        blue  = 0;
        
        if (vidon == 1) begin
            // triangle
            if (hc + vc < (pos_trian_h + pos_trian_v + size_1)
                && hc > pos_trian_h && vc > pos_trian_v) red = 4'b1111;
            
            // square
            if (hc > 525 && hc < 625 && vc > 126 && vc < 226) green = 4'b1111;
            
            // circle
            if ((hc - 815) * (hc - 815) + (vc - 226) * (vc - 226) < size_1 * size_1) blue = 4'b1111;
                end
            
            
        end
        
        endmodule // VGA_display
