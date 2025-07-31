module top_module (
    input wire  clk,
    output wire [5:0] led_output
);

    logic [5:0] led = 6'd0;
    logic       overflow;
    logic [2:0] counter = 'd0;
    logic       flag;
    assign      led_output = ~led;

    always_ff @( posedge clk ) begin
        if(overflow) begin
            if(counter == 'd5) begin
                flag <= ~flag;
                counter <= 'd0;
            end
            if(flag == 1) begin
                led <= {led[4:0], 1'd0};
            end else begin
                led <= {led[4:0], 1'd1};
            end
            counter <= counter + 1;
        end        
    end

    timer #(
        .COUNT_MAX (13500000)
    ) inst_0 (
        .clk      (clk),
        .overflow (overflow)
    );

endmodule