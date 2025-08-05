module counter4bit(
    input logic clk,
    input logic nrst,
    output logic [3:0] count,
    output logic tc
);

    logic [3:0] d;

    dff4 dff4_inst1(.*, .q(count));

    assign d = count + 4'd1;
    assign tc = (count == 4'hf) ? 1'b1 : 1'b0;

endmodule