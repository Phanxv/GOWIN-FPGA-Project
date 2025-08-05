module toggle(
    input logic clk,
    input logic nrst,
    input logic in,
    output logic out
);

    logic prev_in;

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin 
            out <= 1'b0;
            prev_in <= 1'b0;
        end else begin
            prev_in <= in;
            if( {prev_in, in} == 2'b10 ) begin
                out <= ~out;
            end
        end
    end

endmodule