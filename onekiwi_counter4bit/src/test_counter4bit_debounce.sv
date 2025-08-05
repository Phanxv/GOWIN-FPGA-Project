module test_counter4bit_debounce(
    input logic clk,
    input logic nrst,
    input logic key_in,
    output logic [7:0] seg,
    output logic [3:0] dig
);
    parameter MAX400HZ = 26'd67499;
    
    logic key_out, key_clk;
    logic [3:0] count;
    logic tc;
    logic clk_400hz;

    assign key_clk = ~key_out;
    assign dig = 4'b1110;

    clkdiv clkdiv_inst1(.*, .max(MAX400HZ), .clk_out(clk_400hz), .tc());
    
    debounce debounce_inst1(.*, .clk(clk_400hz), .key_in(key_in), .key_out(key_out));
    
    counter4bit counter4bit_1 (.nrst(nrst), .clk(key_clk), .count(count), .tc(tc)) ;

    drv7seg4 drv7seg4_inst1(.in(count), .dp(tc), .seg(seg));

endmodule