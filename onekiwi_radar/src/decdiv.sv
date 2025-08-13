module decdiv(
    input logic [3:0] sw,
    output logic [16:0] count
);

    function [16:0] decode;
        input [3:0] sw;
        case (sw)
            'h0: decode = 'd38656;
            'h1: decode = 'd34438;
            'h2: decode = 'd30681;
            'h3: decode = 'd27333;
            'h4: decode = 'd25799;
            'h5: decode = 'd22984;
            'h6: decode = 'd20477;
            'h7: decode = 'd19327;
            'h8: decode = 'd17219;
            'h9: decode = 'd15340;
            'hA: decode = 'd13666;
            'hB: decode = 'd12899;
            'hC: decode = 'd11492;
            'hD: decode = 'd10238;
            'hE: decode = 'd9663;
            'hF: decode = 'd8609;
        endcase
    endfunction

    assign count = decode(sw);
    
endmodule