// Author: Julisa Verdejo Palacios
// Email: julisa.verdejo@gmail.com
// Name: top.v
// 
// Description:

module spi_two_ch (    
  input          rst_i,
  input          clk_i,
  input          stm_i,
  input          miso_i,
  input   [7:0]  ch0_i,
  input   [7:0]  ch1_i,
  input   [7:0]  kmax_i,
  output         mosi_o,
  output         dclk_o,
  output         cs_o,
  output         eos_o,
  output [11:0]  doutch0_o,
  output [11:0]  doutch1_o
  //
 // output         miso_c,
 // output         mosi_c,
 // output         dclk_c,
 // output         cs_c
);

//  localparam  [7:0] ch0_i = 8'b10010111;
//  localparam  [7:0] ch1_i = 8'b11010111;  
//  localparam [28:0] k_i   = 29'd499999999;  // 5 seg
//  localparam  [7:0] kmax_i = 8'd39;         // Periodo dclk = 800ns
  
  wire strc;
  wire eoc, sel, h1, h2;
  wire  [7:0] cmd;
  wire [11:0] data;

  //assign miso_c = miso_i;
  //assign mosi_c = mosi_o;
  //assign dclk_c = dclk_o;
  //assign cs_c = cs_o;


  fsm_adc_2ch mod_fsm_adc_2ch (
    .rst_i(rst_i),
    .clk_i(clk_i),    
    .stm_i(stm_i),
    .eoc_i(eoc),
    .strc_o(strc),
    .sel_o(sel),
    .h1_o(h1),
    .h2_o(h2),
    .eos_o(eos_o)
);

  mux_ch #(.Width(8)) mod_mux_ch (
    .sel_i(sel),
    .ch0_i(ch0_i),
    .ch1_i(ch1_i),
    .cmd_o(cmd)
);

  spi_wr mod_spi (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .strc_i(strc),
    .cmd_i(cmd),
    .kmax_i(kmax_i),
    .miso_i(miso_i),
    .mosi_o(mosi_o),
    .dout_o(data),
    .dclk_o(dclk_o),
    .cs_o(cs_o),
    .eoc_o(eoc)
  );

  pipo_reg #(.Width(12)) mod_pipo1 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(h1),
    .din_i(data),
    .dout_o(doutch0_o)
);

  pipo_reg #(.Width(12)) mod_pipo2 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(h2),
    .din_i(data),
    .dout_o(doutch1_o)
);  

endmodule