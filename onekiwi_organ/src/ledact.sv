module ledact(
    input logic clk,
    input logic nrst,
    input logic clk10hz,
    output logic [2:0] act
);

    logic prev;

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            act <= 3'd0;
        end else begin
            if({prev, clk10hz} == 2'b01) begin
                act <= act + 3'd1;
            end
            prev <= clk10hz;
        end
    end
endmodule