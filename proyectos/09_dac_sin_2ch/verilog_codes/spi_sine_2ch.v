// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module spi_sine_2ch (
  input         rst_i,
  input         clk_i,
  input         sts_i,
  output        mosi_o,
  output        sck_o,
  output        cs_o,
  output        end_o,
  //
  output        mosi_c,
  output        sck_c,
  output        cs_c
);

  wire  [1:0] opc;
  wire [11:0] drom;
  wire [9:0] addr;
  wire start, eod;

  localparam  [7:0] kmax_i = 8'd7;  // Periodo dclk = 160ns

  assign mosi_c = mosi_o;
  assign sck_c = sck_o;
  assign cs_c = cs_o;


  fsm_sin mod_fsm_sin (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(sts_i),
    .cnt_i(addr),
    .eow_i(eod),
    .opc_o(opc),
    .strw_o(start),
    .end_o(end_o)
);

  rom_sin #(.Width(12)) mod_rom (
    .addr_i(addr),
    .dout_o(drom)
);

counter #(.Width(10)) mod_counter (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .opc_i(opc),
    .cnt_o(addr)
);

  spi_dac_2ch mod_spi_2ch (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start),
    .rom_i(drom),
    .kmax_i(kmax_i),
    .mosi_o(mosi_o),
    .sck_o(sck_o),
    .cs_o(cs_o),
    .eod_o(eod)
);

endmodule