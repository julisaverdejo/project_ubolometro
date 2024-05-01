// Author: Julisa Verdejo Palacios
// Email: julisa.verdejo@gmail.com
// Name: single_tick.v
//
// Description:

module mux_matrix_2x2 #(
  parameter Width = 5
)
  (
  input              rst_i,
  input              clk_i,
  input              brow_i,
  input              bcol_i,  
  output [Width-1:0] row_o,
  output [Width-1:0] col_o
);

  wire st_row, st_col;
  localparam [28:0] k_i = 199999999; //2s

  single_tick #(.Width(29)) mod_single_tick_row (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(brow_i),
    .start_o(st_row)
);

  counter_row #(.Width(Width)) mod_count_row (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(st_row),
    .count_o(row_o)
);

  single_tick #(.Width(29)) mod_single_tick_col (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .k_i(k_i),
    .button_i(bcol_i),
    .start_o(st_col)
);

  counter_column #(.Width(Width)) mod_count_col (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(st_col),
    .count_o(col_o)
);

endmodule