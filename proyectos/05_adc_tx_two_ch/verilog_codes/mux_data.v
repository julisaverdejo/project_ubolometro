// Author: Julisa Verdejo Palacios
// Name: mux_ch.v
//
// Description: 

module mux_data #(
  parameter Width = 8
) (
  input             [1:0] sel_i,
  input       [Width-1:0] dmch0_i,
  input       [Width-1:0] dlch0_i,
  input       [Width-1:0] dmch1_i,
  input       [Width-1:0] dlch1_i,
  output reg  [Width-1:0] data_o
);

  always @(sel_i, dmch0_i, dlch0_i, dmch1_i, dlch1_i) begin
    case(sel_i)
      2'b00   : data_o = dmch0_i;
      2'b01   : data_o = dlch0_i;
      2'b10   : data_o = dmch1_i;
      2'b11   : data_o = dlch1_i;
      default : data_o = dmch0_i;
    endcase
  end
endmodule