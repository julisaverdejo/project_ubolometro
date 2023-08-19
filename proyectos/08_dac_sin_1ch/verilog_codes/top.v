// Author: Julisa Verdejo Palacios
// Name: top.v
//
// Description: Multiplexor de 2:1 para seleccionar entre ch0-10010111 y ch1-11010111 del ADC.
module top (
  input   rst_i,
  input   clk_i,
  input   start_i,
  output  mosi_o,
  output  sck_o,
  output  cs_o,
  output  end_o
);


  spi_dac_sin mod_spi_dac (
    .rst_i(~rst_i),
    .clk_i(clk_i),
    .start_i(start_i),
    .mosi_o(mosi_o),
    .sck_o(sck_o),
    .cs_o(cs_o),
    .end_o(end_o)
);

endmodule