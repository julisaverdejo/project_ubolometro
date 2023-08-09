// Author: Julisa Verdejo Palacios
// Email: julisa.verdejo@gmail.com
// Name: single_tick.v
//
// Description:

module single_tick (
  input   clk_i,
  input   rst_i,
  //input   k_i,
  input   button_i,
  output  start_o,
  output  z_o
);

  localparam [28:0] k_i = 29'd499999999;
  wire z, en;  

  timer #(.Width(29))  mod_timer  (.clk_i(clk_i), .rst_i(rst_i), .en_i(en), .k_i(k_i), .z_o(z));
  
  fsm_tick  mod_fsm_tick (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .button_i(button_i),
    .z_i(z),
    .start_o(start_o),
    .en_o(en)
  );
  
  assign z_o = z;

endmodule