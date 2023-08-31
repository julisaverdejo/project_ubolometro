// Author: Julisa Verdejo Palacios
// Name: rs232_rx.v
//
// Description: 

module rs232_rx (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  output  [7:0] dout_o,
  output        pcheck_o,
  output        eor_o
);

  
  wire z, flag, sel, enclk, enpipo, enp;
  wire [1:0] encnt, ensipo;
  wire [13:0] kmax;
  wire [8:0] data;
  
  //kmax = (frec. fpga/baudios) - 1
  //kmax0 = (100000000/9600)-1,
  //kmax1 = (100000000/(2*9600))-1;

  assign kmax = sel ? 14'd5207 : 14'd10416;

  fsm_rx mod_rs232_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .rx_i(rx_i),
    .z_i(z),
    .flag_i(flag),
    .sel_o(sel),
    .enclk_o(enclk),
    .encnt_o(encnt),
    .ensipo_o(ensipo),
    .enpipo_o(enpipo),
    .eor_o(eor_o),
    .enp_o(enp)
  );

  counter_rx #(.Width(4)) mod_counter_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(encnt),
    .vmax_i(4'd9),
    .flag_o(flag)
);

  sipo_reg #(.Width(9)) mod_sipo_reg (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .din_i(rx_i),
    .op_i(ensipo),
    .dout_o(data)
);

  clk_div #(.Width(14)) mod_clk_div ( 
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(enclk),
    .vmax_i(kmax),
    .flag_o(z)
);

  pipo_reg #(.Width(8)) mod_pipo_reg ( 
    .rst_i(rst_i),
    .clk_i(clk_i),
    .hab_i(enpipo),
    .din_i(data[7:0]),
    .dout_o(dout_o)
);

  parity_rx mod_parity (
    .rst_i(rst_i),
    .clk_i(clk_i),  
    .din_i(data[7:0]),
    .pbit_i(data[8]),
    .en_i(enp),
    .pcheck_o(pcheck_o)
);

endmodule