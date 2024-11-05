/*
full_adder.v

This is a simple full adder.

Authors: Nathaniel and Bayleigh
*/
module full_adder
(
    input  a, b, cin,
    output y, cout
);
    assign y    = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule