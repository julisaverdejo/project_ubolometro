// Author: Julisa Verdejo Palacios
// Name: adc_tx_tb.v
//
// Description: Testbench del modulo top.

`timescale 1 ns / 100 ps
`include "clk_div.v"
`include "counter_r.v"
`include "counter_w.v"
`include "fsm_master.v"
`include "fsm_spir.v"
`include "fsm_spiw.v"
`include "mux_ch.v"
`include "pipo_reg.v"
`include "piso_reg.v"
`include "sipo_reg.v"
`include "spi_read.v"
`include "spi_adc_4ch.v"
`include "spi_wr.v"
`include "spi_write.v"


module spi_adc_4ch_tb();
  reg          rst;
  reg          clk;
  reg          start;
  reg          miso;
  wire         mosi;
  wire         dclk;
  wire         cs;
  wire         eos;
  wire [11:0]  doutch0;
  wire [11:0]  doutch1;
  wire [11:0]  doutch2;
  wire [11:0]  doutch3;


  spi_adc_4ch dut (
    .rst_i(rst),
    .clk_i(clk),
    .start_i(start),
    .miso_i(miso),
    .mosi_o(mosi),
    .dclk_o(dclk),
    .cs_o(cs),
    .eos_o(eos),
    .doutch0_o(doutch0),
    .doutch1_o(doutch1),
    .doutch2_o(doutch2),
    .doutch3_o(doutch3)
);

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; start = 0;  miso = 1; #10;
             rst = 0;                        #10;
  end

  initial begin 
    // Configuracion de archivos de salida
    $dumpfile("spi_adc_4ch_tb.vcd");
    $dumpvars(0,spi_adc_4ch_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    start = 1; #10;
    start = 0; #10;
    
    // Esperar que acabe el spi
    #((10*40*60)*4);
   
    $display("Test completed");
    $finish;
  end

endmodule