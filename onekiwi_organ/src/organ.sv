module organ(
    input logic clk,
    input logic nrst,
    input logic [3:0] row,
    output logic [3:0] col,
    output logic bz,
    output logic [7:0] seg,
    output logic [3:0] dig,
    output logic [7:0] led
);

    parameter MAX10HZ = 26'd2_699_999;
    parameter MAX50HZ  = 26'd539999  ;
    parameter MAX270HZ = 26'd99999   ;

    logic clk270hz, clk50hz, clk10hz;
    logic shift, pushed, done;

    logic [15:0] div;
    logic [15:0] psw;
    logic [2:0] act;
    logic [3:0] sw, a, b, c, d;
    logic [3:0][7:0] seg_in;

    clkdiv clkdiv_1(.*, .max(MAX10HZ), .clk_out(clk10hz), .tc());
    clkdiv clkdiv_2(.*, .max(MAX50HZ), .clk_out(clk50hz), .tc());
    clkdiv clkdiv_3(.*, .max(MAX270HZ), .clk_out(clk270hz), .tc());

    matrix_key matrix_key_1 (.*, .clk(clk50hz), .key(psw), .tc(done));
    keyenc keyenc_1(.*, .psw(psw), .out(sw), .pushed(pushed)) ;
    keyedge keyedge_1(.*, .in(done), .rise(shift));

    decdiv decdiv_1(.sw(sw), .count(div));
    tonegen tonegen_1(.*, .key(pushed), .div({10'd0, div}), .bz(bz));

    ledact ledact_1(.*, .clk10hz(clk10hz), .act(act));
    orgled orgled_1(.in(act), .en(pushed), .led(led));

    shift_seg shift_seg_1(.*, .en(shift), .dec(sw), .a(a), .b(b), .c(c), .d(d));
    org7seg org7seg_1(.in(a), .en(pushed), .seg(seg_in[0])) ;
    org7seg org7seg_2(.in(b), .en(pushed), .seg(seg_in[1])) ;
    org7seg org7seg_3(.in(c), .en(pushed), .seg(seg_in[2])) ;
    org7seg org7seg_4(.in(d), .en(pushed), .seg(seg_in[3])) ;
      
    mux7seg mux7seg_1(.*, .clk(clk270hz));
endmodule