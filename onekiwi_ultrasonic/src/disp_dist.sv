module disp_dist(
    input   logic           clk,
    input   logic           nrst,
    input   logic [15:0]    measure,
    output  logic [7:0]     seg,
    output  logic [3:0]     dig
);

    parameter MAX270HZ = 26'd99_999;

    logic [15:0]        distance;
    logic [3:0][7:0]    seg_in;
    logic               clk270hz;

    clkdiv clkdiv_3 (.*, .max(MAX270HZ), .clk_out(clk270hz), .tc());

    always @ (negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            distance <= 16'd0;
        end else begin
            distance <= measure / 58;
        end
    end

    drv7seg4 drv7seg4_1(.in(distance % 10), .dp(1'b0), .seg(seg_in[0]));
    drv7seg4 drv7seg4_2(.in((distance / 10) % 10), .dp(1'b0), .seg(seg_in[1]));
    drv7seg4 drv7seg4_3(.in((distance / 100) % 10), .dp(1'b0), .seg(seg_in[2]));
    drv7seg4 drv7seg4_4(.in((distance / 1000) % 10), .dp(1'b0), .seg(seg_in[3]));

    mux7seg mux7seg_1(.*, .clk(clk270hz));
endmodule

//202508061354