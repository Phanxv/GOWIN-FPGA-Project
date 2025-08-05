module simple_io_ex2(
    input logic [7:0] tws,
    output logic [7:0] led
);

    assign led = ~tws;

endmodule : simple_io_ex2