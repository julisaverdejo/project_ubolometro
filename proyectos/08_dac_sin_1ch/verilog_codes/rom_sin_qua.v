// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.


module rom_sin_qua #(
  parameter Width = 12
) (
  input            [9:0] addr_i,
  output reg [Width-1:0] dout_o
);

  always @(addr_i) begin
    case(addr_i)
       0: dout_o = 12'b100000000000;
       1: dout_o = 12'b101010011000;
       2: dout_o = 12'b110011101001;
       3: dout_o = 12'b111010110010;
       4: dout_o = 12'b111111000000;
       5: dout_o = 12'b111111111000;
       6: dout_o = 12'b111101010011;
       7: dout_o = 12'b110111100010;
       8: dout_o = 12'b101111001110;
       9: dout_o = 12'b100101010001;
      10: dout_o = 12'b011010101110;
      11: dout_o = 12'b010000110001;
      12: dout_o = 12'b001000011101;
      13: dout_o = 12'b000010101100;
      14: dout_o = 12'b000000000111;
      15: dout_o = 12'b000000111111;
      16: dout_o = 12'b000101001101;
      17: dout_o = 12'b001100010110;
      18: dout_o = 12'b010101100111;
      19: dout_o = 12'b011111111111;
      default: dout_o = 12'b100000000000;
    endcase

  end

endmodule