module orgled(
    input logic [2:0] in,
    input logic en,
    output logic [7:0] led
);

    function [7:0] f ;
        input logic [3:0] in;
        begin
            case(in)
            3'h0: f = 8'b1111_1110;
            3'h1: f = 8'b1111_1101;
            3'h2: f = 8'b1111_1011;
            3'h3: f = 8'b1111_0111;
            3'h4: f = 8'b1110_1111;
            3'h5: f = 8'b1101_1111;
            3'h6: f = 8'b1011_1111;
            3'h7: f = 8'b0111_1111;
            endcase
        end
    endfunction

    assign led = (en == 1'b1) ? f(in) : 8'b1111_1111;

endmodule