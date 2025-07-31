module test_drv7seg4 (
    input   [3:0]   in,
    input   [3:0]   sel,
    input           dp,
    output  [7:0]   seg,
    output  [7:0]   led,
    output  [3:0]   dig
);
    
    drv7seg4 drv7seg4_inst1 (.*, .dp(~dp));
    
    assign dig = sel;

    assign led[3:0] = ~in;
    assign led[7:4] = sel;

endmodule : test_drv7seg4