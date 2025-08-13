module pwm_test1(
    input logic clk,
    input logic nrst,
    output logic [3:0] led
);

    parameter MAX100HZ = 26'd26999;
    parameter NINE = 4'd9;
    parameter LED_ON = 1'b0;
    parameter LED_OFF = 1'b1;
    
    logic [3:0] cnt1khz, cnt100hz, cnt10hz, cnt1s, cnt10s;
    logic clk1khz, clk100hz, clk10hz, clk1s, clk10s;
    
    clkdiv clkdiv_inst1(.*, .max(MAX100HZ), .clk_out(), .tc(clk100hz));

    cntr4max cntr4max_inst1(.*, .max(NINE), .up(clk100hz), .cnt(cnt100hz), .tc(clk10hz));
    cntr4max cntr4max_inst2(.*, .max(NINE), .up(clk10hz), .cnt(cnt10hz), .tc(clk1s));
    cntr4max cntr4max_inst3(.*, .max(NINE), .up(clk1s), .cnt(cnt1s), .tc(clk10s));
    cntr4max cntr4max_inst4(.*, .max(NINE), .up(clk10s), .cnt(cnt10s), .tc());

    assign led[0] = (cnt100hz < 5) ? LED_ON : LED_OFF;
    assign led[1] = (cnt10hz < 5) ? LED_ON : LED_OFF;
    assign led[2] = (cnt1s < 5) ? LED_ON : LED_OFF;
    assign led[3] = (cnt10s < 5) ? LED_ON : LED_OFF;

endmodule

//202508060956