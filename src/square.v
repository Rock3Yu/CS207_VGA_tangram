module square(
    input wire vidon,
    input wire [10:0] hc,
    vc,
    input wire btn,
    input wire [3:0] move,
    input wire clk,
    output reg color
);

    // @Parameter
    integer h_min = 215; // original of h
    integer v_min = 26;  // original of v
    integer h_max = 1015;
    integer v_max = 626;
    integer size_1   = 100;
    integer size_r2   = 141;

    integer h0, v0;
    integer hc_s, vc_s, btn_s;

    integer cnt_move;

    always@(*) begin
        hc_s = $unsigned(hc);
        vc_s = $unsigned(vc);
        btn_s = $unsigned(btn);
    end

    // Initialization
    initial begin
        h0 = h_min + 600;
        v0 = v_min + 500;
        cnt_move = 0;
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

        // Display of square
        if (vidon == 1) begin
            if (hc_s + vc_s > h0 + v0 - size_1 && hc_s + vc_s < h0 + v0 + size_1 && 
                hc_s - vc_s > h0 - v0 - size_1 && hc_s - vc_s < h0 - v0 + size_1) 
                    color <= 1;
            else color <= 0;
        end else color <= 0;
    end

endmodule // square