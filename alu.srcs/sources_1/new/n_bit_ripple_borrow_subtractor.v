/*
n_bit_ripple_borrow_subtractor.v

The ripple borrow subtractor is used for the subtraction operation.

Authors: Nathaniel and Bayleigh
*/
module n_bit_ripple_borrow_subtractor
#(
    parameter BIT_COUNT = 8
)
(
    input  [BIT_COUNT-1:0] a, b,
    output [BIT_COUNT-1:0] difference,
    output                 borrow
);
    wire [BIT_COUNT-2:0] ripple_borrow;
    
    genvar i;
    generate
        for (i = 0; i < BIT_COUNT; i = i + 1) begin
            if (i == 0) begin
                full_subtractor FS( .a(a[i]),
                                    .b(b[i]),
                                    .bin('b0),
                                    .d(difference[i]),
                                    .bout(ripple_borrow[i]) );
            end else begin
                full_subtractor FS( .a(a[i]),
                                    .b(b[i]),
                                    .bin(ripple_borrow[i-1]),
                                    .d(difference[i]),
                                    .bout(ripple_borrow[i]) );
            end
        end
    endgenerate
    
    assign borrow = ripple_borrow[BIT_COUNT-1];
endmodule