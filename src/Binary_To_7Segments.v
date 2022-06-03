module Binary_To_7Segments
  (
   input       i_Clk,
   input [7:0] i_Binary_Num,
   output      Segment_A,
   output      Segment_B,
   output      Segment_C,
   output      Segment_D,
   output      Segment_E,
   output      Segment_F,
   output      Segment_G,
   output [0:0] digit_cath
   );
 
  reg [6:0]    Hex_Encoding = 7'h00;
   
  // Purpose: Creates a case statement for all possible input binary numbers.
  // Drives Hex_Encoding appropriately for each input combination.
  always @(posedge i_Clk)
    begin
      case (i_Binary_Num)
        8'b00000001 : Hex_Encoding <= 7'h3f;//0
        8'b00000010 : Hex_Encoding <= 7'h06;
        8'b00000100 : Hex_Encoding <= 7'h5b;
        8'b00001000 : Hex_Encoding <= 7'h4f;
        8'b00010000 : Hex_Encoding <= 7'h66;          
        8'b00100000 : Hex_Encoding <= 7'h6d;
        8'b01000000 : Hex_Encoding <= 7'h7d;
        8'b10000000 : Hex_Encoding <= 7'h07;
        // 8'b1000 : Hex_Encoding <= 7'h7f;//8
      endcase
    end 
    reg segcath_holdtime;
    always @ (posedge i_Clk)
    
    begin

    segcath_holdtime<=~segcath_holdtime;
    end 
    assign digit_cath={segcath_holdtime};

  // Hex_Encoding[7] is unused
  assign Segment_A = Hex_Encoding[0];
  assign Segment_B = Hex_Encoding[1];
  assign Segment_C = Hex_Encoding[2];
  assign Segment_D = Hex_Encoding[3];
  assign Segment_E = Hex_Encoding[4];
  assign Segment_F = Hex_Encoding[5];
  assign Segment_G = Hex_Encoding[6];
 
endmodule // Binary_To_7Segments