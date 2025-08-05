module top_module (
    input i_clk_27mhz, dp,
    output reg [7:0] seg ,
    output [3:0] dig
);
    reg [3:0] counter;
    reg [27:0] clk_counter;

    assign dig = 4'b0000;

    always @(posedge i_clk_27mhz) begin
        clk_counter <= clk_counter + 1;
        if (clk_counter == 13_500_000) begin
            clk_counter <= 0;
            counter <= counter + 1;
            if(counter == 4'hf) begin
                counter <= 4'h0;
            end
        end
    end
    drv7seg4 drv7seg4_inst1(.in(counter), .dp(~dp), .seg(seg));

endmodule