module cdma (
  input       clk_i,
  input       set_i,
  input       signal_i,
  input [3:0] seed_i, 
  input       receptor_i,
  output      cdma_o,
  output      gold_o,
  output      receptor_o,
  output      led_o
); 

  reg [4:0] data1;
  reg [4:0] data2;
 
  always @(posedge clk_i, negedge set_i) begin
    if (~set_i) begin
      data1[4:0] <= {seed_i, seed_i[0]};
    end else begin
      data1[4:0] <= {data1[3:0], (data1[4] ^ data1[3] ^ data1[2] ^ data1[1]) }; 
    end
  end

  always @(posedge clk_i, negedge set_i) begin
    if (~set_i) begin
      data2[4:0] <= {seed_i, seed_i[0]}; 
    end else begin
      data2[4:0] <= {data2[3:0], (data2[4] ^ data2[1]) };
    end
  end

  assign led_o  = (seed_i) ? 1'b0 : 1'b1;
	assign cdma_o = signal_i ^ gold_o;
  assign gold_o = data1[4] ^ data2[4];
  assign receptor_o = receptor_i ^ gold_o;
  
endmodule
