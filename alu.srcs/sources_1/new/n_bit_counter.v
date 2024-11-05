/*
n_bit_counter.v

This file was what was originally used for the seven-segment scanner. However,
I rewrote that module to have that counting functionaly incorporated into it.
It made the logic easier that way.

Authors: Nathaniel and Bayleigh
*/
module n_bit_counter
#(
    parameter BIT_COUNT = 2,
              RESET_TO  = 2'b00
)
( 
    input                      clock, reset,
    output reg [BIT_COUNT-1:0] number
);
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            number <= RESET_TO;
        end else begin
            if (number)
                number <= number + 1;
        end
    end
endmodule