module matrix_key_input (
    input  logic        clk,
    input  logic        nrst,
    input  logic [3:0]  row,
    output logic [3:0]  col,
    output logic [7:0]  seg,
    output logic [3:0]  dig,

    output logic [7:0]  final_value
);

    // Internal signals
    logic [15:0] key;
    logic [3:0]  value;
    logic        dp;
    logic        clk50hz;
    logic        pushed;
    logic pushed_prev;
    logic [3:0]  first_num, second_num;
    logic        state;

    parameter MAX50HZ = 26'd539999;

    assign dig = 4'b1110;

    // Instantiate clock divider
    clkdiv clkdiv_inst1(
        .clk(clk),
        .nrst(nrst),
        .max(MAX50HZ),
        .clk_out(clk50hz),
        .tc()
    );

    // Instantiate matrix key
    matrix_key matrix_key_inst1(
        .clk(clk50hz),
        .nrst(nrst),
        .row(row),
        .col(col),
        .key(key),
        .tc(ready)
    );

    // Instantiate decoder
    dec16to4 dec16to4_inst1(
        .key(key),
        .out(value),
        .pushed(pushed)
    );

    // Instantiate 7-segment driver
    drv7seg4 drv7seg4_inst1(
        .in(value),
        .dp(dp),
        .seg(seg)
    );

    // FSM for input sequence
    always_ff @(posedge clk50hz or negedge nrst) begin
        if (!nrst) begin
            first_num   <= 4'd0;
            second_num  <= 4'd0;
            final_value <= 8'd0;
            state       <= 1'b0;
            dp          <= 1'b0;
            pushed_prev <= 1'b0;
        end else begin
            pushed_prev <= pushed;
            if (pushed && !pushed_prev) begin // Detect positive edge
                if (!state) begin
                    first_num <= value;
                    state     <= 1'b1;
                    dp        <= 1'b1;
                end else begin
                    second_num  <= value;
                    final_value <= (first_num * 8'd10) + second_num;
                    state       <= 1'b0;
                    dp          <= 1'b0;
                end
            end
        end
    end
    
endmodule