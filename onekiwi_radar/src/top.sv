module top (
     input logic clk,
     input logic nrst,
     input logic echo,
     output logic trigger,
     output logic [7:0] seg,
     output logic [3:0] dig
);

     parameter MAX1MHZ = 26'd26 ; // (27MHz / 1MHz) - 1
     parameter MAX5HZ  = 26'd199999 ; // (200ms / 1us) - 1
     parameter ST_IDLE = 2'd0  ;
     parameter ST_GEN_TRIGGER    = 2'd1 ;
     parameter ST_WAIT_ECHO_RISE = 2'd2 ;
     parameter ST_WAIT_ECHO_FALL = 2'd3 ;

    logic           clk_1mhz ;
    logic           pls_5hz ;
    logic           count_nrst ;
    logic [1:0]     state = 2'd0 ;
    logic [15:0]    count ;
    logic [15:0]    measure ;
    logic [3:0]     trig_count ;
    logic           overflow;

    clkdiv clkdiv_1 (.clk(clk), .nrst(nrst), .max(MAX1MHZ), .clk_out(clk_1mhz), .tc()) ;
    clkdiv clkdiv_2 (.clk(clk_1mhz), .nrst(nrst), .max(MAX5HZ), .clk_out(), .tc(pls_5hz)) ;

    count16 count16_1 (.clk(clk_1mhz), .nrst(count_nrst), .count(count), .ov(overflow)) ;

    disp_dist disp_dist_1(.*, .measure(measure)) ;

    always @(negedge nrst or posedge clk_1mhz) begin
        if(nrst == 1'b0) begin
            state <= 2'd0;
            count_nrst <= 1'b0;
            measure <= 16'd0;
            trigger <= 1'b0;
            trig_count <= 4'd0;
        end else begin
            case(state)
            ST_IDLE:
                if(pls_5hz == 1'b1) begin
                    count_nrst <= 1'b0;
                    trigger <= 1'b0;
                    trig_count <= 4'd0;
                    state <= ST_GEN_TRIGGER;
                end
            ST_GEN_TRIGGER:
                if(trig_count < 4'd10) begin
                    trigger <= 1'b1;
                    trig_count <= trig_count + 4'd1;
                end else begin
                    trigger <= 1'b0;
                    state <= ST_WAIT_ECHO_RISE;
                end
            ST_WAIT_ECHO_RISE:
                if(echo == 1'b1) begin
                    count_nrst <= 1'b1;
                    state <= ST_WAIT_ECHO_FALL;
                end
            ST_WAIT_ECHO_FALL:
                if(overflow == 1'b1) begin
                    state <= ST_IDLE;
                end else begin
                    if(echo == 1'b0) begin
                        measure <= count;
                        state <= ST_IDLE;
                    end
                end
            endcase
        end
    end

endmodule

//202508061417