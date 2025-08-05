module test_mux7seg (
    input   logic       clk,
    input   logic [3:0] in,
    output  logic [7:0] seg,
    output  logic [3:0] dig
);
    parameter MAX270HZ = 26'd99_999;

    logic [3:0]         sum;
    logic               c;
    logic [3:0][7:0]    seg_in;
    logic               clk_270hz;
    logic [15:0]        counter;
    logic [27:0]        clk_counter;

    clkdiv clkdiv_inst1 (.clk(clk), .nrst(1'b1), .max(MAX270HZ), .clk_out(clk_270hz), .tc());

    always @(posedge clk) begin
        clk_counter <= clk_counter + 1;
        if (clk_counter == 13_500_000/2) begin
            clk_counter <= 0;
            counter <= counter + 1;
            if(counter == 16'hfff) begin
                counter <= 16'h0;
            end
        end
    end

    drv7seg4 drv7seg4_inst1 (.in(counter[3:0]),   .dp(1'b0), .seg(seg_in[0]));
    drv7seg4 drv7seg4_inst2 (.in(counter[7:4]),  .dp(1'b0), .seg(seg_in[1]));
    drv7seg4 drv7seg4_inst3 (.in(counter[11:8]),  .dp(1'b0), .seg(seg_in[2]));
    drv7seg4 drv7seg4_inst4 (.in(counter[15:12]),  .dp(1'b0), .seg(seg_in[3]));

    mux7seg mux7seg_inst1 (.*, .nrst(1'b1), .clk(clk_270hz));
endmodule : test_mux7seg