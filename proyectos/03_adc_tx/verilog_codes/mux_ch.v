// Author: Julisa Verdejo Palacios
// Name: mux_ch.v
//
// Description: Multiplexor de 2:1 para seleccionar entre ch0-10010111 y ch1-11010111 del ADC.

module mux_ch #(
  parameter Width = 8
) (
  input               sel_i,
  input   [Width-1:0] dmsb_i,
  input   [Width-1:0] dlsb_i,
  output  [Width-1:0] data_o
);

  assign data_o = sel_i ? dlsb_i : dmsb_i;
endmodule