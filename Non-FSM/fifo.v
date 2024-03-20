`timescale 1ns / 1ps

module queue_non_fsm(
    clk,             // input clock
    reset,           // set everything to zero
    data_in,         // input data word
    write_to_stack,  // write the data_in into the FIFO if this is asserted
    read_from_stack, // output the data word from the FIFO when asserted
    stack_full,      // generate a signal when the FIFO is full
    stack_empty,     // generate a signal when the FIFO is empty
    data_out         // output signal
    );
    
    // SET THE NECESSARY PARAMETERS
    parameter num_of_words  = 32; // number of words that can be stored in the queue
    parameter word_length   = 8;  // length of each word in the queue
    parameter pointer_width = 5;  // width of the pointer 
    
    // I/O SIGNALS
    
    input [word_length - 1:0] data_in;
    
    input       clk,
                reset,
                write_to_stack,
                read_from_stack;
          
    output stack_full,
           stack_empty;
           
    output [word_length - 1:0] data_out;
    reg    [word_length - 1:0] data_out;
         
    // INTERNAL REGISTERS
   
    reg [word_length - 1:0] queue_8_32 [0:num_of_words - 1]; // THE FIFO STRUCTURE
    
    reg [pointer_width:0]     pointer_difference;
    
    reg [pointer_width - 1:0] read_pointer,
                              write_pointer;
    
    
    // SIGNALS
    assign stack_full  = pointer_difference == num_of_words;
    assign stack_empty = pointer_difference == 0;
    
    integer i;
    
    always @ (posedge clk or 
              posedge reset
              ) begin
              
        // RESET
        if (reset) begin
           for (i = 0; i < num_of_words; i = i + 1) queue_8_32[i] <= 8'b0000_0000;           
           data_out           <= 8'b0000_0000;
           pointer_difference <= 0;
           read_pointer       <= 0; 
           write_pointer      <= 0;
        end        
        // WRITING ONLY
        else if (write_to_stack && (!stack_full)) begin
            queue_8_32[write_pointer] <= data_in;
            write_pointer             <= write_pointer + 1;
            pointer_difference        <= pointer_difference + 1;
        end
        // READING ONLY
        else if (read_from_stack && (!stack_empty)) begin
            data_out           <= queue_8_32[read_pointer];
            read_pointer       = read_pointer + 1;
            pointer_difference <= pointer_difference - 1;
        end        
    end
    
endmodule
