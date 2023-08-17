// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module spi_dac_sin (
  input         rst_i,
  input         clk_i,
  input         start_i,
  output        mosi_o,
  output        sck_o,
  output        cs_o,
  output        end_o,
  //
  output      mosi_c,
  output      sck_c,
  output      cs_c
);

  wire strw, eow;
  wire [1:0] opc;
  wire [15:0] data;
  wire [11:0] dsin;
  wire [9:0] addr;

  localparam  [7:0] kmax_i = 8'd7;         // Periodo dclk = 100ns
  localparam  [3:0] ctrl = 4'b1011; // DAC-A

  assign data = {ctrl, dsin};

  assign mosi_c = mosi_o;
  assign sck_c = sck_o;
  assign cs_c = cs_o;

  counter #(.Width(10)) mod_counter (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .opc_i(opc),
    .cnt_o(addr)
);

  fsm_sin mod_fsm_sin (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start_i),
    .cnt_i(addr),
    .eow_i(eow),
    .opc_o(opc),
    .strw_o(strw),
    .end_o(end_o)
);

  rom_sin #(.Width(12)) mod_rom (
    .addr_i(addr),
    .dout_o(dsin)
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