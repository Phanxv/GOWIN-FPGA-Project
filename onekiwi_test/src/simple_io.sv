module simple_io (
    input  logic [7:0] tsw0,
    output logic [7:0] led0
);

    assign led0 = ~tsw0;

endmodule : simple_io
