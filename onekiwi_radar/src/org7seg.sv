module org7seg (
    input logic [3:0] in,
    input logic en,
    output logic [7:0] seg
);

    logic [7:0] seg_w;

    drv7seg4 drv7seg4_1 (.in(in), .dp(en), .seg(seg_w));

    assign seg = (en == 1'b1) ? seg_w : 8'h00;

endmodule