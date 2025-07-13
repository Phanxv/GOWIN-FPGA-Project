module counter
(
    input btn1,
    input btn2,
    output [5:0]leds
);

reg[5:0] led_reg;
assign leds = ~led_reg;
assign count = !btn1;
assign reset = !btn2;
always @(posedge count, posedge reset)
    if(reset)
        led_reg <= 0;
    else
        led_reg <= led_reg + 1; 
endmodule
