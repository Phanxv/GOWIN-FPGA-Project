module seg7ani(
    input logic clk,
    output logic [7:0] seg,
    output logic [3:0] dig,
    output logic clk_led
);
    
    parameter MAX8HZ = 26'd3_375_000;
    logic clk_8HZ;
    logic [2:0] count; 
    assign dig = 4'b1110;
    clkdiv clkdiv_inst1(.clk(clk), .nrst(1'b1), .max(MAX8HZ), .clk_out(clk_8HZ), .tc());
    
    always @(posedge clk_8HZ) begin
        if(count == 3'd5) begin
            count <= 3'd0;
        end else begin
            count <= count + 1'b1;    
        end
        clk_led = ~clk_led;
    end
    
    function [7:0] decode;
        input logic [2:0] in;
        begin
            case (in)
                3'd0: decode = 8'b0111_1111;
                3'd1: decode = 8'b1011_1111;
                3'd2: decode = 8'b1101_1111;
                3'd3: decode = 8'b1110_1111;
                3'd4: decode = 8'b1111_0111;
                3'd5: decode = 8'b1111_1011;
                default: decode = 8'b1111_1111;
            endcase
        end
    endfunction : decode

    assign seg = ~decode(count);
    
endmodule