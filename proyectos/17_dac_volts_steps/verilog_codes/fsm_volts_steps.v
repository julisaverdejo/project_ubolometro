// Author: Julisa Verdejo Palacios
// Name: fsm_spiw.v
//
// Description: Maquina de estados utilizada para controlar (escribir) el ADC.

module fsm_volts_steps (
  input            rst_i,
  input            clk_i,
  input            button_i,
  input            z_i,
  input            flag_i,
  input            eow_i,
  output reg       start_o,
  output reg       en_o,
  output reg [1:0] opc1_o,
  output reg [1:0] opc2_o, 
  output reg       eov_o
);

  localparam [2:0] s0 = 3'b000, //  
                   s1 = 3'b001, // 
                   s2 = 3'b010, // 
                   s3 = 3'b011, // 
                   s4 = 3'b100; // 


  reg [2:0] present_state, next_state;

  always @(button_i, z_i, flag_i, eow_i, present_state) begin
    next_state = present_state;
    start_o = 1'b0; en_o = 1'b0; opc1_o = 2'b00; opc2_o = 2'b00; eov_o = 1'b1;
    case (present_state)
      s0 : begin
             start_o = 1'b0; en_o = 1'b0; opc1_o = 2'b00; opc2_o = 2'b00; eov_o = 1'b1;
             if (button_i)
               next_state = s1;
           end

      s1 : begin
             start_o = 1'b1; en_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; eov_o = 1'b0;
             next_state = s2;
           end

      s2 : begin
             start_o = 1'b0; en_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; eov_o = 1'b0;
             if (eow_i)
               next_state = s3;
           end

      s3 : begin
             start_o = 1'b0; en_o = 1'b1; opc1_o = 2'b10; opc2_o = 2'b10; eov_o = 1'b0;
             next_state = s4;
           end 

      s4 : begin
		     start_o = 1'b0; en_o = 1'b1; opc1_o = 2'b01; opc2_o = 2'b01; eov_o = 1'b0;
		  	 if (z_i) begin
			    if (flag_i) begin
				  next_state = s0;
				end else begin
				  next_state = s1;
				end
		     end
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