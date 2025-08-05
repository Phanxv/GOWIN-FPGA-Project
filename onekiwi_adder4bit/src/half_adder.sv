module half_adder(
    input logic a,
    input logic b,
    output logic sum,
    output logic co
);

    assign sum = (!a & b) | (a & !b);
    assign co = a & b;

endmodule : half_adder