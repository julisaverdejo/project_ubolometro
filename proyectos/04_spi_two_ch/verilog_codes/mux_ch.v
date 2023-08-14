// Author: Julisa Verdejo Palacios
// Name: mux_ch.v
//
// Description: Multiplexor de 2:1 para seleccionar entre ch0-10010111 y ch1-11010111 del ADC.

module mux_ch #(
  parameter Width = 8
) (
  input               sel_i,
  input   [Width-1:0] ch0_i,
  input   [Width-1:0] ch1_i,
  output  [Width-1:0] cmd_o
);

  assign cmd_o = sel_i ? ch1_i : ch0_i;
endmodule