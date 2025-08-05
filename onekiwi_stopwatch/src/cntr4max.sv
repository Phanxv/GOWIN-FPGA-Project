module cntr4max(
    input logic clk,
    input logic nrst,
    input logic up,
    input logic [3:0] max,
    output logic [3:0] cnt,
    output logic tc
);

    assign tc = up & (cnt >= max);

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            cnt <= 4'b0;
        end else begin
            if(up == 1'b1) begin
                if(tc == 1'b1) begin
                    cnt <= 4'd0;
                end else begin
                    cnt <= cnt + 4'd1;
                end
            end
        end
    end

endmodule