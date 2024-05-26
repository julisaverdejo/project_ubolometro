// Author: Julisa Verdejo Palacios
// Name: spi_write.v
//
// Description: Instanciacion de todos los modulos utilizados para la escritura.

module data_acq_sys (
  input   rst_i,
  input   clk_i,
  input   button_i,
  input   miso_adc_i,
  output  mosi_dac_o,
  output  dclk_o,
  output  cs_dac_o,
  output  mosi_adc_o,
  output  sck_o,
  output  cs_adc_o,
  output  tx_o,
  output  eos_o
);
    
  wire start;
  wire tick;
  wire eodac, eoadc, eotx;
  wire stdac, stadc, stx;
  wire we, sel, flag;
  wire [4:0] addr, count;
  wire [1:0] oprom, opram;
  wire [11:0] romout, dataram, doutram;
  wire [7:0] dmsb, dlsb, data; 
  
  // Configuraciones single tick
  localparam [28:0] k_i = 29'd499999999;  // 5s
  //localparam [28:0] k_i = 29'd39;  // 400ns
  
  //Configuraciones timer settling
  //localparam [28:0] kset_i = 29'd499; // 5us  
  localparam [28:0] kset_i = 29'd739; // 7.4us
  //localparam [28:0] kset_i = 29'd799; // 8us 
  //localparam [28:0] kt_i = 29'd19; //200ns
  
  //Configuraciones DAC
  localparam  [3:0] ctrl = 4'b0011; // DAC-A
  localparam  [7:0] kmax_dac = 8'd8; //180ns
  
  //Configuraciones ADC
  localparam [7:0] cmd_i = 8'b10010111; //Ch0
  localparam [7:0] kmax_adc = 8'd59; // Periodo dclk = 1200ns
 
 //Configuraciones RS232_TX
  assign dmsb = {4'b0000, doutram[11:8]};
  assign dlsb = doutram[7:0];  
 
 
  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(start)
  );

  fsm_daq  mod_fsm_daq (
    .rst_i(rst_i),
    .clk_i(clk_i),
	.start_i(start),
	.eodac_i(eodac),
	.eoadc_i(eoadc),
	.eotx_i(eotx),
	.flag_i(flag)
	.set_i(set),
	.stdac_o(stdac),
	.stadc_o(stadc),
	.stx_o(stx),
	.enset_o(enset),
	.opc1_o(oprom),
	.opc2_o(opram),
	.we_o(we),
	.sel_o(sel),
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

  mod_n_counter #(
    .Width(6),
	.MaxVal(53)
  ) mod_mod_n_counter (
    .clk_i(clk_i),
	.rst_i(rst_i),
	.max_tick(tick)
  );
  
  transmitter #(
    .Nbits(8),
	.Sticks(16)
  ) mod_transmitter (
    .clk_i(clk_i),
	.rst_i(rst_i),
	.stt_i(stx),
	.tick_i(tick),
	.din_i(data),
	.tx_o(tx_o),
	.eot_o(eotx)
  );

  ram_volts #(
    .Width(12)
  ) mod_ram_volts (
    .clk_i(clk_i),
	.we_i(we),
	.addr_i(addr),
	.dinram_i(dataram),
	.doutram_o(doutram)
  );
  
  mux_ch #(
    .Width(8)
  ) mod_mux_ch (
    .sel_i(sel),
	.dmsb_i(dmsb),
	.dlsb_i(dlsb),
	.data_o(data)
  );
  
  counter_volts #(
    .Width(5)
  ) mod_cnt_volts (
    .rst_i(rst_i),
	.clk_i(clk_i),
	.opc1_i(oprom),
	.count_o(count)
  );
  
  counter_address #(
    .Width(5)
  ) mod_cnt_addr (
    .rst_i(rst_i),
	.clk_i(clk_i),
	.opc2_i(opram),
	.count_o(addr),
	.flag_o(flag)
  );
  
  rom_volts mod_rom (.addr_i(count), .rom_o(romout));
  
endmodule