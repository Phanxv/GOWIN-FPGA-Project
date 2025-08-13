module pwm_test3(
    input logic clk,
    input logic nrst,
    input logic [3:0] tsw,
    output logic led
);

    parameter MAX100HZ = 26'd26999;
    parameter NINE = 4'd9;
    parameter LED_ON = 1'b0;
    parameter LED_OFF = 1'b1;

    logic [3:0] cnt100hz;
    logic clk100hz;

    clkdiv clkdiv_inst1 (.*, .max(MAX100HZ), .clk_out(), .tc(clk100hz));
    
    cntr4max cntr4max_inst1 (.*, .max(NINE), .up(clk100hz), .cnt(cnt100hz), .tc());
    
    
    assign led = (cnt100hz < tsw) ? LED_ON : LED_OFF;

endmodule
//202508061017