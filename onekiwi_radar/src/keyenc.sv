module keyenc(
    input logic clk,
    input logic nrst,
    input logic [15:0] psw,
    output logic [3:0] out,
    output logic pushed
);

    logic [3:0] key_code;

    dec16to4 dec16to4_1 (.key(psw), .out(key_code), .pushed(pushed));

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            out <= 4'd0;
        end else begin
            if(pushed == 1'b1) begin
                out <= key_code;
            end
        end
    end
endmodule