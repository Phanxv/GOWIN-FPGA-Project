module pwm_test2(
    input logic clk,
    input logic nrst,
    output logic [7:0] led
);

    parameter MAX100HZ = 26'd26999;
    parameter NINE = 4'd9;
    parameter LED_ON = 1'b0;
    parameter LED_OFF = 1'b1;

    logic [3:0] cnt100hz;
    logic clk100hz;

    clkdiv clkdiv_inst1 (.*, .max(MAX100HZ), .clk_out(), .tc(clk100hz));
    
    cntr4max cntr4max_inst1 (.*, .max(NINE), .up(clk100hz), .cnt(cnt100hz), .tc());
    
    assign led[0] = (cnt100hz < 1) ? LED_ON : LED_OFF;
    assign led[1] = (cnt100hz < 2) ? LED_ON : LED_OFF;
    assign led[2] = (cnt100hz < 3) ? LED_ON : LED_OFF;
    assign led[3] = (cnt100hz < 4) ? LED_ON : LED_OFF;
    assign led[4] = (cnt100hz < 5) ? LED_ON : LED_OFF;
    assign led[5] = (cnt100hz < 6) ? LED_ON : LED_OFF;
    assign led[6] = (cnt100hz < 7) ? LED_ON : LED_OFF;  
    assign led[7] = (cnt100hz < 8) ? LED_ON : LED_OFF;

endmodule
//202508061008