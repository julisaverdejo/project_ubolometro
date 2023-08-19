// Author: Julisa Verdejo Palacios
// Email: julisa.verdejo@gmail.com
// Name: top.v
// 
// Description:

module spi_adc_4ch (
  input          rst_i,
  input          clk_i,
  input          button_i,
  input          miso_i,
  output         mosi_o,
  output         dclk_o,
  output         cs_o,
  output         eos_o,
  //output [11:0]  doutch0_o,
  //output [11:0]  doutch1_o,
  //output [11:0]  doutch2_o,
  //output [11:0]  doutch3_o,
  //
  output         miso_c,
  output         mosi_c,
  output         dclk_c,
  output         cs_c  
);

  localparam  [7:0] ch0_i = 8'b10010111;
  localparam  [7:0] ch1_i = 8'b11010111;
  localparam  [7:0] ch2_i = 8'b10100111;
  localparam  [7:0] ch3_i = 8'b11100111;
  localparam  [7:0] kmax_i = 8'd39;         // Periodo dclk = 800ns 
  localparam [28:0] k_i = 29'd499999999;
  
  wire start, strc;
  wire eoc,h0, h1, h2, h3;
  wire  [1:0] sel;
  wire  [7:0] cmd;
  wire [11:0] data;
  
  wire [11:0]  doutch0_o;
  wire [11:0]  doutch1_o;
  wire [11:0]  doutch2_o;
  wire [11:0]  doutch3_o;  
  
  assign miso_c = miso_i;
  assign mosi_c = mosi_o;
  assign dclk_c = dclk_o;
  assign cs_c = cs_o;

  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(start)
);

  fsm_master mod_fsm_master (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .stm_i(start),
    .eoc_i(eoc),
    .st_o(strc),
    .sel_o(sel),
    .h0_o(h0),
    .h1_o(h1),
    .h2_o(h2),
    .h3_o(h3),
    .eos_o(eos_o)
);

  mux_ch #(.Width(8)) mod_mux_ch (
    .sel_i(sel),
    .ch0_i(ch0_i),
    .ch1_i(ch1_i),
    .ch2_i(ch2_i),
    .ch3_i(ch3_i),
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

  pipo_reg #(.Width(12)) mod_pipo0 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(h0),
    .din_i(data),
    .dout_o(doutch0_o)
);

  pipo_reg #(.Width(12)) mod_pipo1 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(h1),
    .din_i(data),
    .dout_o(doutch1_o)
);  

  pipo_reg #(.Width(12)) mod_pipo2 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(h2),
    .din_i(data),
    .dout_o(doutch2_o)
);  

  pipo_reg #(.Width(12)) mod_pipo3 (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(h3),
    .din_i(data),
    .dout_o(doutch3_o)
);  

endmodule