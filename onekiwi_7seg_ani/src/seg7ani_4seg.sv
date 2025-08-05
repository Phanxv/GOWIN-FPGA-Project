module seg7ani_4seg(
    input logic clk,
    output logic [7:0] seg,
    output logic [3:0] dig,
    output logic clk_led
);
    
    parameter MAX16HZ = 26'd1_687_500;
    logic clk_16HZ;
    logic [3:0] count; 
    logic [11:0] decoded_val;
    clkdiv clkdiv_inst1(.clk(clk), .nrst(1'b1), .max(MAX16HZ), .clk_out(clk_16HZ), .tc());
    
    always @(posedge clk_16HZ) begin
        if(count == 4'd11) begin
            count <= 4'd0;
        end else begin
            count <= count + 1'b1;    
        end
        clk_led = ~clk_led;
    end
    
    function [11:0] decode;
        input logic [3:0] in;
        begin
            case (in)
                'd0: decode = {4'b0111, 8'b0111_1111};
                'd1: decode = {4'b1011, 8'b0111_1111};
                'd2: decode = {4'b1101, 8'b0111_1111};
                'd3: decode = {4'b1110, 8'b0111_1111};
                'd4: decode = {4'b1110, 8'b1011_1111};
                'd5: decode = {4'b1110, 8'b1101_1111};
                'd6: decode = {4'b1110, 8'b1110_1111};
                'd7: decode = {4'b1101, 8'b1110_1111};
                'd8: decode = {4'b1011, 8'b1110_1111};
                'd9: decode = {4'b0111, 8'b1110_1111};
                'd10: decode = {4'b0111, 8'b1111_0111};
                'd11: decode = {4'b0111, 8'b1111_1011};
                default: decode = 8'b1111_1111;
            endcase
        end
    endfunction : decode

    assign decoded_val = decode(count);
    assign seg = ~decoded_val[7:0];
    assign dig = decoded_val[11:8];
    
endmodule