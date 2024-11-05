/*
ttf_clock_divider.v

Author: Nathaniel and Bayleigh
*/
module ttf_clock_divider
#(
    parameter BIT_COUNT = 17
)
(
    input  clock, reset,
    output divided_clock 
);
    /*
    Parameters: BIT_COUNT By default, the BIT_COUNT is set to 17
                          because that creates an approximate
                          clock signal for driving our seven-segment
                          display.
    */
    
    wire [BIT_COUNT-1:0] ttf_chain;
    
    genvar i;
    generate
        for (i = 0; i < BIT_COUNT; i = i + 1) begin
            if (i == 0) begin
                t_flip_flop t_flip_flop(
                    .reset(reset),
                    .clock(clock),
                    .q(ttf_chain[i])
                );
            end else begin
                t_flip_flop t_flip_flop(
                    .reset(reset),
                    .clock(ttf_chain[i-1]),
                    .q(ttf_chain[i])
                );
            end
        end
    endgenerate
    
    assign divided_clock = ttf_chain[BIT_COUNT-1];
endmodule