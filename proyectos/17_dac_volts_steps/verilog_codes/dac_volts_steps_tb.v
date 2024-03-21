// Author: Julisa Verdejo Palacios
// Name: adc_tx_tb.v
//
// Description: Testbench del modulo top.

`timescale 1 ns / 100 ps

module dac_volts_steps_tb();
  reg  clk;
  reg  rst;
  reg  button;
  wire mosi;
  wire sck;
  wire cs;
  wire eov;

  dac_volts_steps dut (
    .rst_i(rst),
    .clk_i(clk),
    .button_i(button),
    .mosi_o(mosi),
    .sck_o(sck),
    .cs_o(cs),
    .eov_o(eov)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; button = 0;  #10;
             rst = 0;              #10;
  end

  initial begin 
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    button = 1; #10;
    button = 0; #10;
    
    // Esperar que acabe el spi
    #(2000);

  end

endmodule