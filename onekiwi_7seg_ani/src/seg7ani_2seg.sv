module seg7ani_2seg(
    input logic clk,
    output logic [7:0] seg,
    output logic [3:0] dig,
    output logic clk_led
);
    
    parameter MAX8HZ = 26'd3_375_000;
    logic clk_8HZ;
    logic [2:0] count;
    logic [11:0] decoded_val;
    clkdiv clkdiv_inst1(.clk(clk), .nrst(1'b1), .max(MAX8HZ), .clk_out(clk_8HZ), .tc());
    
    always @(posedge clk_8HZ) begin
        if(count == 3'd7) begin
            count <= 3'd0;
        end else begin
            count <= count + 1'b1;    
        end
        clk_led = ~clk_led;
    end
    
    function [11:0] decode;
        input logic [2:0] in;
        begin
            case (in)
                3'd0: decode = {4'b1101, 8'b0111_1111};
                3'd1: decode = {4'b1110, 8'b0111_1111};
                3'd2: decode = {4'b1110, 8'b1011_1111};
                3'd3: decode = {4'b1110, 8'b1101_1111};
                3'd4: decode = {4'b1110, 8'b1110_1111};
                3'd5: decode = {4'b1101, 8'b1110_1111};
                3'd6: decode = {4'b1101, 8'b1111_0111};
                3'd7: decode = {4'b1101, 8'b1111_1011};
                default: decode = 8'b1111_1111;
            endcase
        end
    endfunction : decode

    assign decoded_val = decode(count);
    assign seg = ~decoded_val[7:0];
    assign dig = decoded_val[11:8];
    
endmodule