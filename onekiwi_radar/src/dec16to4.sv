module dec16to4(
    input logic [15:0] key,
    output logic [3:0] out,
    output pushed
);

    function [4:0] f;
        input [15:0] in;
        case(in)
        16'h0001: f = { 1'b1, 4'h0 };
        16'h0002: f = { 1'b1, 4'h1 };
        16'h0004: f = { 1'b1, 4'h2 };
        16'h0008: f = { 1'b1, 4'h3 };
        16'h0010: f = { 1'b1, 4'h4 };
        16'h0020: f = { 1'b1, 4'h5 };
        16'h0040: f = { 1'b1, 4'h6 };
        16'h0080: f = { 1'b1, 4'h7 };
        16'h0100: f = { 1'b1, 4'h8 };
        16'h0200: f = { 1'b1, 4'h9 };
        16'h0400: f = { 1'b1, 4'hA };
        16'h0800: f = { 1'b1, 4'hB };
        16'h1000: f = { 1'b1, 4'hC };
        16'h2000: f = { 1'b1, 4'hD };
        16'h4000: f = { 1'b1, 4'hE };
        16'h8000: f = { 1'b1, 4'hF };
        default: f = { 1'b0, 4'h0 };
        endcase
    endfunction

    assign { pushed, out } = f(key);
 
endmodule