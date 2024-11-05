/*
unit_multiplexer.v

The unit multiplexer changes the values in the A and B registers depending on
the 4-bit selector signal.

Authors: Nathaniel and Bayleigh
*/
module unit_multiplexer
#(
    parameter BIT_COUNT = 8
)
(
    input      [BIT_COUNT-1:0] a_out, b_out, y_out, number,
    input      [3:0]           selector,
    input                      enable,
    output reg [BIT_COUNT-1:0] a_in, b_in,
    output reg                 store
);    
    always @(*) begin
        if (enable) begin
            case (selector)
                // Store Y in  A.
                13: begin
                    a_in <= y_out;
                    b_in <= b_out;
                    store <= 1;
                end
                // Swap A and B.
                14: begin
                    a_in <= b_out;
                    b_in <= a_out;
                    store <= 1;
                end
                // Store the input number in A
                15: begin
                    a_in <= number;
                    b_in <= b_out;
                    store <= 1;
                end
                // Don't do anything with A and B
                default: begin
                    a_in <= a_out;
                    b_in <= b_out;
                    store <= 1;
                end
            endcase
        end else begin
            a_in <= a_out;
            b_in <= b_out;
            store <= 1;
        end
    end
endmodule
