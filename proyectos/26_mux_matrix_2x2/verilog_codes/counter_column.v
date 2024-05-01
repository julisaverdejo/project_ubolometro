// Author: Julisa Verdejo Palacios
// Name: counter_column.v
//
// Description: 

module counter_column #(
  parameter Width = 5
) (
  input              rst_i,
  input              clk_i,
  input              en_i,
  output [Width-1:0] count_o
);

  wire mux;
  reg  reg_q;

  assign mux = (en_i) ? reg_q + 1 : reg_q;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux;
  end

  assign count_o = {4'b0,reg_q};
  
endmodule