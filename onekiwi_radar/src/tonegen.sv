module tonegen(
    input logic clk,
    input logic nrst,
    input logic key,
    input logic [25:0] div,
    output logic bz
);

    logic [25:0] count;

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            count <= 26'd0;
            bz <= 1'b0;
        end else begin
            if(key == 1'b0) begin
                count <= 26'd0;
                bz <= 1'b0;
            end else begin
                if(count == div) begin
                    count <= 26'd0;
                    bz <= ~bz;
                end else begin
                    count <= count + 26'd1;
                end
            end
        end
    end

endmodule