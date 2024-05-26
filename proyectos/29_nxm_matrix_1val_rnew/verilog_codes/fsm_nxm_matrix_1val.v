// Author: Julisa Verdejo Palacios
// Name: .v
//
// Description:

module fsm_nxm_matrix_1val (
  input             rst_i,
  input             clk_i,
  input             start_i,
  input             eodac_i,
  input             eoadc_i,
  input             zset_i,
  input             zleds_i,
  input       [1:0] count_row_i,
  input       [1:0] count_col_i,
  output reg        stdac_o,
  output reg        stadc_o,
  output reg        enset_o,
  output reg        enleds_o,
  output reg  [1:0] oprow_o,
  output reg  [1:0] opcol_o,
  output reg        eos_o
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
				   s10 = 4'b1010;

  reg [3:0] next_state, present_state;

  always @(start_i, eodac_i, eoadc_i, count_row_i, count_col_i, zset_i, zleds_i, present_state) begin
    stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b00; opcol_o = 2'b00; eos_o = 1'b1;
    next_state = present_state;
    case(present_state)
       s0: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b00; opcol_o = 2'b00; eos_o = 1'b1;
             if (start_i)
               next_state = s1;
           end

       s1: begin
             stdac_o = 1'b1; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
             next_state = s2;
           end

       s2: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
             if (eodac_i)
               next_state = s3;
           end 

       s3: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b1; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
             if (zset_i)
               next_state = s4;
           end

       s4: begin
             stdac_o = 1'b0; stadc_o = 1'b1; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
             next_state = s5;
           end

       s5: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
             if (eoadc_i)
               next_state = s6;
           end

       s6: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b1; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
             if (zleds_i)
               next_state = s7;
           end

       s7: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b10; eos_o = 1'b0;
             next_state = s8;
           end		  

       s8: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
			 if (count_col_i == 2) begin
               next_state = s9;
			 end else begin
			   next_state = s4;
			 end
           end

       s9: begin
             stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b10; opcol_o = 2'b00; eos_o = 1'b0;
             next_state = s10;
           end

      s10: begin
            stdac_o = 1'b0; stadc_o = 1'b0; enset_o = 1'b0; enleds_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
			if (count_row_i == 2) begin
              next_state = s0;
			end else begin
			  next_state = s4;
			end
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