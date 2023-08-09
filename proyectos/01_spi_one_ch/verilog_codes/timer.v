// Author: Julisa Verdejo Palacios
// Name: timer.v
//
// Description: 

module timer #(
  parameter Width = 29
) (
  input             rst_i,
  input             clk_i,
  input             en_i,
  input [Width-1:0] k_i,
  output            z_o
);

  wire [Width-1:0] mux1;
  wire [Width-1:0] mux2_d;
  wire comp;
  reg [Width-1:0] reg_q;

  assign mux1 = (en_i) ? reg_q - 1 : reg_q;
  assign mux2_d = (comp) ? k_i : mux1;
  assign comp = ( reg_q == {Width{1'b0}} ) ? 1'b1 : 1'b0;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux2_d;
  end

  assign z_o = comp; 

endmodule