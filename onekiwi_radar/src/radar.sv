module radar (
     input logic clk,
     input logic nrst,
     input logic echo,
     output logic trigger,
     output logic pulse,
     output logic bz,
     output logic [7:0] seg,
     output logic [3:0] dig,
    output logic [7:0] led
);

    parameter MAX1MHZ = 26'd26 ; 
    parameter MAX5HZ  = 26'd199_999 ; 
    parameter MAX100KHZ = 26'd269;
    parameter MAX_SERVO_SPEED = 27'd539_999;
    parameter PWM50HZ = 16'd1999; 

    parameter ST_IDLE = 2'd0  ; 
    parameter ST_GEN_TRIGGER    = 2'd1 ;
    parameter ST_WAIT_ECHO_RISE = 2'd2 ;
    parameter ST_WAIT_ECHO_FALL = 2'd3 ;

    parameter SERVO_MAX = 8'd230;
    parameter SERVO_MIN = 8'd60;
   
    logic           clk_1mhz ;
    logic           pls_5hz ;
    logic           count_nrst ;
    logic [1:0]     state = 2'd0 ;
    logic [15:0]    count ;
    logic [15:0]    measure ;
    logic [3:0]     trig_count ;
    logic           overflow;
    logic clk100hz;
    logic bz_activate;
    logic [15:0] div;
    logic [15:0] distance;
    logic clk100khz;
    logic [7:0] compare;
    logic [26:0] clk_count;
    logic up_down_flag;

    clkdiv clkdiv_1 (.clk(clk), .nrst(nrst), .max(MAX1MHZ), .clk_out(clk_1mhz), .tc()) ;
    clkdiv clkdiv_2 (.clk(clk_1mhz), .nrst(nrst), .max(MAX5HZ), .clk_out(), .tc(pls_5hz)) ;
    
    count16 count16_1 (.clk(clk_1mhz), .nrst(count_nrst), .count(count), .ov(overflow)) ;
    clkdiv clkdiv_3 (.*, .max(MAX100KHZ), .clk_out(clk100khz), .tc());
    pwm pwm_inst1 (.clk(clk100khz), .nrst(nrst), .period(PWM50HZ), .compare(compare), .line(pulse), .tc());

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

    assign distance = measure / 58;
    assign div = 860 + (((distance - 1) * 37790) / 99);
    assign bz_activate = (distance < 8'd100) ? 1'b1 : 1'b0;
    
    tonegen tonegen_1(.*, .key(bz_activate), .div({10'd0, div}), .bz(bz));

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            up_down_flag <= 1'b0;
            compare <= 8'd60;
        end
        else begin 
            if(clk_count == MAX_SERVO_SPEED) begin
                clk_count <= 0;
                if(compare == SERVO_MAX + 1'b1) begin
                    up_down_flag <= 1'b1; 
                    compare <= compare - 8'b1;
                end else if(compare == SERVO_MIN - 1'b1) begin
                    up_down_flag <= 1'b0; 
                    compare <= compare + 8'b1;
                end else begin
                    if(up_down_flag == 1'b0)
                        compare <= compare + 8'b1;
                    else
                        compare <= compare - 8'b1;
                end 
            end else 
                clk_count <= clk_count + 26'b1;
        end
    end
    
    assign led = compare;
endmodule

//202508061417