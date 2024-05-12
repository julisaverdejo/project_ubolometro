// Author: Julisa Verdejo Palacios
// Name: .v
//
// Description:

module fsm_led_matrix (
  input             rst_i,
  input             clk_i,
  input             start_i,
  input             eodac_i,
  input       [1:0] count_row_i,
  input       [1:0] count_col_i,
  input             z_i,
  output reg        stdac_o,
  output reg        en_o,
  output reg  [1:0] oprow_o,
  output reg  [1:0] opcol_o,
  output reg        eos_o
);

  localparam [2:0] s0 = 3'b000,
                   s1 = 3'b001,
                   s2 = 3'b010,
				   s3 = 3'b011,
				   s4 = 3'b100,
				   s5 = 3'b101,
				   s6 = 3'b110,
				   s7 = 3'b111;

  reg [2:0] next_state, present_state;

  always @(start_i, eodac_i, count_row_i, count_col_i, z_i, present_state) begin
    stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b00; opcol_o = 2'b00; eos_o = 1'b1;
    next_state = present_state;
    case(present_state)
      s0: begin
            stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b00; opcol_o = 2'b00; eos_o = 1'b1;
            if (start_i)
              next_state = s1;
          end

      s1: begin
            stdac_o = 1'b1; en_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
            next_state = s2;
          end

      s2: begin
            stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
            if (eodac_i)
              next_state = s3;
          end 

      s3: begin
            stdac_o = 1'b0; en_o = 1'b1; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
            if (z_i)
              next_state = s4;
          end

      s4: begin
            stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b10; eos_o = 1'b0;
            next_state = s5;
          end

      s5: begin
            stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
			if (count_col_i == 2) begin
              next_state = s6;
			end else begin
			  next_state = s3;
			end
          end

      s6: begin
            stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b10; opcol_o = 2'b00; eos_o = 1'b0;
            next_state = s7;
          end

      s7: begin
            stdac_o = 1'b0; en_o = 1'b0; oprow_o = 2'b01; opcol_o = 2'b01; eos_o = 1'b0;
			if (count_row_i == 2) begin
              next_state = s0;
			end else begin
			  next_state = s3;
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