module add4bit (
    input   logic   [3:0]  a, b,
    output  logic   [3:0]  sum, 
    output  logic          co
);

    logic   [3:0]   c;

    half_adder half_adder_inst1(.a(a[0]), .b(b[0]), .sum(sum[0]), .co(c[0]));
    full_adder full_adder_inst1(.a(a[1]), .b(b[1]), .ci(c[0]), .sum(sum[1]), .co(c[1]));
    full_adder full_adder_inst2(.a(a[2]), .b(b[2]), .ci(c[1]), .sum(sum[2]), .co(c[2]));
    full_adder full_adder_inst3(.a(a[3]), .b(b[3]), .ci(c[2]), .sum(sum[3]), .co(co));
endmodule