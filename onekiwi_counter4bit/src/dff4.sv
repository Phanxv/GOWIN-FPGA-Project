module dff4(
    input   logic           clk,
    input   logic           nrst,
    input   logic   [3:0]   d,
    output  logic   [3:0]   q
);

    always @(posedge clk or negedge nrst) begin
        if(nrst == 1'b0) begin
            q <= 4'd0;
        end else begin
            q <= d;
        end
    end
endmodule