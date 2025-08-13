module shift_seg (
    input logic clk,
    input logic nrst,
    input logic en,
    input logic [3:0] dec,
    output logic [3:0] a, b, c, d
);

    always_ff @( negedge nrst or posedge clk ) begin
        if (!nrst) begin
            a <= 4'b0;
            b <= 4'b0;
            c <= 4'b0;
            d <= 4'b0;
        end else if (en) begin
            a <= dec;
            b <= a;
            c <= b;
            d <= c;
        end
    end

endmodule