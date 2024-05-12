// Author: Julisa Verdejo Palacios
// Name: spi_write.v
//
// Description: Instanciacion de todos los modulos utilizados para la escritura.

module nxm_matrix_1val (
  input         rst_i,
  input         clk_i,
  input         button_i,
  input         miso_adc_i,
  output        mosi_dac_o,
  output        dclk_o,
  output        cs_dac_o,
  output        mosi_adc_o,
  output        sck_o,
  output        cs_adc_o,
  output [11:0] dout_o,
  output        count_col_o,
  output        count_row_o,
  output        eos_o
);

  wire start;
  wire eodac, eoadc;
  wire stdac, stadc;
  wire z, en;
  wire [1:0] count_row, count_col;
  wire [1:0] oprow, opcol;  
  
  // Configuraciones single tick
  //localparam [28:0] k_i = 29'd499999999;  // 5 seg
  localparam [28:0] k_i = 29'd39;  // 400ns
  
  //Configuraciones timer
  //localparam [28:0] kt_i = 29'd199999999;
  localparam [28:0] kt_i = 29'd19; //200ns
  
  //Configuraciones DAC
  localparam  [3:0] ctrl = 4'b0011; // DAC-A
  localparam  [7:0] kmax_dac = 8'd8; //180ns
  localparam [11:0] volbits = 12'b100110110010; //2V
  localparam [15:0] din_i = {ctrl,volbits};
  
  //Configuraciones ADC
  localparam [7:0] cmd_i = 8'b10010111; //Ch0
  localparam [7:0] kmax_adc = 8'd59; // Periodo dclk = 1200ns
  
  
  assign count_col_o = count_col[0];
  assign count_row_o = count_row[0];
  
 
  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(start)
  );

  fsm_nxm_matrix_1val  mod_fsm_nxm_matrix_1val (
    .rst_i(rst_i),
    .clk_i(clk_i),
	.start_i(start),
	.eodac_i(eodac),
	.eoadc_i(eoadc),
	.count_row_i(count_row),
	.count_col_i(count_col),
	.z_i(z),
	.stdac_o(stdac),
	.stadc_o(stadc),
	.en_o(en),
	.oprow_o(oprow),
	.opcol_o(opcol),
	.eos_o(eos_o)
  );
  
  spi_write_dac  mod_spi_write_dac (
    .rst_i(rst_i),
    .clk_i(clk_i),
	.strw_i(stdac),
	.kmax_i(kmax_dac),
	.din_i(din_i),
	.mosi_o(mosi_dac_o),
	.sck_o(sck_o),
	.cs_o(cs_dac_o),
	.eow_o(eodac)
  ); 
	
  spi_wr_adc  mod_spi_wr_adc (
    .rst_i(rst_i),
    .clk_i(clk_i),
	.strc_i(stadc),
	.cmd_i(cmd_i),
	.kmax_i(kmax_adc),
	.miso_i(miso_adc_i),
	.mosi_o(mosi_adc_o),
	.dout_o(dout_o),
	.dclk_o(dclk_o),
	.cs_o(cs_adc_o),
	.eoc_o(eoadc)
  );  
  
  timer #(.Width(29)) mod_timer (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(en),
    .k_i(kt_i),
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