// Author: Julisa Verdejo Palacios
// Name: adc_tx_tb.v
//
// Description: Testbench del modulo top.

`timescale 1 ns / 100 ps
`include "counter.v"

module counter_tb();
  reg         rst;
  reg         clk;
  reg   [1:0] opc;
  wire  [3:0] cnt;

  counter dut (
    .rst_i(rst),
    .clk_i(clk),
    .opc_i(opc),
    .cnt_o(cnt)
);

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; opc = 2'b00;  #10;
             rst = 0;               #10;
  end

  initial begin 
    // Configuracion de archivos de salida
    $dumpfile("counter_tb.vcd");
    $dumpvars(0,counter_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    opc = 2'b01; #10;
    //en = 0; #10;
    
    // Esperar que acabe el spi
    #(4000);

    
    $display("Test completed");
    $finish;
  end

endmodule