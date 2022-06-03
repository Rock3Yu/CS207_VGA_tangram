module parallelogram(
    input wire vidon,
    input wire [10:0] hc,
    vc,
    input wire btn,
    input wire [3:0] move,
    input wire rotate,
    input wire clk,
    output reg color
);

    // @Parameter
    integer h_min     = 215; // original of h
    integer v_min     = 26;  // original of v
    integer h_max     = 1015;
    integer v_max     = 626;
    integer size_p5   = 50;
    integer size_p5r2 = 71;
    integer size_1    = 100;

    integer h0, v0;
    integer hc_s, vc_s, btn_s, rotate_s;

    integer cnt_move;
    integer cnt_rotate;
    integer one_s;

    always@(*) begin
        hc_s = $unsigned(hc);
        vc_s = $unsigned(vc);
        btn_s = $unsigned(btn);
        rotate_s = $unsigned(rotate);
    end

    // Initialization
    initial begin
        h0         = h_min + 600;
        v0         = v_min + 200;
        cnt_move   = 0;
        cnt_rotate = 0;
    end

    always @(negedge clk) begin
        // Move along h or v
        if (hc_s == h_min && btn_s == 1) begin
            if ((move[0] == 1 || move[1] == 1 || move[2] == 1 || move[3] == 1) && cnt_move <= 506) 
                cnt_move <= cnt_move + 1;
            else if (move[0] == 1 || move[1] == 1 || move[2] == 1 || move[3] == 1) begin
                cnt_move <= 0;
                if (move[0] == 1 && v0 > v_min + size_1) v0 <= v0 - 1;
                else if (move[1] == 1 && v0 < v_max - size_1) v0 <= v0 + 1;
                else if (move[2] == 1 && h0 > h_min + size_1) h0 <= h0 - 1;
                else if (move[3] == 1 && h0 < h_max - size_1) h0 <= h0 + 1;
            end
        end

        // if rotate in hign e-level, then cnt_rotate += 1;
        if (hc_s == h_min && vc_s == v_min) begin
            if (one_s == 60) begin
                one_s <= 0;
                if (btn_s == 1 && rotate_s == 1) begin
                    if (cnt_rotate == 3) cnt_rotate <= 0;
                    else cnt_rotate <= cnt_rotate + 1;
                end
            end
            else one_s <= one_s + 1;
        end

        // Display of triangle
        if (vidon == 1) begin
            case (cnt_rotate) 
                2'b00:  if (hc_s > h0 - size_p5 && hc_s < h0 + size_p5 &&
                        (hc_s - vc_s) < (h0 - v0) + size_1 && (hc_s - vc_s) > (h0 - v0) - size_1) color <= 1;
                        else color <= 0;
                2'b01:  if (vc_s > v0 - size_p5r2 && vc_s < v0 + size_p5r2 &&
                        (hc_s + vc_s) > (h0 + v0) - size_p5r2 && (hc_s + vc_s) < (h0 + v0) + size_p5r2) color <= 1;
                        else color <= 0;
                2'b10:  if (vc_s > v0 - size_p5 && vc_s < v0 + size_p5 &&
                        (hc_s + vc_s) > (h0 + v0) - size_1 && (hc_s + vc_s) < (h0 + v0) + size_1) color <= 1;
                        else color <= 0;
                2'b11:  if (vc_s > v0 - size_p5r2 && vc_s < v0 + size_p5r2 &&
                        (hc_s - vc_s) > (h0 - v0) - size_p5r2 &&(hc_s - vc_s) < (h0 - v0) + size_p5r2) color <= 1;
                        else color <= 0;
                default: color <= 0;
            endcase
        end
        else color <= 0;
    end

endmodule // triangle_x
