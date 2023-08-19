// Author: Julisa Verdejo Palacios
// Name: mux_ch.v
//
// Description: Multiplexor de 2:1 para seleccionar entre ch0-10010111 y ch1-11010111 del ADC.

module mux_ch #(
  parameter Width = 8
) (
  input             [1:0] sel_i,
  input       [Width-1:0] ch0_i,
  input       [Width-1:0] ch1_i,
  input       [Width-1:0] ch2_i,
  input       [Width-1:0] ch3_i,
  output reg  [Width-1:0] cmd_o
);


  always @ (sel_i, ch0_i, ch1_i, ch2_i, ch3_i) begin
    case(sel_i)
      2'b00:   cmd_o = ch0_i;
      2'b01:   cmd_o = ch1_i;
      2'b10:   cmd_o = ch2_i;
      2'b11:   cmd_o = ch3_i;
      default: cmd_o =  ch0_i;
    endcase
  end

endmodule