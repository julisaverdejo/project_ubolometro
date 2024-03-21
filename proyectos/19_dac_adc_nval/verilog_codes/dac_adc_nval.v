// Author: Julisa Verdejo Palacios
// Name: spi_write.v
//
// Description: Instanciacion de todos los modulos utilizados para la escritura.

module dac_adc_nval (
  input         rst_i,
  input         clk_i,
  input         start_i,
  input         miso_adc_i,
  output        mosi_dac_o,
  output        dclk_o,
  output        cs_dac_o,
  output        mosi_adc_o,
  output        sck_o,
  output        cs_adc_o,
  output [11:0] dout_o,
  output        eoconv_o
);

  wire eodac, eoadc;
  wire stdac, stadc;
  wire z, en, flag;
  wire [1:0] opc1, opc2;
  wire [11:0] volbits;
  
  //localparam [28:0] k_i = 29'd499999999;  // 5 seg
  localparam [28:0] k_i = 29'd39;  // 400ns
  
  //Configuraciones DAC
  localparam  [3:0] ctrl = 4'b0011; // DAC-A
  localparam  [7:0] kmax_dac = 8'd7; //160ns
  //localparam [11:0] volbits = 12'b100110110010; //2V
  //localparam [15:0] din_i = {ctrl,volbits};
  
  //Configuraciones ADC
  localparam cmd_i = 8'b10010111; //Ch0
  localparam  [7:0] kmax_adc = 8'd39; // Periodo dclk = 800ns
  
  fsm_dac_adc  mod_fsm_dac_adc (
    .rst_i(rst_i),
    .clk_i(clk_i),
	.start_i(start_i),
	.eodac_i(eodac),
	.eoadc_i(eoadc),
	.z_i(z),
	.flag_i(flag),
	.stdac_o(stdac),
	.stadc_o(stadc),
	.opc1_o(opc1),
	.opc2_o(opc2),
	.en_o(en),
	.eoconv_o(eoconv_o)
  );
  
  spi_write_dac  mod_spi_write_dac (
    .rst_i(rst_i),
    .clk_i(clk_i),
	.strw_i(stdac),
	.kmax_i(kmax_dac),
	.din_i({ctrl,volbits}),
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
  
  timer         #(.Width(29)) mod_timer     (.rst_i(rst_i), .clk_i(clk_i), .k_i(k_i), .en_i(en), .z_o(z));
  
  counter_volts #(.Width(12)) mod_cnt_volts (.rst_i(rst_i), .clk_i(clk_i), .opc1_i(opc1), .count_o(volbits));
  
  counter_steps #(.Width(7))  mod_cnt_steps (.rst_i(rst_i), .clk_i(clk_i), .opc2_i(opc2), .flag_o(flag));


endmodule