module cdma (
  input       clk_i,
  input       rst_i,
  input       signal_i,
  input [4:0] seed_i, 
  input       receptor_i,
  input 	  load_i,
  output      cdma_o,
  output      gold_o,
  output      receptor_o,
  output      led_o
); 

  reg [4:0] data1;
  reg [4:0] data2;
  wire [4:0] data1_next;
  wire [4:0] data2_next;
  wire aux1;
  wire aux2;
  wire [4:0] mux1;
  wire [4:0] mux2;
  
  assign aux1 = data1[4] ^ data1[3] ^ data1[2] ^ data1[1];
  assign aux2 = data2[4] ^ data2[1];
  
  assign data1_next = {data1[3:0], aux1};
  assign data2_next = {data2[3:0], aux2};
  
  assign mux1 = (load_i == 1'b1) ? seed_i : data1_next;
  assign mux2 = (load_i == 1'b1) ? seed_i : data2_next;
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      data1 <= 5'b00000;
    end else begin
      data1 <= mux1; 
    end
  end

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      data2 <= 5'b00000; 
    end else begin
      data2 <= mux2;
    end
  end

  assign led_o  = (seed_i !== 5'b00000) ? 1'b0 : 1'b1;
  assign gold_o = data1[4] ^ data2[4];
  assign cdma_o = signal_i ^ gold_o;
  assign receptor_o = receptor_i ^ gold_o;
  
endmodule
