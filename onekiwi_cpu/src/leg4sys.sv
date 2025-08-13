module leg4sys (
    input logic clk,
    input logic nrst,
    input logic [3:0] tsw,
    input logic [1:0] c_sel,
    input logic psw0,
    output logic bz,
    output logic [7:0] led,
    output logic [7:0] seg,
    output logic [3:0] dig
);
    
    parameter MAX1HZ = 26'd26_999_999;
    parameter MAX10HZ = 26'd2_699_999;
    parameter MAX270HZ = 26'd99_999;
    parameter MAX400HZ = 26'd67_499;
    parameter MAX1KHZ = 26'd26_900;

    logic co, leg4_clk, manual_clk;
    logic tc10hz, tc1hz, tc1khz;
    logic clk1khz, clk400hz, clk10hz, clk1hz;
    logic [7:0] seg_a, seg_b, seg_c, seg_d;
    logic [3:0] address;
    logic [7:0] rom_out;
    logic [3:0] out;
    logic clk270hz;
    logic [3:0][7:0] seg_in;

    function clksel;
        input [1:0] sw;
        case (sw)
            2'd3: clksel = clk1khz;
            2'd2: clksel = clk10hz;
            2'd1: clksel = clk1hz;
            2'd0: clksel = manual_clk; 
        endcase
    endfunction

    assign led[7] = ~co;
    assign led[6:4] = 3'b111;
    assign led[3:0] = ~out;

    assign leg4_clk = clksel(c_sel);
    assign bz = clk1khz & out[3];

    clkdiv clkdiv_1(.*, .max(MAX400HZ), .clk_out(clk400hz), .tc());
    debounce debounce_1(.*, .clk(clk400hz), .key_in(psw0), .key_out(manual_clk));

    clkdiv clkdiv_2(.*, .max(MAX10HZ), .clk_out(clk10hz), .tc());
    clkdiv clkdiv_3(.*, .max(MAX1HZ), .clk_out(clk1hz), .tc());

    leg4 leg_1(.clk(leg4_clk), .nrst(nrst), .mem(rom_out), .in(tsw[3:0]), .a(), .b(), .out(out), .co(co), .adr(address));

    clkdiv clkdiv_4(.*, .max(MAX1KHZ), .clk_out(clk1khz), .tc());

    leg4_rom leg4_rom_1(.address(address), .out(rom_out));

    drv7seg4 drv7seg4_1 (.in(address), .dp(1'b0), .seg(seg_in[3])) ;
    drv7seg4 drv7seg4_2 (.in(rom_out[7:4]), .dp(1'b0), .seg(seg_in[2])) ;
    drv7seg4 drv7seg4_3 (.in(rom_out[3:0]), .dp(1'b0), .seg(seg_in[1])) ;
    drv7seg4 drv7seg4_4 (.in(out), .dp(co), .seg(seg_in[0])) ;

    clkdiv clkdiv_5(.*, .max(MAX270HZ), .clk_out(clk270hz), .tc()) ;

    mux7seg mux7seg_1(.*, .clk(clk270hz));
endmodule