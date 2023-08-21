// Author: Julisa Verdejo Palacios
// Name: single_tick.v
//
// Description:

module fsm_2ch (
  input       rst_i,
  input       clk_i,
  input       start_i,
  input       eow_i,
  output reg  strw_o,
  output reg  selch_o,
  output reg  eod_o
);

  localparam [2:0] s0 = 3'b000,
                   s1 = 3'b001,
                   s2 = 3'b010,
                   s3 = 3'b011,
                   s4 = 3'b100;

  reg [2:0] next_state, present_state;

  always @(start_i, eow_i, present_state) begin
    strw_o = 1'b0; selch_o = 1'b0; eod_o = 1'b1;
    next_state = present_state;
    case(present_state)
      s0: begin
            strw_o = 1'b0; selch_o = 1'b0; eod_o = 1'b1;
            if (start_i)
              next_state = s1;
          end

      s1: begin
            strw_o = 1'b1; selch_o = 1'b0; eod_o = 1'b0;
            next_state = s2;
          end

      s2: begin
            strw_o = 1'b0; selch_o = 1'b0; eod_o = 1'b0;
            if (eow_i)
              next_state = s3;
          end 

      s3: begin
            strw_o = 1'b1; selch_o = 1'b1; eod_o = 1'b0;
            next_state = s4;
          end

      s4: begin
            strw_o = 1'b0; selch_o = 1'b1; eod_o = 1'b0;
            if (eow_i)
              next_state = s0;
          end

      default:  begin
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