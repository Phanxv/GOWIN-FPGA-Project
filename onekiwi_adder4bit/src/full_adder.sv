module full_adder(
    input   logic ci,
    input   logic a,
    input   logic b,
    output  logic sum,
    output  logic co
);
    assign sum = (!ci & !a & b) | (!ci &  a & !b) | (ci & !a & !b) | (ci & a & b) ;
    assign co  = (!ci &  a & b) | ( ci & !a &  b) | (ci &  a & !b) | (ci & a & b) ;
endmodule