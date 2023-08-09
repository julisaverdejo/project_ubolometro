// Author: Julisa Verdejo Palacios
// Email: julisa.verdejo@gmail.com
// Name: top.v
//
// Description:

module spi_one_ch (    
  input          rst_i,
  input          clk_i,
  input          button_i,
  input          miso_i,
  output         mosi_o,
  output [11:0]  dout_o,
  output         dclk_o,
  output         cs_o,
  output         eoc_o
);

  localparam [7:0] cmd_i = 8'b10010111;
  localparam [28:0] k_i = 29'd499999999;     // 5 seg
  wire start;

  single_tick #(.Width(29)) mod_tick (.rst_i(rst_i), .clk_i(clk_i), .k_i(k_i), .button_i(button_i), .start_o(start));
  
  spi_wr  mod_spi (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .strc_i(start),
    .cmd_i(cmd_i),
    .miso_i(miso_i),
    .mosi_o(mosi_o),
    .dout_o(dout_o),
    .dclk_o(dclk_o),
    .cs_o(cs_o),
    .eoc_o(eoc_o)
  );

endmodule