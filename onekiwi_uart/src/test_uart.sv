module test_uart (
    input  logic    clk,    
    input  logic    nrst, 
    input  logic [7:0] tx_data,
    input  logic    send,  
    input  logic    rxd, // FPGA_RX 
    output logic    txd, // FPGA_TX
    output logic [7:0] led,
    output logic [7:0] seg,
    output logic [3:0] dig
 ) ;

    parameter MAXBAUD   = 26'd233   ; // (27MHz / 115200) - 1
    parameter MAXBAUDX2 = 26'd116   ; // (27MHz / (115200 x 2)) - 1
    parameter MAX400HZ  = 26'd67499 ; // (27MHz / 400) - 1
    parameter MAX270HZ  = 26'd99999 ; // (27MHz / 270) - 1

    logic tx_busy;
    logic data_ready;
    logic clkbaud, clkbaudx2, clk400hz;
    logic clk270;
    logic tx_send;
    logic [7:0] rx_data;
    logic [3:0][7:0] seg_in;

    assign led = ~tx_data;

    clkdiv clkdiv_1 (.*, .max(MAXBAUD),   .clk_out(clkbaud), .tc()) ; // for tx
    clkdiv clkdiv_2 (.*, .max(MAXBAUDX2), .clk_out(clkbaudx2), .tc()) ; // for rx
    clkdiv clkdiv_3 (.*, .max(MAX400HZ), .clk_out(clk400hz), .tc()) ; 
    clkdiv clkdiv_4 (.*, .max(MAX270HZ), .clk_out(clk270hz), .tc()) ;

    debounce debounce_1 (.clk(clk400hz), .nrst(nrst), .key_in(send), .key_out(tx_send)) ;

    tx tx_1 (.clk(clkbaud), .nrst(nrst), .send(tx_send), .in(tx_data), .txd(txd), .busy(tx_busy)) ;

    rx rx_1 (.clk2x(clkbaudx2), .nrst(nrst), .rxd(rxd), .data(rx_data), .ready(data_ready)) ;

    drv7seg4 drv7seg4_1 (.in(rx_data[7:4]), .dp(1'b0), .seg(seg_in[3])) ;
    drv7seg4 drv7seg4_2 (.in(rx_data[3:0]), .dp(1'b0), .seg(seg_in[2])) ;
    drv7seg4 drv7seg4_3 (.in(tx_data[7:4]), .dp(1'b0), .seg(seg_in[1])) ;
    drv7seg4 drv7seg4_4 (.in(tx_data[3:0]), .dp(1'b0), .seg(seg_in[0])) ;
    mux7seg mux7seg_1 (.*, .clk(clk270hz)) ;

endmodule : test_uart