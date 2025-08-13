module pwm_servo_auto(
    input logic clk,
    input logic nrst,
    input logic [3:0] psw,
    output logic pulse,
    output logic [7:0] led
);

    parameter MAX100KHZ = 26'd269;
    parameter PWM50HZ = 16'd1999;
    parameter PWM_MIN = 16'd60;
    parameter PWM_POS2 = 16'd100;
    parameter PWM_POS3 = 16'd160;
    parameter PWM_MAX = 16'd230;
    
    logic clk100khz;
    logic [7:0] compare;
    logic [26:0] clk_count;
    logic up_down_flag;

    clkdiv clkdiv_inst1 (.*, .max(MAX100KHZ), .clk_out(clk100khz), .tc());
    
    pwm pwm_inst1 (.clk(clk100khz), .nrst(nrst), .period(PWM50HZ), .compare(compare), .line(pulse), .tc());

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0) begin
            up_down_flag <= 1'b0;
            compare <= 8'd60;
        end
        else begin 
            if(clk_count == 27'd269_999) begin
                clk_count <= 0;
                if(compare == 8'd231) begin
                    up_down_flag <= 1'b1; // start counting down
                    compare <= compare - 8'b1;
                end else if(compare == 8'd59) begin
                    up_down_flag <= 1'b0; // start counting up
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
//202508061320