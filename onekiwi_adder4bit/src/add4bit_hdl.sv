module add4bit_hdl (
    input   logic   [3:0]   a,
    input   logic   [3:0]   b,
    input   logic   [3:0]   sum,
    output  logic   co
);

    assign {co, sum} = {1'b0, a} + {1'b0, b};
    
endmodule