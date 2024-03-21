// Author: Julisa Verdejo Palacios
// Name: fsm_dac_adc.v
//
// Description: version 2

module fsm_dac_adc (
  input            rst_i,
  input            clk_i,
  input            start_i,
  input            eodac_i,
  input            eoadc_i,
  input            z_i,
  input            flag_i,
  output reg       stdac_o,
  output reg       stadc_o,
  output reg [1:0] opc1_o,
  output reg [1:0] opc2_o,
  output reg       en_o,
  output reg       eoconv_o
);

  localparam [3:0] s0 = 4'b0000, // Wait strr_i, Reset counter_r, Reset sipo_reg
                   s1 = 4'b0001, // 
                   s2 = 4'b0010, //
                   s3 = 4'b0011, //
                   s4 = 4'b0100, // 
				   s5 = 4'b0101,
				   s6 = 4'b0110,
				   s7 = 4'b0111,
				   s8 = 4'b1000;

  reg [3:0] next_state, present_state;

  always @(start_i, eodac_i, eoadc_i, z_i, flag_i, present_state) begin
    stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b00; opc2_o = 2'b00; en_o = 1'b0; eoconv_o = 1'b1;
    next_state = present_state;
    case (present_state)
      s0 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b00; opc2_o = 2'b00; en_o = 1'b0; eoconv_o = 1'b1;
             if (start_i)
               next_state = s1;
           end

      s1 : begin
             stdac_o = 1'b1; stadc_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; en_o = 1'b0; eoconv_o = 1'b0;
             next_state = s2;
           end

      s2 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; en_o = 1'b0; eoconv_o = 1'b0;
             if (eodac_i)
               next_state = s3;
           end

      s3 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b10; opc2_o = 2'b01; en_o = 1'b0; eoconv_o = 1'b0;
             next_state = s4;
           end

      s4 : begin
             stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; en_o = 1'b0; eoconv_o = 1'b0;
			 next_state = s5;
           end

      s5 : begin
             stdac_o = 1'b0; stadc_o = 1'b1; opc1_o = 2'b01; opc2_o = 2'b01; en_o = 1'b0; eoconv_o = 1'b0;
			 next_state = s6;
	       end
	  
      s6 : begin
		     stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; en_o = 1'b0; eoconv_o = 1'b0;
		   	 if (eoadc_i)
			   next_state = s7;
			 end

      s7 : begin
		     stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b10; en_o = 1'b0; eoconv_o = 1'b0;
			 next_state = s8;
			 end			 
			 
      s8 : begin
		     stdac_o = 1'b0; stadc_o = 1'b0; opc1_o = 2'b01; opc2_o = 2'b01; en_o = 1'b1; eoconv_o = 1'b0;
		  	 if (z_i) begin
			   if (flag_i) begin
			     next_state = s0;
			   end else begin
			     next_state = s1;
			   end
			 end
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