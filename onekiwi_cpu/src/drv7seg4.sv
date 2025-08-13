module drv7seg4 (
    input   logic [3:0]   in,
    input   logic         dp,
    output  logic [7:0]   seg
);

    function [6:0] f ;
        input [3:0] in;
        begin
            case (in)
            4'h0: f = 7'h7E;
            4'h1: f = 7'h30;
            4'h2: f = 7'h6d;
            4'h3: f = 7'h79;
            4'h4: f = 7'h33;
            4'h5: f = 7'h5B;
            4'h6: f = 7'h5F;
            4'h7: f = 7'h70;
            4'h8: f = 7'h7F;
            4'h9: f = 7'h7B;
            4'hA: f = 7'h77;
            4'hB: f = 7'h1F;
            4'hC: f = 7'h4E;
            4'hD: f = 7'h3D;
            4'hE: f = 7'h4F;
            4'hF: f = 7'h47;
            endcase
        end
    endfunction : f

    assign seg = { f(in), dp };
endmodule : drv7seg4