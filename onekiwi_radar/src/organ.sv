module organ(
    input logic clk,
    input logic nrst,
    input logic [3:0] row,
    output logic [3:0] col,
    output logic bz,
    output logic pulse,
    output logic [7:0] seg,
    output logic [3:0] dig,
    output logic [7:0] led
);

    parameter MAX10HZ = 26'd2_699_999;
    parameter MAX50HZ  = 26'd539999  ;
    parameter MAX270HZ = 26'd99999   ;
    parameter MAX100KHZ = 26'd269;
    parameter PWM50HZ = 16'd1999;

    logic clk270hz, clk50hz, clk10hz, clk100khz;
    logic shift, pushed, done;

    logic [15:0] div;
    logic [15:0] psw;
    logic [2:0] act;
    logic [3:0] sw, a, b, c, d;
    logic [3:0][7:0] seg_in;
    logic [7:0] compare;
    logic [26:0] clk_count;
    logic up_down_flag;

    clkdiv clkdiv_1(.*, .max(MAX10HZ), .clk_out(clk10hz), .tc());
    clkdiv clkdiv_2(.*, .max(MAX50HZ), .clk_out(clk50hz), .tc());
    clkdiv clkdiv_3(.*, .max(MAX270HZ), .clk_out(clk270hz), .tc());
    clkdiv clkdiv_4(.*, .max(MAX100KHZ), .clk_out(clk100khz), .tc());

    pwm pwm_inst1 (.clk(clk100khz), .nrst(nrst), .period(PWM50HZ), .compare(compare), .line(pulse), .tc());

    matrix_key matrix_key_1 (.*, .clk(clk50hz), .key(psw), .tc(done));
    keyenc keyenc_1(.*, .psw(psw), .out(sw), .pushed(pushed)) ;
    keyedge keyedge_1(.*, .in(done), .rise(shift));

    decdiv decdiv_1(.sw(sw), .count(div));
    tonegen tonegen_1(.*, .key(pushed), .div({10'd0, div}), .bz(bz));

    ledact ledact_1(.*, .clk10hz(clk10hz), .act(act));
    orgled orgled_1(.in(act), .en(pushed), .led(led));

    shift_seg shift_seg_1(.*, .en(shift), .dec(sw), .a(a), .b(b), .c(c), .d(d));
    org7seg org7seg_1(.in(a), .en(pushed), .seg(seg_in[0])) ;
    org7seg org7seg_2(.in(b), .en(pushed), .seg(seg_in[1])) ;
    org7seg org7seg_3(.in(c), .en(pushed), .seg(seg_in[2])) ;
    org7seg org7seg_4(.in(d), .en(pushed), .seg(seg_in[3])) ;
      
    mux7seg mux7seg_1(.*, .clk(clk270hz));

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
endmodule