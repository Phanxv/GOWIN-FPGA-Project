localparam ADAI = 4'b0000;
localparam MVAB = 4'b0001;
localparam INA = 4'b0010;
localparam MVAI = 4'b0011;
localparam MVBA = 4'b0100;
localparam ADBI = 4'b0101;
localparam INB = 4'b0110;
localparam MVBI = 4'b0111;
localparam OUTB = 4'b1001;
localparam OUTI = 4'b1011;
localparam JNCI = 4'b1110;
localparam JMPI = 4'b1111;

module alu (
    input logic nrst,
    input logic [3:0] cmd,
    input logic ci,
    input logic [3:0] imd,
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [3:0] in,
    output logic wa,
    output logic wb,
    output logic wo,
    output logic jump,
    output logic co, 
    output logic [3:0] data
);

    function [4:0] cmd_dec;
        input [3:0] cmd, a, b, in, imd;
        begin
            case (cmd)
                ADAI: cmd_dec = a + imd;
                MVAB: cmd_dec = {1'b0, b};
                INA: cmd_dec = {1'b0, in};
                MVAI: cmd_dec = {1'b0, imd};
                ADBI: cmd_dec = b + imd;
                MVBA: cmd_dec = {1'b0, a};
                INB: cmd_dec = {1'b0, in};
                MVBI: cmd_dec = {1'b0, imd};
                OUTB: cmd_dec = {1'b0, b};
                OUTI: cmd_dec = {1'b0, imd};
                JNCI: cmd_dec = {1'b0, imd};
                JMPI: cmd_dec = {1'b0, imd};
                default: cmd_dec = 5'b00000;
            endcase 
        end
    endfunction
    
    always_comb begin
        if (nrst == 1'b0) begin
            {co, data} <= 5'd0;
            {wa, wb, wo, jump} <= 4'b0000;
        end else begin
            {co, data} <= cmd_dec(cmd, a, b, in, imd);
            wa <= (cmd inside {ADAI, MVAB, INA, MVAI});
            wb <= (cmd inside {ADBI, MVBA, INB, MVBI});
            wo <= (cmd inside {OUTB, OUTI});
            jump <= (cmd == JMPI) | ((ci == 1'b0) && (cmd == JNCI));
        end
    end
endmodule