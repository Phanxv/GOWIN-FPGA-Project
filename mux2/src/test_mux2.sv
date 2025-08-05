module test_mux2 (
    input logic a, b, sel,
    output logic a_out, b_out, out
);
    
    logic n_out;
    assign a_out = ~a;
    assign b_out = ~b;
    assign out = ~n_out;

    mux2 mux2_inst1(.a(a), .b(b), .sel(sel), .out(n_out));
    
endmodule : test_mux2