// Author: Julisa Verdejo Palacios
// Name: parity.v
//
// Description: Detector de paridad (error)

module parity (
  input  [7:0] d_i,  //Datos de entrada
  output       p_o   //Bit de paridad
);

  assign p_o = ^ d_i;

endmodule
