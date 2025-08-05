module test_add4bit (
    input        clk,
    input        nrst,
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] seg,
    output [3:0] dig
);

    parameter MAX270HZ = 26'd99999;
    logic [3:0] sum;
    logic       co;
    logic [3:0][7:0] seg_in;
    logic       clk_270hz;

    clkdiv clkdiv_1 (.*, .max(MAX270HZ), .clk_out(clk_270hz), .tc());

    add4bit add4bit_1 (.*);

    drv7seg4 drv7seg4_1 (.in(a),         .dp(1'b0), .seg(seg_in[3]));
    drv7seg4 drv7seg4_2 (.in(b),         .dp(1'b0), .seg(seg_in[2]));
    drv7seg4 drv7seg4_3 (.in({3'b0, co}), .dp(1'b0), .seg(seg_in[1]));
    drv7seg4 drv7seg4_4 (.in(sum),       .dp(1'b0), .seg(seg_in[0]));

    mux7seg mux7seg_1 (
        .*,
        .clk(clk_270hz)
    );

endmodule : test_add4bit
