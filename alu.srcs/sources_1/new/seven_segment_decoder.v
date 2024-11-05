/*
seven_segment_decoder.v

Authors: Nathaniel and Bayleigh
*/
module seven_segment_decoder
#(
    parameter [3:0] RIGHT_ANODE        = 4'b1110,
                    RIGHT_CENTER_ANODE = 4'b1101,
                    LEFT_CENTER_ANODE  = 4'b1011,
                    LEFT_ANODE         = 4'b0111
)
(
    input      [3:0] right, right_center, left_center, left, anode,
	output reg [6:0] segments
);
	
	/*
	Inputs: [3:0] right        Bits for the right seven-segment digit.
	        [3:0] right_center Bits for the center right seven-segment digit.
	        [3:0] left_center  Bits for the center left seven-segment digit.
	        [3:0] left         Bits for the left seven-segment digit.
	        
	Outputs: [6:0] segments The segments to be turned on.
	*/
	
	reg [3:0] selected;

    /*
    Pick one of the inputs based on the 4-bit selector signal.
    */
	always @(*) begin
        case (anode)
            RIGHT_ANODE:         selected <= right;
            RIGHT_CENTER_ANODE:  selected <= right_center;
            LEFT_CENTER_ANODE:   selected <= left_center;
            LEFT_ANODE:          selected <= left;
            default:             selected <= 4'bx;
        endcase
    end

    /*
    Output a 7-bit vector which turns on the segments needed to display
    the value.
    */
	always @(*) begin
        case(selected)
            //                GFEDCBA
            0:  segments = 7'b1000000;
            1:  segments = 7'b1111001;
            2:  segments = 7'b0100100;
            3:  segments = 7'b0110000;
            4:  segments = 7'b0011001;
            5:  segments = 7'b0010010;
            6:  segments = 7'b0000010;
            7:  segments = 7'b1111000;
            8:  segments = 7'b0000000;
            9:  segments = 7'b0010000;
            10: segments = 7'b0001000;
            11: segments = 7'b0000011;
            12: segments = 7'b1000110;
            13: segments = 7'b0100001;
            14: segments = 7'b0000110;
            15: segments = 7'b0001110;
        endcase
    end
endmodule