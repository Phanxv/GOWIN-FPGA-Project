module test_matrix_key (
    input logic clk,
    input logic nrst,
    input logic [3:0] row,
    output logic [3:0] col,
    output logic [7:0] seg,
    output logic [3:0] dig,
    output logic ready
); 

    logic [15:0] key;
    logic [3:0] value;
    logic clk50hz;
    logic dp;

    parameter MAX50HZ = 26'd539999;
    
    assign dig = 4'b1110;

    clkdiv clkdiv_inst1(.*, .max(MAX50HZ), .clk_out(clk50hz), .tc());

    matrix_key matrix_key_inst1(.*, .clk(clk50hz), .tc(ready));

    dec16to4 dec16to4_inst1(.*, .out(value), .pushed(dp));
    
    drv7seg4 drv7seg4_inst1(.*, .in(value));

endmodule