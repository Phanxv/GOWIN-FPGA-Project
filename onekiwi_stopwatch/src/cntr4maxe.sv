module cntr4maxe(
    input logic clk,
    input logic nrst,
    input logic en,
    input logic up,
    input logic [3:0] max,
    output logic [3:0] cnt,
    output logic tc
);

    logic reach, active;

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            cnt <= 4'b0;
        end else begin
            if(active == 1'b1) begin
                if(tc == 1'b1) begin
                    cnt <= 4'd0;
                end else begin
                    cnt <= cnt + 4'd1;
                end
            end
        end
    end

    assign reach = (cnt > max);
    assign active = (en == 1'b1) && (up == 1'b1);
    assign tc = active && reach;

endmodule