/*
t_flip_flop.v

Authors: Nathaniel and Bayleigh
*/
module t_flip_flop
(
    input      reset, clock,
    output reg q,
    output     not_q
);
    assign not_q = ~q;
    
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= ~q;
        end
    end
endmodule