module pwm_servo(
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
    logic [15:0] compare;
    
    assign led = { psw[3], psw[3], psw[2], psw[2], psw[1], psw[1], psw[0], psw[0] };

    clkdiv clkdiv_inst1 (.*, .max(MAX100KHZ), .clk_out(clk100khz), .tc());
    
    pwm pwm_inst1 (.clk(clk100khz), .nrst(nrst), .period(PWM50HZ), .compare(compare), .line(pulse), .tc());

    always_ff @(negedge nrst or posedge clk) begin
        if(nrst == 1'b0)
            compare <= 16'd100;
        else begin 
            case(psw)
            4'b0111: compare <= PWM_MIN;
            4'b1011: compare <= PWM_POS2;
            4'b1101: compare <= PWM_POS3;
            4'b1110: compare <= PWM_MAX;
            default: compare <= compare;
            endcase
        end
    end

endmodule
//202508061122