module stopwatch(
    input logic nrst,
    input logic clk,
    input logic btn,
    output logic [7:0] seg,
    output logic [7:0] led,
    output logic [3:0] dig
);

    parameter MAX100HZ = 26'd269_999;
    parameter MAX270HZ = 26'd99_999;
    parameter MAX400HZ = 26'd168_749;
    parameter NINE = 4'd9;
    parameter FIVE = 4'd5;
    parameter EIGHT = 4'd8;

    logic psw, en, nen;
    logic clk100hz, clk10hz, clk1s, clk10s;
    logic [3:0] cnt100hz, cnt10hz, cnt1s, cnt10s;
    logic clk400hz;
    logic clk270hz;

    logic [3:0][7:0] seg_in;

    assign nen = ~en;

    clkdiv clkdiv_inst1(.*, .max(MAX100HZ), .clk_out(), .tc(clk100hz));
    clkdiv clkdiv_inst2(.*, .max(MAX400HZ), .clk_out(), .tc(clk400hz));
    clkdiv clkdiv_inst3(.*, .max(MAX270HZ), .clk_out(clk270hz), .tc());

    debounce debounce_inst1(.*, .clk(clk400hz), .key_in(btn), .key_out(psw));
    toggle toggle_inst1(.*, .in(psw), .out(en));

    cntr4maxe cntr4maxe_inst1(.*, .up(clk100hz), .max(NINE), .cnt(cnt100hz), .tc(clk10hz));
    cntr4max cntr4max_inst1(.*, .up(clk10hz), .max(NINE), .cnt(cnt10hz), .tc(clk1s));
    cntr4max cntr4max_inst2(.*, .up(clk1s), .max(NINE), .cnt(cnt1s), .tc(clk10s));
    cntr4max cntr4max_inst3(.*, .up(clk10s), .max(FIVE), .cnt(cnt10s), .tc());

    decled decled_inst1(.in(cnt10hz), .led(led));
    drv7seg4 drv7seg4_inst1(.in(cnt100hz), .dp(en), .seg(seg_in[0]));
    drv7seg4 drv7seg4_inst2(.in(cnt10hz), .dp(1'b0), .seg(seg_in[1]));
    drv7seg4 drv7seg4_inst3(.in(cnt1s), .dp(1'b1), .seg(seg_in[2]));
    drv7seg4 drv7seg4_inst4(.in(cnt10s), .dp(1'b0), .seg(seg_in[3]));
    
    mux7seg mux7seg_inst1(.*, .clk(clk270hz));
    
endmodule