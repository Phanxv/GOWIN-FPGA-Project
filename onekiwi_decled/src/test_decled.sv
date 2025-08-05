module test_decled(
    input logic [3:0] in,
    input logic dp,
    output logic [7:0] seg,
    output logic [7:0] led,
    output logic [3:0] dig
);

    assign dig = 4'b1110;
    
    decled decled_inst1(.*);

    drv7seg4 drv7seg4_inst1(.*);

endmodule