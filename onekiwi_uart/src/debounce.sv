module debounce(
    input logic clk,
    input logic nrst,
    input logic key_in,
    output logic key_out
);

    logic [3:0] key_n;
    
    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            key_n <= 4'b1111;
        end else begin
            key_out <= | key_in;
            key_n[3] <= key_n[2];
            key_n[2] <= key_n[1];
            key_n[1] <= key_n[0];
            key_n[0] <= key_in;
        end
    end

endmodule