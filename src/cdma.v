module cdma (
    input clk_i,
    input set_i,
    input signal_i,
    input [3:0] Seed_i, //4 Inputs
    input receptor_i,   // Will be set as input.
    output CDMA_o,
    output Gold_o,
    output receptor_o,
    output reg LED_o
    ); 
//8 inputs and 4 outputs
//Internal N bits wide register
    reg [4:0] data1;
    reg [4:0] data2;
//Suport Variables
    wire Gold;
    wire CDMA;
    reg C_Buff;
//First Register Data  
    always @(posedge clk_i or negedge set_i) begin
        if (!set_i) begin
            data1[4:0] <={Seed_i,Seed_i[0]}; //Loads the seed
        end else begin
            //The output is data1[4], the input is data1[0], [1 2 3 4 5] or [0 1 2 3 4]
            data1 [4:0] <= {data1[3:0], (data1[4] ^ data1[3] ^ data1[2] ^ data1[1])}; 
        end
    end
//Second register data
    always @(posedge clk_i or negedge set_i) begin
        if (!set_i) begin
            data2 [4:0] <= {Seed_i,Seed_i[0]}; //Loads the seed
        end else begin
            //The output is data2[4], the input is data2[0], [1 2 3 4 5] or [0 1 2 3 4]
            data2 [4:0] <= {data2[3:0], (data2[4] ^ data2[1])};
        end
    end
//LED indicator
    always @(*) begin
       if (!Seed_i) begin
            LED_o = 0;
       end else begin
            LED_o = 1;
       end
    end
	
//Suport assignments
	assign Gold = data1[4] ^ data2[4]; //Valid support
	assign CDMA = signal_i ^ Gold;

//Outputs assignment
	assign CDMA_o = CDMA;
    assign Gold_o = Gold;
    assign receptor_o = receptor_i ^ Gold;
endmodule
