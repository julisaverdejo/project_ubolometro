// Author: Julisa Verdejo Palacios
// Name: mux_ch.v
//
// Description: Multiplexor de 2:1 para seleccionar entre ch0-10010111 y ch1-11010111 del ADC.

module mux_dac_ch #(
  parameter Width = 16
) (
  input               selch_i,
  input   [Width-1:0] dcha_i,
  input   [Width-1:0] dchb_i,
  output  [Width-1:0] dout_o
);

  assign dout_o = selch_i ? dchb_i : dcha_i;
endmodule