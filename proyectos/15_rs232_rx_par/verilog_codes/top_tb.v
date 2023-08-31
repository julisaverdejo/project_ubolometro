`timescale 1 ns / 100 ps
`include "top.v"
`include "rs232_rx.v"
`include "fsm_rx.v"
`include "counter_rx.v"
`include "sipo_reg.v"
`include "clk_div.v"
`include "pipo_reg.v"
`include "parity_rx.v"

module top_tb ();
  reg         rst;
  reg         clk;
  reg         rx;
  wire  [7:0] dout;
  wire        pcheck;
  wire        eor;
  
  top dut (.rst_i(rst), .clk_i(clk), .rx_i(rx), .dout_o(dout), .pcheck_o(pcheck), .eor_o(eor));
  
  localparam period =  100_000_000*10/(9600) - 1;
  
  
  always #5 clk = ~clk;
    
  initial begin
    clk = 0;
    rst = 1;
    rx = 1;  // stop bit
    
    #10;
    rst = 0;
    
    #period;

    // Envio de primer valor 
    
    rx = 0; #period; // start bit
    rx = 1; #period; // d0
    rx = 1; #period; // d1
    rx = 1; #period; // d2
    rx = 0; #period; // d3
    rx = 1; #period; // d4
    rx = 1; #period; // d5
    rx = 1; #period; // d6
    rx = 0; #period; // d7
    rx = 0; #period; // paridad
    
    // Stop
    rx = 1;
    
    // Envio de segundo valor

    #period;
    rx = 0; #period; // start bit
    rx = 1; #period; // d0
    rx = 1; #period; // d1
    rx = 1; #period; // d2
    rx = 1; #period; // d3
    rx = 1; #period; // d4
    rx = 0; #period; // d5
    rx = 0; #period; // d6
    rx = 0; #period; // d7
    rx = 0; #period; // paridad

    // stop bit
    rx = 1;
  end

endmodule
