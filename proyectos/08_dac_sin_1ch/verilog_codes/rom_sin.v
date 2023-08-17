// Author: Julisa Verdejo Palacios
// Name: adc_tx.v
//
// Description: Instanciacion de los modulos escritura y lectura del spi.


module rom_sin #(
  parameter Width = 12
) (
  input        [9:0] addr_i,
  output [Width-1:0] dout_o
);

  reg [Width-1:0] rom [1023:0];

  initial begin
     $readmemb("rom_data.mem", rom, 0, 1023);
  end

  assign dout_o = rom[addr_i];

endmodule