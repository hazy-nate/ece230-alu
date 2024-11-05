/*
twos_compliment_converter.v

This is a two's complement converter which can accept any vector of arbitrary
size as long as the BIT_COUNT parameter is set. This module uses the ripple
carry adder.

Authors: Nathaniel and Bayleigh
*/
module twos_complement_converter
#(
    parameter BIT_COUNT = 8
)
(
    input  [BIT_COUNT-1:0] a,
    output [BIT_COUNT-1:0] y
);  
    wire [BIT_COUNT-1:0] one = 1;
    wire [BIT_COUNT-1:0] negated_a = ~a; 
    
    n_bit_ripple_carry_adder #(.BIT_COUNT(BIT_COUNT)) n_bit_ripple_carry_adder(
        // Input
        .a(negated_a),
        .b(one),
        // Output
        .sum(y)
    );
endmodule
