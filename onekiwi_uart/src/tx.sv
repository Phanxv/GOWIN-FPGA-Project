module tx (
    input logic clk,
    input logic nrst,
    input logic send,
    input logic [7:0] in,
    output logic txd,
    output logic busy
);

    parameter ST_IDLE = 1'd0;
    parameter ST_SENDING = 1'b1;
    logic state;
    logic [7:0] buffer;
    logic [7:0] mask;
    logic prev_send;

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            state <= ST_IDLE;
            buffer <= 8'd1;
            busy <= 1'b0;
            txd <= 1'b1;
            prev_send <= 1'b0;
        end else begin
            case(state)
            ST_IDLE:
                if({send, prev_send} == 2'b10) begin
                    buffer <= in;
                    txd <= 1'b0;
                    mask <= 8'd1;
                    busy <= 1'b1;
                    state <= ST_SENDING;
                end else begin
                    txd <= 1'b1;
                    busy <= 1'b0;
                end
            ST_SENDING:
                if(mask != 8'd0) begin
                    txd <= (mask & buffer) ? 1'b1 : 1'b0;
                    mask <= mask << 1;
                end else begin
                    txd <= 1'b1;
                    state <= ST_IDLE;
                end
            default:
                begin
                    state <= ST_IDLE;
                end
            endcase
            prev_send <= send;
        end
    end
endmodule