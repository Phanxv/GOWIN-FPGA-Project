module mux2 (
    input logic a, b, sel,
    output logic out
);

    assign out = (sel == 0) ? a : b;

endmodule : mux2