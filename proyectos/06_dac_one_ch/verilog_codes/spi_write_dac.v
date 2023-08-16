// Author: Julisa Verdejo Palacios
// Name: spi_write.v
//
// Description: Instanciacion de todos los modulos utilizados para la escritura.

module spi_write_dac (
  input         rst_i,
  input         clk_i,
  input         strw_i,
  input   [7:0] kmax_i,
  input  [15:0] din_i,
  output        mosi_o,
  output        sck_o,
  output        cs_o,
  output        eow_o
);

  wire  [1:0] opc1, opc2;
  wire slow_clk, flag, hab;
  
  //localparam  [7:0] kmax_i = 8'd4;

  //localparam  [3:0] ctrl = 4'b0011; // DAC-A
  //localparam  [3:0] ctrl = 4'b1011; // DAC-B

  //localparam [11:0] volbits = 12'b111111111111; //3.3V
  //localparam [11:0] volbits = 12'b010011011001; //1V
  //localparam [11:0] volbits = 12'b100110110010; //2V
  //localparam [11:0] volbits = 12'b100000000000; //1.65V
  //localparam [11:0] volbits = 12'b001001101101; //0.5V

  
  piso_reg   #(.Width(16))  mod_piso    (.rst_i(rst_i), .clk_i(clk_i), .din_i(din_i), .op_i(opc1), .dout_o(mosi_o));
  counter_w  #(.Width(5))  mod_cnt_w   (.rst_i(rst_i), .clk_i(clk_i), .opc_i(opc2), .flag_o(flag));
  clk_div    #(.Width(8))  mod_clkdiv  (.rst_i(rst_i), .clk_i(clk_i), .h_i(hab), .kmax_i(kmax_i), .slow_clk_o(slow_clk));
  
  fsm_spiw  mod_fsm_w (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .strw_i(strw_i),
    .slow_clk_i(slow_clk),
    .flag_i(flag),
    .opc1_o(opc1),
    .opc2_o(opc2),
    .cs_o(cs_o),
    .sck_o(sck_o),
    .hab_o(hab),
    .eow_o(eow_o)
  );

endmodule