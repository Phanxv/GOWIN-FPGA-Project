module test_gate(
    input logic a,
    input logic b,
    output logic [7:0] leds
);

    logic and_out, or_out, not_a_out, not_b_out;
    logic xor_out, nand_out, nor_out, xnor_out;

    gates gates_inst1(.*);

    assign leds[7] = ~and_out;
    assign leds[6] = ~or_out;
    assign leds[5] = ~xor_out;
    assign leds[4] = 1'b1;
    assign leds[3] = ~not_a_out;
    assign leds[2] = ~nand_out;
    assign leds[1] = ~nor_out;
    assign leds[0] = ~xnor_out;

endmodule : test_gate