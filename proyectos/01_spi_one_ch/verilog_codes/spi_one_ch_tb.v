// Author: Julisa Verdejo Palacios
// Name: tb_top.v
//
// Description: Testbench del modulo top.

`timescale 1 ns / 100 ps
`include "clk_div.v"
`include "counter_r.v"
`include "counter_w.v"
`include "fsm_spir.v"
`include "fsm_spiw.v"
`include "fsm_tick.v"
`include "pipo_reg.v"
`include "piso_reg.v"
`include "single_tick.v"
`include "sipo_reg.v"
`include "spi_one_ch.v"
`include "spi_read.v"
`include "spi_wr.v"
`include "spi_write.v"
`include "timer.v"

module spi_one_ch_tb();
  reg         clk;
  reg         rst;
  reg         button;
  reg         miso;
  wire        mosi;
  wire [11:0] dout;
  wire        dclk;
  wire        cs;
  wire        eoc;

  spi_one_ch dut (
    .rst_i(rst), 
    .clk_i(clk), 
    .button_i(button), 
    .miso_i(miso), 
    .mosi_o(mosi), 
    .dout_o(dout), 
    .dclk_o(dclk), 
    .cs_o(cs), 
    .eoc_o(eoc)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; button = 0;  miso = 1; #10;
             rst = 0;                        #10;
  end

  initial begin 
    // Configuracion de archivos de salida
    $dumpfile("spi_one_ch_tb.vcd");
    $dumpvars(0,spi_one_ch_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    button = 1; #10;
    button = 0; #10;
    
    // Esperar que acabe la transmision
    #(10*40*60);  
    
    //Estimulos de prueba que falle
    button = 1; #10;
    button = 0; #10;      
    
    // Esperar que acabe la transmision
    #(10*40*60);  
    

    $display("Test completed");
    $finish;
   
  end

endmodule