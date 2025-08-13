module rx(
    input logic clk2x,
    input logic nrst,
    input logic rxd,
    output logic [7:0] data,
    output logic ready
);

    parameter ST_IDLE = 2'd0;
    parameter ST_RECEIVING = 2'd1;
    parameter ST_WAIT_STOP = 2'd2;
    logic [1:0] state;
    logic [7:0] work;
    logic [7:0] mask;
    logic [4:0] count;
    logic prev_rxd;

    always_ff @(negedge nrst or posedge clk2x) begin
        if(nrst == 1'b0) begin
            state <= ST_IDLE;
            ready <= 1'b0;
            prev_rxd <= 1'b1;
        end else begin
            case(state)
                ST_IDLE : begin
                    if({rxd, prev_rxd} == 2'b01) begin
                        work <= 8'h00;
                        mask <= 8'h01;
                        ready <= 1'b0;
                        count <= 5'd0;
                        state <= ST_RECEIVING;
                    end
                end
                ST_RECEIVING : begin
                    if(count[0] == 1'b1) begin
                        if(mask == 8'd0) begin
                            count <= 5'd0;
                            state <= ST_WAIT_STOP;
                        end else if (rxd == 1'b1) begin
                            work <= work | mask;
                        end
                        mask <= mask << 3'd1;
                    end
                    count <= count + 5'd1;
                end
                ST_WAIT_STOP : begin
                    if(count[0] == 1'b1) begin
                        if(rxd == 1'b1) begin
                            data <= work;
                            ready <= 1'b1;
                            state <= ST_IDLE;
                        end
                    end else if(count >= 5'd20) begin
                        ready <= 1'b0;
                        state <= ST_IDLE;
                    end
                    count <= count + 5'd1;
                end
                default: begin
                    ready <= 1'b0;
                    state <= ST_IDLE;
                end
            endcase
            prev_rxd <= rxd;
        end
    end
endmodule