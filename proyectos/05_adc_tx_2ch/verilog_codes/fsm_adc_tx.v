// Author: Julisa Verdejo Palacios
// Name: fsm_spir.v
//
// Description: Maquina de estados utilizada para guardar los datos recibidos del ADC (conversion).

module fsm_adc_tx (
  input            rst_i,
  input            clk_i,
  input            sta_i,
  input            eos_i,
  input            eot_i,
  output reg [1:0] sel_o,
  output reg       stm_o,
  output reg       st_o,
  output reg       eoa_o
);

  localparam [3:0] s0  = 4'b0000, // 
                   s1  = 4'b0001, // 
                   s2  = 4'b0010, //
                   s3  = 4'b0011, //
                   s4  = 4'b0100, //
                   s5  = 4'b0101, //
                   s6  = 4'b0110, //
                   s7  = 4'b0111,
                   s8  = 4'b1000,
                   s9  = 4'b1001,
                   s10 = 4'b1010;

  reg [3:0] next_state, present_state;

  always @(sta_i, eos_i, eot_i, present_state) begin
    sel_o = 2'b00; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b1;
    next_state = present_state;
    case (present_state)
      s0 : begin
             sel_o = 2'b00; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b1;
             if (sta_i)
               next_state = s1;
           end

      s1 : begin
             sel_o = 2'b00; stm_o = 1'b1; st_o = 1'b0; eoa_o = 1'b0;
             next_state = s2;
           end

      s2 : begin
             sel_o = 2'b00; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b0;
             if (eos_i)
               next_state = s3;
           end

      s3 : begin
             sel_o = 2'b00; stm_o = 1'b0; st_o = 1'b1; eoa_o = 1'b0;
             next_state = s4;
           end

      s4 : begin
             sel_o = 2'b00; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b0;
             if (eot_i)
               next_state = s5;
           end

       s5 : begin
             sel_o = 2'b01; stm_o = 1'b0; st_o = 1'b1; eoa_o = 1'b0;
             next_state = s6;
           end

       s6 : begin
             sel_o = 2'b01; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b0;
             if (eot_i)
               next_state = s7;
           end

       s7 : begin
             sel_o = 2'b10; stm_o = 1'b0; st_o = 1'b1; eoa_o = 1'b0;
             next_state = s8;
           end

       s8 : begin
             sel_o = 2'b10; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b0;
             if (eot_i)
               next_state = s9;
           end

       s9 : begin
             sel_o = 2'b11; stm_o = 1'b0; st_o = 1'b1; eoa_o = 1'b0;
             next_state = s10;
           end

      s10 : begin
             sel_o = 2'b11; stm_o = 1'b0; st_o = 1'b0; eoa_o = 1'b0;
             if (eot_i)
               next_state = s0;
           end

      default : begin
                  next_state = s0;
                end
    endcase
  end

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      present_state <= s0;
    else
      present_state <= next_state;
  end

endmodule