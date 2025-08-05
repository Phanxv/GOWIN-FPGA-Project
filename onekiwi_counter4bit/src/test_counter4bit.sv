module test_counter4bit(
    input logic nclk,
    input logic nrst,
    output logic [7:0] seg,
    output logic [3:0] dig
);

    logic [3:0] count;
    logic tc;
    logic clk;

    assign clk = ~nclk;
    assign dig = 4'b1110;

    counter4bit counter4bit_inst1(.*);

    drv7seg4 drv7seg4_inst1(.in(count), .dp(tc), .seg(seg));

endmodule