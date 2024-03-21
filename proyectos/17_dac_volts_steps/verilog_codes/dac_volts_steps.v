
module dac_volts_steps (
  input  clk_i,
  input  rst_i,
  input  button_i,
  output mosi_o,
  output sck_o,
  output cs_o,
  output eov_o
);

  wire en, flag, eow, start, z;
  wire [1:0] opc1, opc2;   
  wire [11:0] count;
  
  //localparam [28:0] k = 29'd299999999; //3s
  localparam [28:0] k = 29'd4; //3s  
  localparam [7:0]  kmax = 8'd4;
  localparam [3:0]  ctrl = 4'b0011;	//Canal A
  
  fsm_volts_steps mod_fsm_vs (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .button_i(button_i),
    .z_i(z),
	.flag_i(flag),
	.eow_i(eow),
	.start_o(start),
	.en_o(en),
	.opc1_o(opc1),
	.opc2_o(opc2),
	.eov_o(eov_o)
  );
  
  timer         #(.Width(29)) mod_timer     (.rst_i(rst_i), .clk_i(clk_i), .en_i(en), .k_i(k), .z_o(z));
  counter_volts #(.Width(12)) mod_cnt_volts (.rst_i(rst_i), .clk_i(clk_i), .opc1_i(opc1), .count_o(count));
  counter_steps #(.Width(7))  mod_cnt_steps	(.rst_i(rst_i), .clk_i(clk_i), .opc2_i(opc2), .flag_o(flag));
  
  spi_write_dac mod_spi_write_dac (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .strw_i(start),
    .kmax_i(kmax),
    .din_i({ctrl, count}),
    .mosi_o(mosi_o),
    .sck_o(sck_o),
    .cs_o(cs_o),
    .eow_o(eow)
  );


endmodule
