// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.

module adc_tx_2ch_qua (
  input         rst_i,
  input         clk_i,
  input         button_i,
  input         miso_i,
  output        mosi_o,
  output        dclk_o,
  output        cs_o,
  output        tx_o,
  output        eoa_o
);

  localparam  [7:0] ch0_i = 8'b10010111;
  localparam  [7:0] ch1_i = 8'b11010111;  
  localparam [28:0] k_i   = 29'd499999999;  // 5 seg
  localparam  [7:0] kmax_i = 8'd39;         // Periodo dclk = 800ns
  localparam [14:0] baud = 15'd10415;
  localparam        psel = 1'b1;

  wire sta, stm, st;
  wire eos, eot;
  wire [1:0] sel;

  wire [11:0] doutch0_o, doutch1_o;
  wire [7:0] dmch0, dlch0, dmch1, dlch1, data;

  assign dmch0 = {4'b0000, doutch0_o[11:8]};
  assign dlch0 = doutch0_o[7:0];
  assign dmch1 = {4'b0000, doutch1_o[11:8]};
  assign dlch1 = doutch1_o[7:0];


  single_tick #(.Width(29)) mod_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(button_i),
    .start_o(sta)
  );

  fsm_adc_tx mod_fsm_adc_tx(
    .rst_i(rst_i),
    .clk_i(clk_i),
    .sta_i(sta),
    .eos_i(eos),
    .eot_i(eot),
    .sel_o(sel),
    .stm_o(stm),
    .st_o(st),
    .eoa_o(eoa_o)
);

  spi_two_ch mod_spi_two_ch (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .stm_i(stm),
    .miso_i(miso_i),
    .ch0_i(ch0_i),
    .ch1_i(ch1_i),
    .kmax_i(kmax_i),
    .mosi_o(mosi_o),
    .dclk_o(dclk_o),
    .cs_o(cs_o),
    .eos_o(eos),
    .doutch0_o(doutch0_o),
    .doutch1_o(doutch1_o)
);

  mux_data #(.Width(8)) mod_mux_data (
    .sel_i(sel),
    .dmch0_i(dmch0),
    .dlch0_i(dlch0),
    .dmch1_i(dmch1),
    .dlch1_i(dlch1),
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