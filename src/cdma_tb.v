`timescale 1ns / 100 ps
`include "cdma.v"

module cdma_tb();
  // Definición de señales de entrada y salida
  reg       clk;
  reg       set;
  reg       signal;
  reg [3:0] seed;
  reg       rin;
  wire      cdma;
  wire      gold;
  wire      rout;
  wire      led;
  
  // Instanciacion del modulo
  cdma dut (
    .clk_i(clk),
    .set_i(set),
    .signal_i(signal),
    .seed_i(seed), 
    .receptor_i(rin),
    .cdma_o(cmda),
    .gold_o(gold),
    .receptor_o(rout),
    .led_o(led)
  ); 

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;
  
  initial begin
    clk = 0; set = 0; signal = 1; seed = 4'b1010; rin = 1; #10;
             set = 1;                                      #10;
  end

  initial begin
    // Salida de simulacion y variables de salida
    $dumpfile("cdma_tb.vcd");
    $dumpvars(0,cdma_tb);
  
    #500;
 
    // Terminar simulacion
    $display("Test completed");
    $finish;
  end

endmodule
