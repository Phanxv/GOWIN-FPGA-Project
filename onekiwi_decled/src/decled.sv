module decled (
    input logic [3:0] in,
    output logic [7:0] led
);

    function [7:0] decode;
        input logic [3:0] in;
        begin
            case (in)
                4'h0: decode = 8'b1111_1111;
                4'h1: decode = 8'b1111_1110;
                4'h2: decode = 8'b1111_1100;
                4'h3: decode = 8'b1111_1001;
                4'h4: decode = 8'b1111_0011;
                4'h5: decode = 8'b1110_0111;
                4'h6: decode = 8'b1100_1111;
                4'h7: decode = 8'b1001_1111;
                4'h8: decode = 8'b0011_1111;
                4'h9: decode = 8'b0111_1111;
                default: decode = { 4'b0101, ~in };
            endcase
        end
    endfunction : decode

    assign led = decode(in);
endmodule : decled