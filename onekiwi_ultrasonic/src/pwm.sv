module pwm (
    input logic clk,
    input logic nrst,
    input logic [15:0] period,
    input logic [15:0] compare,
    output logic line,
    output logic tc
);

    logic [15:0] count;

    always_ff @(posedge clk, negedge nrst) begin
        if(nrst == 1'b0)
            count <= 0;
        else begin
            if(tc)
                count <= 16'd0;
            else
                count <= count + 16'd1;
            if(count > compare)
                line <= 1'b0;
            else
                line <= 1'b1;
            if(count >= period)
                tc <= 1'b1;
            else
                tc <= 1'b0;
        end
    end
endmodule

//202508061114