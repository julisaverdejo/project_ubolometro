// Author: Julisa Verdejo Palacios
// Name: fsm_spir.v
//
// Description: Maquina de estados utilizada para guardar los datos recibidos del ADC (conversion).

module fsm_adc_tx (
  input       rst_i,
  input       clk_i,
  input       sts_i,
  input       eoc_i,
  input       eot_i,
  output reg  sel_o,
  output reg  strc_o,
  output reg  st_o,
  output reg  eos_o
);

  localparam [2:0] s0 = 3'b000, // Wait strr_i, Reset counter_r, Reset sipo_reg
                   s1 = 3'b001, // 
                   s2 = 3'b010, //
                   s3 = 3'b011, //
                   s4 = 3'b100, //
                   s5 = 3'b101, //
                   s6 = 3'b110; //

  reg [2:0] next_state, present_state;

  always @(sts_i, eoc_i, eot_i, present_state) begin
    sel_o = 1'b0; strc_o = 1'b0; st_o = 1'b0; eos_o = 1'b1;
    next_state = present_state;
    case (present_state)
      s0 : begin
             sel_o = 1'b0; strc_o = 1'b0; st_o = 1'b0; eos_o = 1'b1;
             if (sts_i)
               next_state = s1;
           end

      s1 : begin
             sel_o = 1'b0; strc_o = 1'b1; st_o = 1'b0; eos_o = 1'b0;
             next_state = s2;
           end

      s2 : begin
             sel_o = 1'b0; strc_o = 1'b0; st_o = 1'b0; eos_o = 1'b0;
             if (eoc_i)
               next_state = s3;
           end

      s3 : begin
             sel_o = 1'b0; strc_o = 1'b0; st_o = 1'b1; eos_o = 1'b0;
             next_state = s4;
           end

      s4 : begin
             sel_o = 1'b0; strc_o = 1'b0; st_o = 1'b0; eos_o = 1'b0;
             if (eot_i)
               next_state = s5;
           end

      s5 : begin
             sel_o = 1'b1; strc_o = 1'b0; st_o = 1'b1; eos_o = 1'b0;
             next_state = s6;
           end

      s6 : begin
             sel_o = 1'b1; strc_o = 1'b0; st_o = 1'b0; eos_o = 1'b0;
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