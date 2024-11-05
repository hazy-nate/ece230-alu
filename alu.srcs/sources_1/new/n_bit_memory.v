/*
n_bit_register.v

Authors: Nathaniel and Bayleigh
*/
module n_bit_memory
#(
    parameter BIT_COUNT = 8
)
(
    input      [BIT_COUNT-1:0] data,
    input                      clock, store, reset,
    output reg [BIT_COUNT-1:0] memory
);
    always @(posedge clock or posedge reset) begin
        if (reset)
            memory <= 0;
        else if (store)
            memory <= data;
    end
endmodule