module clkdiv (input wire mclk,
               input wire clr,
               output wire clk_out);
    
    reg[2:0] q = 0;

    
    // 3位计数器
    always @(posedge mclk or posedge clr) begin
        if (clr == 1)
            q <= 0;
        else 
            q <= q + 1;
    end
    
    assign clk_out = q[0]; // 25MHz
    
endmodule // clkdiv
    
