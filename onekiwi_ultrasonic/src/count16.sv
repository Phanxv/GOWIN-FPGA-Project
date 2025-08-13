module count16(
    input   logic           clk,
    input   logic           nrst,
    output  logic [15:0]    count,
    output  logic           ov
);

    parameter MAX_VALUE = 16'hFFFF;

    always @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            ov <= 1'b0;
            count <= 16'd0;
        end else begin
            count <= count + 16'd1;
        end
    end

endmodule

//202508061401