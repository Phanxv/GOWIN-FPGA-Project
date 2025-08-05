module simple_io_ex1(
    input logic tws0,
    output logic led0
);

    assign led0 = !tws0;

endmodule : simple_io_ex1