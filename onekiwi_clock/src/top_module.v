module top_module (
    input i_clk_27mhz,
    output reg [7:0] o_leds
);
    reg [27:0] clk_counter;
    reg [3:0] counter;
    reg flag = 1'b1;

    always @(posedge i_clk_27mhz) begin
        clk_counter <= clk_counter + 1;
        if (clk_counter == 3_375_000) begin
            clk_counter <= 0;
            counter <= counter + 1;
            if(counter == 4'd3) begin
                counter <= 4'd0;
                flag <= ~flag;
            end
            o_leds <= {flag, o_leds[7:1]};
        end
    end

endmodule