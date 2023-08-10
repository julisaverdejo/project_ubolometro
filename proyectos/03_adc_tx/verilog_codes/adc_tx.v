// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module adc_tx (
  input  rst_i,
  input  clk_i,
  input  button_i,
  input  miso_i,
  output mosi_o,
  output dclk_o,
  output cs_o,
  output tx_o,
  output eos_o
);

  localparam  [7:0] cmd_i = 8'b10010111;
  localparam [28:0] k_i   = 29'd499999999;  // 5 seg
  localparam  [7:0] kmax_i = 8'd39;         // Periodo dclk = 800ns
  localparam [14:0] baud = 15'd10415;
  localparam        psel = 1'b0;

  wire sts, strc, st;
  wire eoc, eot, sel;

  wire [11:0] dout_o;
  wire [7:0] dmsb, dlsb, data;

  assign dmsb = {4'b0000, dout_o[11:8]};
  assign dlsb = dout_o[7:0];

  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(sts)
  );

  fsm_adc_tx mod_fsm_adc_tx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .sts_i(sts),
    .eoc_i(eoc),
    .eot_i(eot),
    .sel_o(sel),
    .strc_o(strc),
    .st_o(st),
    .eos_o(eos_o)
  );

  spi_wr mod_spi_wr (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .strc_i(strc),
    .cmd_i(cmd_i),
    .kmax_i(kmax_i),
    .miso_i(miso_i),
    .mosi_o(mosi_o),
    .dout_o(dout_o),
    .dclk_o(dclk_o),
    .cs_o(cs_o),
    .eoc_o(eoc)
  );

  mux_ch #(.Width(8)) mod_mux_ch (
    .sel_i(sel),
    .dmsb_i(dmsb),
    .dlsb_i(dlsb),
    .data_o(data)
  );

  rs232_tx #(.Width(15)) mod_rs232_tx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .st_i(st),
    .d_i(data),
    .baud_i(baud),
    .psel_i(psel),
    .tx_o(tx_o),
    .eot_o(eot)
  );

endmodule