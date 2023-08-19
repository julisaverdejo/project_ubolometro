// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module spi_dac_2ch (
  input         rst_i,
  input         clk_i,
  input         start_i,
  input  [11:0] rom_i,
  input   [7:0] kmax_i,
  output        mosi_o,
  output        sck_o,
  output        cs_o,
  output        eod_o
  //
  //output        mosi_c,
  //output        sck_c,
  //output        cs_c
);

  wire strw, eow, selch;
  wire [15:0] dcha_i, dchb_i;
  wire [15:0] data;

  //localparam  [7:0] kmax_i = 8'd7;         // Periodo dclk = 160ns

  localparam  [3:0] ctrla = 4'b0011; // DAC-A
  localparam  [3:0] ctrlb = 4'b1011; // DAC-B


  assign dcha_i = {ctrla, rom_i};
  assign dchb_i = {ctrlb, rom_i};

  //assign mosi_c = mosi_o;
  //assign sck_c = sck_o;
  //assign cs_c = cs_o;


  fsm_2ch mod_fsm_2ch (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start_i),
    .eow_i(eow),
    .strw_o(strw),
    .selch_o(selch),
    .eod_o(eod_o)
);

  mux_dac_ch #(.Width(16)) mod_mux_dac(
    .selch_i(selch),
    .dcha_i(dcha_i),
    .dchb_i(dchb_i),
    .dout_o(data)
);

  spi_write_dac mod_spiw_dac (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .strw_i(strw),
    .kmax_i(kmax_i),
    .din_i(data),
    .mosi_o(mosi_o),
    .sck_o(sck_o),
    .cs_o(cs_o),
    .eow_o(eow)
);

endmodule