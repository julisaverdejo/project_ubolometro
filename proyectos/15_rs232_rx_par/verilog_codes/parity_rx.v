// Author: Julisa Verdejo Palacios
// Name: parity_rx.v
//
// Description: Calcula la paridad y comprueba si es igual a la recibida, es verdadero si no son iguales.

module parity_rx (
  input        rst_i,
  input        clk_i,
  input  [7:0] din_i,
  input        pbit_i,
  input        en_i,
  output reg   pcheck_o
);

  wire parity_eval, pcheck;

  assign parity_eval = ^ din_i;
  assign pcheck = pbit_i ^ parity_eval; 
  
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      pcheck_o <= 0; 
    else if (en_i)
      pcheck_o <= pcheck;
  end   
  

endmodule