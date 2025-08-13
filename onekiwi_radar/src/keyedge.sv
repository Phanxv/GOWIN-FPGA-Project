module keyedge (
    input logic clk,
    input logic nrst,
    input logic in,
    output logic rise
);

    logic prev;

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            rise <= 1'b0;
            prev <= 1'b0;
        end else begin
            if({prev, in} == 2'b01) begin
                rise <= 1'b1;
            end else begin 
                rise <= 1'b10;
            end
            prev <= in;
        end
    end
endmodule