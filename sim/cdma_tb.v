`timescale 1us/1ns //Declaración de la escala de tiempo para las pausas #
module cdma_tb( ); //El testbench es un modulo especial sin puertos de entrada o salida
    //Testbench variables
    reg clk_i=0;
    reg rst_i;
    reg signal_i=1;
    reg [4:0] seed_i =5'b00000; 
    reg receptor_i=0;
	reg load_i;
    wire cdma_o;
    wire gold_o;
    wire receptor_o;
    wire led_o;
    //Instantiate the DUT
    cdma cdma_dut(
        .clk_i(clk_i),
		.rst_i(rst_i),
		.signal_i(signal_i),
		.seed_i(seed_i), 
		.receptor_i(receptor_i),
	    .load_i(load_i),
		.cdma_o(cdma_o),
		.gold_o(gold_o),
		.receptor_o(receptor_o),
		.led_o(led_o)
    );
    //Create the clock signal
    always begin #0.5 clk_i = ~clk_i; end

    always begin #32 signal_i = ~signal_i; end //Espera 1 ciclo de la carga de la semilla

    always begin #0.001 receptor_i = cdma_o; end

    //Create stimulus
    initial begin
		#1; rst_i = 1; //Initializes the FlipFlops with 0.
		#1.3; rst_i=0;   //stop the reset
        #1; seed_i=4'b1101; //Set the seed into the LFSR
		#1; load_i= 1;
        #1.3; //Realease the load
        load_i = 0;
    end
    //This will stop the simulator when the time expires
    initial begin
        #63 $stop;
    end
endmodule