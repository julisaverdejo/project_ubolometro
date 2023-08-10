// Author: Julisa Verdejo Palacios
// Name: single_tick.v
//
// Description:

module single_tick #(
  parameter Width = 29
) (
  input              rst_i,
  input              clk_i,
  input  [Width-1:0] k_i,
  input              button_i,
  output             start_o
);

  wire z, en;

  timer #(.Width(Width)) mod_timer (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(en),
    .k_i(k_i),
    .z_o(z)
  );

  fsm_tick mod_fsm_tick (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .button_i(button_i),
    .z_i(z),
    .start_o(start_o),
    .en_o(en)
  );

endmodule