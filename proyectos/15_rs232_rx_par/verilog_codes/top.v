// Author: Julisa Verdejo Palacios
// Name: top.v
//
// Description: 

module top (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  output  [7:0] dout_o,
  output        pcheck_o,
  output        eor_o
);

  rs232_rx mod_rs232 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .rx_i(rx_i),
    .dout_o(dout_o),
    .pcheck_o(pcheck_o),
    .eor_o(eor_o)
);

endmodule