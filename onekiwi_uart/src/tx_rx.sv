module tx_rx (
    input logic [7:0] tdata,
    input logic clk,
    input logic clk2x,
    input logic nrst,
    input logic send,
    output logic [7:0] rdata,
    output logic rxd,
    output logic busy,
    output logic ready
);

    tx tx_1(.*, .in(tdata));
    
    rx rx_1(.*, .rxd(txd), .data(rdata));

endmodule