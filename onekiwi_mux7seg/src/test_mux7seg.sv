module test_mux7seg (
    input   logic       clk,
    input   logic [3:0] in,
    output  logic [7:0] seg,
    output  logic [3:0] dig
);
    parameter MAX270HZ = 26'd99999;

    logic [3:0]         sum;
    logic               c;
    logic [3:0][7:0]    seg_in;
    logic               clk_270hz;

    clkdiv clkdiv_inst1 (.clk(clk), .nrst(1'b1), .max(MAX270HZ), .clk_out(clk_270hz), .tc());

    drv7seg4 drv7seg4_inst1 (.in(in),   .dp(1'b0), .seg(seg_in[3]));
    drv7seg4 drv7seg4_inst2 (.in(in+4'd1),  .dp(1'b0), .seg(seg_in[2]));
    drv7seg4 drv7seg4_inst3 (.in(in+4'd2),  .dp(1'b0), .seg(seg_in[1]));
    drv7seg4 drv7seg4_inst4 (.in(in+4'd3),  .dp(1'b0), .seg(seg_in[0]));

    mux7seg mux7seg_inst1 (.*, .nrst(1'b1), .clk(clk_270hz));
endmodule : test_mux7seg