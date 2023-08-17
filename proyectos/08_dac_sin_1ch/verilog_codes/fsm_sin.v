// Author: Julisa Verdejo Palacios
// Name: fsm_spiw.v
//
// Description: Maquina de estados utilizada para controlar (escribir) el ADC.

module fsm_sin (
  input            rst_i,
  input            clk_i,
  input            start_i,
  input      [9:0] cnt_i,
  input            eow_i,
  output reg [1:0] opc_o,
  output reg       strw_o,
  output reg       end_o
);

  localparam [1:0] s0 = 2'b00,
                   s1 = 2'b01,
                   s2 = 2'b10,
                   s3 = 2'b11;

  reg [1:0] present_state, next_state;

  always @(start_i, cnt_i, eow_i, present_state) begin
    next_state = present_state;
    opc_o = 2'b00; strw_o = 1'b0; end_o = 1'b1;
    case (present_state)
      s0 : begin
             opc_o = 2'b00; strw_o = 1'b0; end_o = 1'b1;
             if (start_i)
               next_state = s1;
           end

      s1 : begin
             opc_o = 2'b01; strw_o = 1'b1; end_o = 1'b0;
             next_state = s2;
           end

      s2 : begin
             opc_o = 2'b01; strw_o = 1'b0; end_o = 1'b0;
             if (eow_i) begin
               if (cnt_i == 10'd1023)
                next_state = s0;
               else
                next_state = s3;
             end
           end

      s3 : begin
             opc_o = 2'b10; strw_o = 1'b0; end_o = 1'b0;
             next_state = s1;
           end 

      default: begin
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