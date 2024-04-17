// Author: Julisa Verdejo Palacios
// Name: tb_top.v
//
// Description: Testbench del modulo top.

`timescale 1 ns / 100 ps
//`include "clk_div.v"
//`include "counter_r.v"
//`include "counter_w.v"
//`include "fsm_spir.v"
//`include "fsm_spiw.v"
//`include "fsm_tick.v"
//`include "pipo_reg.v"
//`include "piso_reg.v"
//`include "single_tick.v"
//`include "sipo_reg.v"
//`include "spi_one_ch.v"
//`include "spi_read.v"
//`include "spi_wr.v"
//`include "spi_write.v"
//`include "timer.v"

module dac_adc_tx_tb();
  reg         clk;
  reg         rst;
  reg         start;
  reg         miso_adc;
  wire        mosi_dac;
  wire        mosi_adc;
  wire        tx;
  wire        dclk;
  wire        sck;  
  wire        cs_dac;
  wire        cs_adc;  
  wire        eos;

  dac_adc_tx dut (
    .rst_i(rst), 
    .clk_i(clk), 
    .start_i(start), 
    .miso_adc_i(miso_adc), 
    .mosi_dac_o(mosi_dac), 
    .dclk_o(dclk), 
    .cs_dac_o(cs_dac), 
    .mosi_adc_o(mosi_adc), 
    .sck_o(sck),
	.cs_adc_o(cs_adc),
	.tx_o(tx),
	.eos_o(eos)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; start = 0;  miso_adc = 1; #10;
             rst = 0;                           #10;
  end

  initial begin 
    // Configuracion de archivos de salida
//    $dumpfile("spi_one_ch_tb.vcd");
//    $dumpvars(0,spi_one_ch_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    start = 1; #10;
    start = 0; #10;
    
    // Esperar que acabe la transmision
    #(10*40*60);
    

//    $display("Test completed");
//    $finish;
   
  end
endmodule