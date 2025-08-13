module matrix_key(
    input logic clk,
    input logic nrst,
    input logic [3:0] row,
    output logic [3:0] col,
    output logic [15:0] key,
    output logic tc
);

    logic [15:0] tmp;
    logic [2:0] index;
    
    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            tmp <= 16'hFFFF;
            key <= 16'h0000;
            index <= 3'd0;
        end else begin
            if(index[0] == 1'b0) begin
                if(index == 3'd0)
                    tc <= 1'b1;
                else
                    tc <= 1'b0;
                case(index[2:1])
                2'd0: begin 
                      col <= 4'b1110;
                      key <= ~tmp;
                      tmp <= 16'hFFFF;
                      end
                2'd1: col <= 4'b1101;
                2'd2: col <= 4'b1011;
                2'd3: col <= 4'b0111;
                endcase
            end else begin
                tmp[{2'd0, index[2:1]}] <= row[0];
                tmp[{2'd1, index[2:1]}] <= row[1];
                tmp[{2'd2, index[2:1]}] <= row[2];
                tmp[{2'd3, index[2:1]}] <= row[3];
            end
            index <= index + 3'd1;
        end
    end
endmodule