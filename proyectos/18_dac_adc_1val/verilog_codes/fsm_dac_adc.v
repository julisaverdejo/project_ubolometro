// Author: Julisa Verdejo Palacios
// Name: fsm_dac_adc.v
//
// Description: Maquina de estados utilizada para guardar los datos recibidos del ADC (conversion).

module fsm_dac_adc (
  input        rst_i,
  input        clk_i,
  input        start_i,
  input        eodac_i,
  input        eoadc_i,
  input        z_i,
  output reg   stdac_o,
  output reg   stadc_o,
  output reg   en_o,
  output reg   eoconv_o
);

  localparam [2:0] s0 = 3'b000, // Wait strr_i, Reset counter_r, Reset sipo_reg
                   s1 = 3'b001, // 
                   s2 = 3'b010, //
                   s3 = 3'b011, //
                   s4 = 3'b100, // 
				   s5 = 3'b101;

  reg [2:0] next_state, present_state;

  always @(start_i, eodac_i, eoadc_i, z_i, present_state) begin
    stdac_o = 1'b0; stadc_o = 1'b0; en_o = 1'b0; eoconv_o = 1'b1;
    next_state = present_state;
    case (present_state)
      s0 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; en_o = 1'b0; eoconv_o = 1'b1;
             if (start_i)
               next_state = s1;
           end

      s1 : begin
             stdac_o = 1'b1; stadc_o = 1'b0; en_o = 1'b0; eoconv_o = 1'b0;
             next_state = s2;
           end

      s2 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; en_o = 1'b0; eoconv_o = 1'b0;
             if (eodac_i)
               next_state = s3;
           end

      s3 : begin
             stdac_o = 1'b0; stadc_o = 1'b1; en_o = 1'b0; eoconv_o = 1'b0;
             next_state = s4;
           end

      s4 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; en_o = 1'b0; eoconv_o = 1'b0;
             if (eoadc_i) 
			   next_state = s5;
           end

      s5 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; en_o = 1'b1; eoconv_o = 1'b0;
             if (z_i) 
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