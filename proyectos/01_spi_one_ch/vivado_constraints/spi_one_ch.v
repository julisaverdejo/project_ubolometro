// Author: Julisa Verdejo Palacios
// Name: spi_one_ch.v
//
// Description: Prueba de funcionamiento de spi con push debouncer 

module spi_one_ch (    
  input          rst_i,
  input          clk_i,
  input          button_i,
  input          miso_i,
  output         mosi_o,
  output [11:0]  dout_o,
  output         dclk_o,
  output         cs_o,
  output         eoc_o,
  //
  output         miso_c,
  output         mosi_c,
  output         dclk_c,
  output         cs_c  
);

  localparam  [7:0] cmd_i = 8'b10010111; //ch0        //ch1 - 8'b11010111;
  localparam [28:0] k_i   = 29'd499999999;     // 5 seg
  localparam  [7:0] kmax_i = 8'd39;           //velocidad spi 800ns
  wire start;

  assign miso_c = miso_i;
  assign mosi_c = mosi_o;
  assign dclk_c = dclk_o;
  assign cs_c = cs_o;
    
  single_tick #(.Width(29)) mod_tick (.rst_i(rst_i), .clk_i(clk_i), .k_i(k_i), .button_i(button_i), .start_o(start));
  
  spi_wr mod_spi (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .strc_i(start),
    .cmd_i(cmd_i),
    .kmax_i(kmax_i),
    .miso_i(miso_i),
    .mosi_o(mosi_o),
    .dout_o(dout_o),
    .dclk_o(dclk_o),
    .cs_o(cs_o),
    .eoc_o(eoc_o)
  );

endmodule