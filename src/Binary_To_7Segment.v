module Binary_To_7Segment
  (
   input       i_Clk,
   input wire [3:0] move,
   input wire rotate,
   output      o_Segment_A,
   output      o_Segment_B,
   output      o_Segment_C,
   output      o_Segment_D,
   output      o_Segment_E,
   output      o_Segment_F,
   output      o_Segment_G,
   output [0:0] digit_cath
   );
 
  reg [6:0]    r_Hex_Encoding = 7'h00;
   
  // Purpose: Creates a case statement for all possible input binary numbers.
  // Drives r_Hex_Encoding appropriately for each input combination.
  always @(posedge i_Clk)
    begin
      case (move)
        4'b0001 : r_Hex_Encoding <= 7'h3e;//up
        4'b0010 : r_Hex_Encoding <= 7'h5e;//down
        4'b0100 : r_Hex_Encoding <= 7'h38;//left
        4'b1000 : r_Hex_Encoding <= 7'h31;//right
        //5'b10000 : r_Hex_Encoding <= 7'h49;//spin
      endcase
      case(rotate)
      1'b1:r_Hex_Encoding<=7'h49;
      endcase
    end 
    reg segcath_holdtime;
    always @ (posedge i_Clk)
    
    begin

    segcath_holdtime<=~segcath_holdtime;
    end 
    assign digit_cath={segcath_holdtime};

  // r_Hex_Encoding[7] is unused
  assign o_Segment_A = r_Hex_Encoding[0];
  assign o_Segment_B = r_Hex_Encoding[1];
  assign o_Segment_C = r_Hex_Encoding[2];
  assign o_Segment_D = r_Hex_Encoding[3];
  assign o_Segment_E = r_Hex_Encoding[4];
  assign o_Segment_F = r_Hex_Encoding[5];
  assign o_Segment_G = r_Hex_Encoding[6];
 
endmodule // Button_To_7Segment