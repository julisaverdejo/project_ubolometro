// Author: Julisa Verdejo Palacios
// Name: fsm_master.v
//
// Description: Maquina de estados utilizada para guardar las conversiones de 2 canales del ADC.

module fsm_master (
  input            clk_i,
  input            rst_i,
  input            stm_i,
  input            eoc_i,
  output reg       st_o,
  output reg [1:0] sel_o,
  output reg       h0_o,
  output reg       h1_o,
  output reg       h2_o,
  output reg       h3_o,
  output reg       eos_o
);

  localparam [3:0]  s0 = 4'b0000,
                    s1 = 4'b0001,
                    s2 = 4'b0010,
                    s3 = 4'b0011,
                    s4 = 4'b0100,
                    s5 = 4'b0101,
                    s6 = 4'b0110,
                    s7 = 4'b0111,
                    s8 = 4'b1000,
                    s9 = 4'b1001,
                   s10 = 4'b1010,
                   s11 = 4'b1011,
                   s12 = 4'b1100;

  reg [3:0] next_state, present_state;

  always @(stm_i, eoc_i, present_state) begin
    st_o = 1'b0; sel_o = 2'b00; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b1;
    next_state = present_state;
    case(present_state)
      s0: begin
                st_o = 1'b0; sel_o = 2'b00; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b1;
                if(stm_i)
                  next_state = s1;
              end

      s1: begin
                st_o = 1'b1; sel_o = 2'b00; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s2;
              end

      s2: begin
                st_o = 1'b0; sel_o = 2'b00; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                if(eoc_i)
                  next_state = s3;
              end

      s3: begin
                st_o = 1'b0; sel_o = 2'b01; h0_o = 1'b1; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s4;
              end

      s4: begin
                st_o = 1'b1; sel_o = 2'b01; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s5;
              end

      s5: begin
                st_o = 1'b0; sel_o = 2'b01; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                if(eoc_i)
                  next_state = s6;
              end

      s6: begin
                st_o = 1'b0; sel_o = 2'b10; h0_o = 1'b0; h1_o = 1'b1; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s7;
              end

      s7: begin
                st_o = 1'b1; sel_o = 2'b10; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s8;
              end

      s8: begin
                st_o = 1'b0; sel_o = 2'b10; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                if(eoc_i)
                  next_state = s9;
              end

      s9: begin
                st_o = 1'b0; sel_o = 2'b11; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b1; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s10;
              end

      s10: begin
                st_o = 1'b1; sel_o = 2'b11; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                next_state = s11;
              end

      s11: begin
                st_o = 1'b0; sel_o = 2'b11; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b0; eos_o = 1'b0;
                if(eoc_i)
                  next_state = s12;
              end

      s12: begin
                st_o = 1'b0; sel_o = 2'b11; h0_o = 1'b0; h1_o = 1'b0; h2_o = 1'b0; h3_o = 1'b1; eos_o = 1'b0;
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