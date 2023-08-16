// Author: Julisa Verdejo Palacios
// Name: adc_tx_tb.v
//
// Description: Testbench del modulo top.

`timescale 1 ns / 100 ps
`include "single_tick.v"
`include "timer.v"
`include "fsm_tick.v"
`include "spi_write_dac.v"
`include "piso_reg.v"
`include "counter_w.v"
`include "clk_div.v"
`include "fsm_spiw.v"
`include "spi_dac_1ch.v"

module spi_dac_1ch_tb();
  reg   rst;
  reg   clk;
  reg   button;
  wire  mosi;
  wire  sck;
  wire  cs;
  wire  eow;

  spi_dac_1ch dut (
    .rst_i(rst),
    .clk_i(clk),
    .button_i(button),
    .mosi_o(mosi),
    .sck_o(sck),
    .cs_o(cs),
    .eow_o(eow)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; button = 0;  #10;
             rst = 0;              #10;
  end

  initial begin 
    // Configuracion de archivos de salida
    $dumpfile("spi_dac_1ch_tb.vcd");
    $dumpvars(0,spi_dac_1ch_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    button = 1; #10;
    button = 0; #10;
    
    // Esperar que acabe el spi
    #(2000);

    
    $display("Test completed");
    $finish;
  end

endmodule