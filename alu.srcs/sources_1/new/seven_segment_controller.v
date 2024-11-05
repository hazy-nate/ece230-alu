/*
seven_segment_controller.v

The seven-segment controller controls the seven-segment display. It has a clock
divider, scanner, and decoder built into it.

Authors: Nathaniel and Bayleigh
*/
module seven_segment_controller
#(
    parameter CLOCK_DIVIDER_BIT_COUNT = 17
)
(
    input        clock, reset,
    input  [3:0] right, right_center, left_center, left,
    output [3:0] anode,
    output [6:0] segments
);
    /*
    Inputs: clock             The clock signal which drives the seven-segment
                              display.
            reset             Resets the clock and scanner.
            right[4:0]        The rightmost seven-segment digit's value.
            right_center[4:0] The center right seven-segment digit's value.
            left_center[4:0]  The center left seven-segment digit's value.
            left[4:0]         The leftmost seven-segment digit's value.
            
    Outputs: anode    The anode to power on for the clock cycle.
             segments The segments to power on for the clock cycle.
    */
    
    wire divided_clock;
    wire [3:0] selected_anode;
    
    ttf_clock_divider #( .BIT_COUNT(CLOCK_DIVIDER_BIT_COUNT) ) ttf_clock_divider(
        // Input
        .clock(clock),
        .reset(reset),
        // Output
        .divided_clock(divided_clock)
    );
    
    seven_segment_scanner seven_segment_scanner(
        // Input
        .clock(divided_clock),
        .reset(reset),
        // Output
        .anode(selected_anode)
    );
    
    seven_segment_decoder seven_segment_decoder(
        // Input
        .right(right),
        .right_center(right_center),
        .left_center(left_center),
        .left(left),
        .anode(selected_anode),
        // Output
        .segments(segments)
    );
    
    assign anode = selected_anode;
endmodule