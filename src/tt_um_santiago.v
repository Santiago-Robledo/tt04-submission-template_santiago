`default_nettype none

module tt_um_santiago #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Configurar bidireccional como salidas
  assign uio_oe = 8'b11111111;
  
  // Mandar todos los leds a cero
  assign uo_out[7:0] = 8'b00000000;
  
  //Mandar bits restantes a cero
  assign uio_out[7:4] = 4'b0000;
  
  cdma mod_cdma ( 
	.clk_i(clk),
    .rst_i(~rst_n),
    .signal_i(ui_in[0]),
    .seed_i(ui_in[5:1]),
    .receptor_i(ui_in[6]),
	.load_i(ui_in[7]),
    .cdma_o(uio_out[0]),
    .gold_o(uio_out[1]),
    .receptor_o(uio_out[2]),
    .led_o(uio_out[3])
  );
  
endmodule
