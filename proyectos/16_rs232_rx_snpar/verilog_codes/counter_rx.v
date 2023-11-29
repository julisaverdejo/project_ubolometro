// Author: Julisa Verdejo Palacios
// Name: counter_w.v
//
// Description: Contador descendente utilizado para contar los 25 ciclos de dclk.

module counter_rx #(
  parameter Width = 4
) (
  input              rst_i,
  input              clk_i,
  input        [1:0] en_i,
  input  [Width-1:0] vmax_i,  
  output             flag_o
);

  reg [Width-1:0] mux_d, reg_q;

  always @(en_i, reg_q) begin
    case (en_i)
      2'b00   : mux_d = 0;
      2'b01   : mux_d = reg_q;
      2'b10   : mux_d = reg_q + 1;
      2'b11   : mux_d = 0;
      default : mux_d = reg_q;
    endcase
  end
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux_d;
  end

  assign flag_o = (reg_q == 4'd8) ? 1'b1 : 1'b0;
  
endmodule