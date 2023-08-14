// Author: Julisa Verdejo Palacios
// Name: fsm_master.v
//
// Description: Maquina de estados utilizada para guardar las conversiones de 2 canales del ADC.

module fsm_adc_2ch (
  input       clk_i,
  input       rst_i,
  input       stm_i,
  input       eoc_i,
  output reg  strc_o,
  output reg  sel_o,
  output reg  h1_o,
  output reg  h2_o,
  output reg  eos_o
);

  localparam [2:0] s0 = 3'b000,
                   s1 = 3'b001,
                   s2 = 3'b010,
                   s3 = 3'b011,
                   s4 = 3'b100,
                   s5 = 3'b101,
                   s6 = 3'b110;

  reg [2:0] next_state, present_state;

  always @(stm_i, eoc_i, present_state) begin
    strc_o = 1'b0; sel_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; eos_o = 1'b1;
    next_state = present_state;
    case(present_state)
      s0: begin
                strc_o = 1'b0; sel_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; eos_o = 1'b1;
                if(stm_i)
                  next_state = s1;
              end

      s1: begin
                strc_o = 1'b1; sel_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; eos_o = 1'b0;
                next_state = s2;
              end

      s2: begin
                strc_o = 1'b0; sel_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; eos_o = 1'b0;
                if(eoc_i)
                  next_state = s3;
              end

      s3: begin
                strc_o = 1'b0; sel_o = 1'b1; h1_o = 1'b1; h2_o = 1'b0; eos_o = 1'b0;
                next_state = s4;
              end

      s4: begin
                strc_o = 1'b1; sel_o = 1'b1; h1_o = 1'b0; h2_o = 1'b0; eos_o = 1'b0;
                next_state = s5;
              end

      s5: begin
                strc_o = 1'b0; sel_o = 1'b1; h1_o = 1'b0; h2_o = 1'b0; eos_o = 1'b0;
                if(eoc_i)
                  next_state = s6;
              end

      s6: begin
                strc_o = 1'b0; sel_o = 1'b1; h1_o = 1'b0; h2_o = 1'b1; eos_o = 1'b0;
                next_state = s0;
              end

      default: begin
                next_state = s0;
               end
    endcase
  end

  always@ (posedge clk_i, posedge rst_i) begin
    if (rst_i)
      present_state <= s0;
    else
      present_state <= next_state;
  end

endmodule