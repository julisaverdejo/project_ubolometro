// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module led_matrix_seq (
  input        rst_i,
  input        clk_i,
  input        button_i,
  output       mosi_o,
  output       sck_o,
  output       cs_o,
  output       eos_o,
  output       count_col_o,
  output       count_row_o
);

  wire start, strdac;
  wire eodac;
  wire z, en;
  wire [1:0] opcol, oprow;
  wire [15:0] din_i;
  wire [1:0] count_col, count_row;

  localparam [28:0] k_i    = 29'd499999999;  // 5 seg
  localparam [28:0] kled_i = 29'd199999999;  // 2 seg
  //localparam [28:0] kled_i = 29'd3;  // 40ns //test
  localparam  [7:0] kmax_i = 8'd8;         // Periodo dclk = 180ns

  localparam  [3:0] ctrl = 4'b0011; // DAC-A


  //localparam [11:0] volbits = 12'b111111111111; //3.3V
  localparam [11:0] volbits = 12'b111010001011; //3V

  assign din_i = {ctrl, volbits};
  
  assign count_col_o = count_col[0];
  assign count_row_o = count_row[0];
 
  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(start)
  );

  fsm_led_matrix mod_fsm_led (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start),
    .eodac_i(eodac),
    .count_row_i(count_row),
    .count_col_i(count_col),
    .z_i(z),
    .stdac_o(strdac),
    .en_o(en),
    .oprow_o(oprow),
    .opcol_o(opcol),
	.eos_o(eos_o)
  );

  spi_write_dac mod_spiw_dac (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .strw_i(strdac),
    .kmax_i(kmax_i),
    .din_i(din_i),
    .mosi_o(mosi_o),
    .sck_o(sck_o),
    .cs_o(cs_o),
    .eow_o(eodac)
);

  timer #(.Width(29)) mod_timer (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(en),
    .k_i(kled_i),
    .z_o(z)
);

  counter_col mod_count_col (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .opc_i(opcol),
    .count_o(count_col)
);

  counter_row mod_count_row (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .opc_i(oprow),
    .count_o(count_row)
);

endmodule