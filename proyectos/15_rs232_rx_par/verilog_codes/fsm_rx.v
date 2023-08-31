         // Author: Julisa Verdejo Palacios
// Name: fsm_rx.v
// version 1: No se sale del estado pero no recibe lo que se envia
// Description:

module fsm_rx (
  input            rst_i,
  input            clk_i,
  input            rx_i,
  input            z_i,
  input            flag_i,
  output reg       sel_o,
  output reg       enclk_o,
  output reg [1:0] encnt_o,
  output reg [1:0] ensipo_o,
  output reg       enpipo_o,
  output reg       eor_o,
  output reg       enp_o
);

  localparam [2:0] s0 = 3'b000,
                   s1 = 3'b001,
                   s2 = 3'b010,
                   s3 = 3'b011,
                   s4 = 3'b100,
                   s5 = 3'b101,
                   s6 = 3'b110;
//             s7 = 3'b111;

  reg [2:0] next_state, present_state;

  always @(rx_i, z_i, flag_i, present_state) begin
//    sel_o = 1'b0; enclk_o = 1'b0; encnt_o = 1'b0; ensipo_o = 2'b00; enpipo_o = 1'b0; eor_o = 1'b1;
    next_state = present_state;
    case(present_state)
      s0: begin
            sel_o = 1'b0; enclk_o = 1'b0; encnt_o = 2'b00; ensipo_o = 2'b00; enpipo_o = 1'b0; eor_o = 1'b1; enp_o = 1'b0;
            if (!rx_i)
              next_state = s1;
          end

      s1: begin
            sel_o = 1'b0; enclk_o = 1'b1; encnt_o = 2'b01; ensipo_o = 2'b01; enpipo_o = 1'b0; eor_o = 1'b0; enp_o = 1'b0;
            if (z_i)
              next_state = s2;
          end

      s2: begin
            sel_o = 1'b1; enclk_o = 1'b1; encnt_o = 2'b01; ensipo_o = 2'b01; enpipo_o = 1'b0; eor_o = 1'b0; enp_o = 1'b0;
            if (z_i)
              next_state = s3;
          end 

      s3: begin
            sel_o = 1'b1; enclk_o = 1'b1; encnt_o = 2'b10; ensipo_o = 2'b10; enpipo_o = 1'b0; eor_o = 1'b0; enp_o = 1'b0;
            next_state = s4;
          end

      s4: begin
            sel_o = 1'b1; enclk_o = 1'b1; encnt_o = 2'b01; ensipo_o = 2'b01; enpipo_o = 1'b0; eor_o = 1'b0; enp_o = 1'b0;
            if (z_i) begin
              if(flag_i)
                next_state = s5;
              else
                next_state = s2;
            end
          end

      s5: begin
            sel_o = 1'b1; enclk_o = 1'b1; encnt_o = 2'b00; ensipo_o = 2'b01; enpipo_o = 1'b1; eor_o = 1'b0; enp_o = 1'b1;
            next_state = s6;
          end 

      s6: begin
            sel_o = 1'b1; enclk_o = 1'b1; encnt_o = 2'b01; ensipo_o = 2'b00; enpipo_o = 1'b0; eor_o = 1'b0; enp_o = 1'b0;
            if (z_i)
              next_state = s0;
          end
       
//    s7: begin
//        sel_o = 1'b0; enclk_o = 1'b0; encnt_o = 1'b0; ensipo_o = 2'b00; enpipo_o = 1'b0; eor_o = 1'b0;
//        if (rx_i)
//          next_state = s0;
//       end 
//
 endcase
  end

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      present_state <= s0;
    else
      present_state <= next_state;
  end

endmodule