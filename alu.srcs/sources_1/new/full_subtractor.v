/*
full_subtractor.v

This is a simple full subtractor.

Authors: Nathaniel and Bayleigh
*/
module full_subtractor
(
    input  a, b, bin,
    output d, bout
);
    assign d    = a ^ b ^ bin;
    assign bout = (~a & b) | (bin & (~a ^ b));
endmodule