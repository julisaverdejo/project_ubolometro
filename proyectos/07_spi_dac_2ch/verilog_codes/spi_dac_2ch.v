// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module spi_dac_2ch (
  input         rst_i,
  input         clk_i,
  input         button_i,
  output        mosi_o,
  output        sck_o,
  output        cs_o,
  output        eod_o,
  //
  output      mosi_c,
  output      sck_c,
  output      cs_c
);

  wire start, strw, eow, selch;
  wire [15:0] dcha_i, dchb_i;
  wire [15:0] data;

  localparam [28:0] k_i   = 29'd499999999;  // 5 seg
  localparam  [7:0] kmax_i = 8'd7;         // Periodo dclk = 160ns

  localparam  [3:0] ctrla = 4'b0011; // DAC-A
  localparam  [3:0] ctrlb = 4'b1011; // DAC-B

  //localparam [11:0] volbits = 12'b111111111111; //3.3V
  localparam [11:0] volbitsa = 12'b010011011001; //1V
  localparam [11:0] volbitsb = 12'b100110110010; //2V
  //localparam [11:0] volbitsb = 12'b100000000000; //1.65V
  //localparam [11:0] volbitsa = 12'b001001101101; //0.5V

  assign dcha_i = {ctrla, volbitsa};
  assign dchb_i = {ctrlb, volbitsb};

  assign mosi_c = mosi_o;
  assign sck_c = sck_o;
  assign cs_c = cs_o;

  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(start)
  );

  fsm_2ch mod_fsm_2ch (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start),
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