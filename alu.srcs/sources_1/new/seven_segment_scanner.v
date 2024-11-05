/*
seven_segment_scanner.v

Authors: Nathaniel and Bayleigh
*/
module seven_segment_scanner
(
    input            clock, reset,
    output reg [3:0] anode
);
    reg [1:0] selected_anode;
                     
    always @(posedge clock or posedge reset) begin
        if (reset)
            selected_anode <= 2'b00;
        else
            selected_anode <= selected_anode + 1;
    end

    always @(*) begin
        case (selected_anode)
            2'b00:   anode <= 4'b1110;
            2'b01:   anode <= 4'b1101;
            2'b10:   anode <= 4'b1011;
            2'b11:   anode <= 4'b0111;
            default: anode <= 4'bxxxx;
        endcase
    end
endmodule