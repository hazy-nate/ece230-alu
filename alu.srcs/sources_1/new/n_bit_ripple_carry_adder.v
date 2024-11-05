/*
n_bit_ripple_carry_adder.v

The ripple carry adder is used for addition as well as the two's complement
converter.

Authors: Nathaniel and Bayleigh
*/
module n_bit_ripple_carry_adder
#(
    parameter BIT_COUNT = 8
)
(
    input  [BIT_COUNT-1:0] a, b,
    output [BIT_COUNT-1:0] sum,
    output                 carry
);
    wire [BIT_COUNT-2:0] ripple_carry;
    
    genvar i;
    generate
        for (i = 0; i < BIT_COUNT; i = i + 1) begin
            if (i == 0) begin
                full_adder FA( .a(a[i]),
                               .b(b[i]),
                               .cin('b0),
                               .y(sum[i]),
                               .cout(ripple_carry[i]) );
            end else begin
                full_adder FA( .a(a[i]),
                               .b(b[i]),
                               .cin(ripple_carry[i-1]),
                               .y(sum[i]),
                               .cout(ripple_carry[i]) );
            end
        end
    endgenerate
    
    assign carry = ripple_carry[BIT_COUNT-1];
endmodule