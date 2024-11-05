/*
top.v

This is the main module of the ALU.

Authors: Nathaniel and Bayleigh
*/

module top
#(
    parameter BIT_COUNT = 8
)
(
    input                    btnC, btnU, clk,
    input  [BIT_COUNT*2-1:0] sw,
    output [BIT_COUNT*2-1:0] led,
    output [3:0]             an,
    output [6:0]             seg 
);
    /*
    Inputs: btnC      Perform the operation
            btnU      Reset
            clk       100 MHz board clock
            sw[3:0]   Operation selector
            sw[15:8]  8 input bits
 
    Outputs: led[15:8] Display A value inside ALU
             led[7:0]  Display B value inside ALU
             an[3:0]   Display anodes
             seg[6:0]  Display segments
    
    Display: Right        Value of operation selector
             Right center N/A
             Left center  Lower four bits of Y
             Left         Upper four bits of Y
    */
        
    // Inputs as wires.
    wire                 enable   = btnC;
    wire                 reset    = btnU;
    wire                 clock    = clk;
    wire [3:0]           selector = sw[3:0];
    wire [BIT_COUNT-1:0] number   = sw[BIT_COUNT*2-1:BIT_COUNT];
    
    // A, B, and Y register controls.
    wire [BIT_COUNT-1:0] a_in, b_in, y_in, a_out, b_out, y_out;
    wire memory_store, result_store;
    
    // Every possible operation in our ALU is run in parallel. This is used 
    // with a multiplexer.
    wire [BIT_COUNT-1:0] add_i, sub_i; // Assigned to with a ripple carry adder
                                       // and ripple borrow subtractor further
                                       // down.
    wire [BIT_COUNT-1:0] shl_i  = a_out << 1;
    wire [BIT_COUNT-1:0] shr_i  = a_out >> 1;
    wire [BIT_COUNT-1:0] cmp_i  = (a_out == b_out) ? 0 : (a_out > b_out) ? 1 : -1;
    wire [BIT_COUNT-1:0] and_i  = a_out & b_out;
    wire [BIT_COUNT-1:0] or_i   = a_out | b_out;
    wire [BIT_COUNT-1:0] xor_i  = a_out ^ b_out;
    wire [BIT_COUNT-1:0] nand_i = ~(a_out & b_out);
    wire [BIT_COUNT-1:0] nor_i  = ~(a_out | b_out);
    wire [BIT_COUNT-1:0] xnor_i = ~(a_out ^ b_out);
    wire [BIT_COUNT-1:0] inv_i  = ~a_out;
    wire [BIT_COUNT-1:0] neg_i; // Assigned to with a two's complement
                                // converter further down.
    
    // A register.
    n_bit_memory #(.BIT_COUNT(BIT_COUNT)) a_memory(
        // Input
        .data(a_in),
        .clock(clock),
        .store(memory_store),
        .reset(reset),
        // Output
        .memory(a_out)
    );
    
    // B register.
    n_bit_memory #(.BIT_COUNT(BIT_COUNT)) b_memory(
        // Input
        .data(b_in),
        .clock(clock),
        .store(memory_store),
        .reset(reset),
        // Output
        .memory(b_out)
    );
    
    // Y register.
    n_bit_memory #(.BIT_COUNT(BIT_COUNT)) y_memory(
        // Input
        .data(y_in),
        .clock(clock),
        .store(result_store),
        .reset(reset),
        // Output
        .memory(y_out)
    );
    
    // Ripple carry adder for use with the ADD operation.
    n_bit_ripple_carry_adder #(.BIT_COUNT(BIT_COUNT)) adder(
        // Input
        .a(a_out),
        .b(b_out),
        // Output
        .sum(add_i)
    );

    // Ripple borrow subbtractor for use with the SUB operation.
    n_bit_ripple_borrow_subtractor #(.BIT_COUNT(BIT_COUNT)) subtractor(
        // Input
        .a(a_out),
        .b(b_out),
        // Output
        .difference(sub_i)
    );
    
    // Twos Complement converter for use with the NEG operation.
    twos_complement_converter #(.BIT_COUNT(BIT_COUNT)) twos_complement_converter(
        // Input
        .a(a_out),
        // Output
        .y(neg_i)
    );
    
    // The multiplexer is used to pick which operation is stored in the Y
    // register. All of the operations are run in parallel, and the multiplexer
    // simply picks one of them to store in that register.
    operation_multiplexer #(.BIT_COUNT(BIT_COUNT)) operation_multiplexer(
        // Input
        .add_i(add_i),          // ADD
        .sub_i(sub_i),          // SUB
        .shl_i(shl_i),          // SHL
        .shr_i(shr_i),          // SHR
        .cmp_i(cmp_i),          // CMP
        .and_i(and_i),          // AND
        .or_i(or_i),            // OR
        .xor_i(xor_i),          // XOR
        .nand_i(nand_i),        // NAND
        .nor_i(nor_i),          // NOR
        .xnor_i(xnor_i),        // XNOR
        .inv_i(inv_i),          // INV
        .neg_i(neg_i),          // NEG
        .selector(selector),
        .enable(enable),
        // Output
        .y(y_in),
        .store(result_store)
    );
    
    // The unit multiplexer takes the A, B, Y, and 8-bit number as input, and
    // modifies the A and B registers based on the selected operation.
    unit_multiplexer #(.BIT_COUNT(BIT_COUNT)) unit_multiplexer(
        // Input
        .a_out(a_out),
        .b_out(b_out),
        .y_out(y_out),
        .number(number),
        .selector(selector),
        .enable(enable),
        // Output
        .a_in(a_in),
        .b_in(b_in),
        .store(memory_store)
    );
    
    // The seven-segment controller has the clock, scanner, and decoder inside
    // it. This was pulled directly from the previous lab with some tweaking.
    seven_segment_controller seven_segment_controller(
        // Input
        .clock(clock),
        .reset(reset),
        .right(selector),
        .left_center(y_out[BIT_COUNT/2-1:0]),
        .left(y_out[BIT_COUNT-1:BIT_COUNT/2]),
        // Output
        .anode(an),
        .segments(seg)
    );
    
    // Continuously assign the output LEDs to be the values of the A and B
    // registers.
    assign led[BIT_COUNT*2-1:BIT_COUNT] = a_out;
    assign led[BIT_COUNT-1:0]           = b_out;
endmodule