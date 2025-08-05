module mux7seg (
    input   logic           clk,
    input   logic           nrst,
    input   logic [3:0][7:0]    seg_in,
    output  logic [7:0]     seg,
    output  logic [3:0]     dig
);

    logic [1:0] col;
    always @(negedge nrst or posedge clk) begin
        if (nrst == 1'b0) begin
            col <= 2'd0;
        end else begin 
            if (col >= 2'd3) begin
                col <= 2'd0;
            end else begin
                col <= col + 2'd1;
            end
            case (col)
                2'd0: {dig, seg} <= {4'b1110, seg_in[0]};
                2'd1: {dig, seg} <= {4'b1101, seg_in[1]};
                2'd2: {dig, seg} <= {4'b1011, seg_in[2]};
                2'd3: {dig, seg} <= {4'b0111, seg_in[3]};
            endcase
        end
    end
endmodule : mux7seg