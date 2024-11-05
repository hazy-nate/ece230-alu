/*
operation_multiplexer.v

The operation multiplexer chooses which operation to store in the Y register
based on a 4-bit selector signal.

Authors: Nathaniel and Bayleigh
*/

module operation_multiplexer
#(
    parameter BIT_COUNT = 8
)
(
    input     [BIT_COUNT-1:0] add_i,
                              sub_i,
                              shl_i,
                              shr_i,
                              cmp_i,
                              and_i,
                              or_i,
                              xor_i,
                              nand_i,
                              nor_i,
                              xnor_i,
                              inv_i,
                              neg_i,
   input      [3:0]           selector,
   input                      enable,
   output reg [BIT_COUNT-1:0] y,
   output reg                 store
);
    always @(*) begin
        if (enable) begin
            case(selector)
                0: begin
                    y <= add_i;
                    store <= 1;
                end
                1: begin
                    y <= sub_i;
                    store <= 1;
                end
                2: begin
                    y <= shl_i;
                    store <= 1;
                end
                3: begin
                    y <= shr_i;
                    store <= 1;
                end
                4: begin
                    y <= cmp_i;
                    store <= 1;
                end
                5: begin
                    y <= and_i;
                    store <= 1;
                end
                6: begin
                    y <= or_i;
                    store <= 1;
                end
                7: begin
                    y <= xor_i;
                    store <= 1;
                end
                8: begin
                    y <= nand_i;
                    store <= 1;
                end
                9: begin
                    y <= nor_i;
                    store <= 1;
                end
                10: begin
                    y <= xnor_i;
                    store <= 1;
                end
                11: begin
                    y <= inv_i;
                    store <= 1;
                end
                12: begin
                    y <= neg_i;
                    store <= 1;
                end
                default: begin
                    y <= 'bx;
                    store <= 0;
                end
            endcase
        end else begin
            y <= 'bx;
            store <= 0;
        end
    end    
endmodule