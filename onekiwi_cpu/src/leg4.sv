module leg4 (
    input logic clk, nrst,
    input logic [7:0] mem,
    input logic [3:0] in,
    output logic [3:0] a, b, out,
    output logic co,
    output logic [3:0] adr
);

    logic [3:0] data;
    logic wa, wb, wo, jump, alu_co;

    always_ff @( negedge nrst or posedge clk ) begin 
        if (nrst == 1'b0) begin
            a <= 4'd0;
            b <= 4'd0;
            out <= 4'd0;
            co <= 1'b0;
        end else begin
            if(wa == 1'b1) a <= data;
            if(wb == 1'b1) b <= data;
            if(wo == 1'b1) out <= data;
            co <= alu_co;
        end        
    end

    pc pc_1(.*, .in(data));
    alu alu_1(
        .*,
        .cmd(mem[7:4]),
        .ci(co),
        .imd(mem[3:0]),
        .in(in),
        .co(alu_co)
    );
    
endmodule