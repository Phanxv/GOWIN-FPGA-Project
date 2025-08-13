module pc (
    input logic clk,
    input logic nrst,
    input logic jump,
    input logic [3:0] in,
    output logic [3:0] adr
);
    
    always_ff @( negedge nrst or posedge clk ) begin : pc
        if (nrst == 1'b0) begin
            adr <= 4'h0;
        end else begin
            if (jump) begin
                adr <= in;
            end else begin
                adr <= adr + 4'h1;
            end
        end
    end
    
endmodule