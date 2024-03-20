`timescale 1ns / 1ps

module tb_non_fsm_FIFO();
    parameter num_of_words  = 32; // number of words that can be stored in the queue
    parameter word_length   = 8;  // length of each word in the queue
    parameter pointer_width = 5;  // width of the pointer 

    reg [word_length - 1:0] data_in;
    reg         clk,
                reset,
                write_to_stack,
                read_from_stack;
          
    wire    stack_full,
            stack_empty;           
    wire    [word_length - 1:0] data_out;
    
    queue_non_fsm uut(  clk,             // input clock
                        reset,           // set everything to zero
                        data_in,         // input data word
                        write_to_stack,  // write the data_in into the FIFO if this is asserted
                        read_from_stack, // output the data word from the FIFO when asserted
                        stack_full,      // generate a signal when the FIFO is full
                        stack_empty,     // generate a signal when the FIFO is empty
                        data_out         // output signal
                        );
                        
    initial begin
        clk = 0;
        reset = 1;
        
        #10
        reset = 0;
        read_from_stack = 0;
        write_to_stack = 1;
        data_in = 8'd1;
        
        #10
        data_in = 8'd10;
        
        #10
        data_in = 8'd20;
        
        #10
        read_from_stack = 1;
        write_to_stack = 0;
        data_in = 8'd40;
        
        #10 
        write_to_stack = 0;
        data_in = 8'd41;
        
        #10 
        write_to_stack = 1;
        read_from_stack = 0;
        data_in = 8'd42;
        
        #10
        data_in = 8'd30;
        
        #50
        write_to_stack = 0;
        read_from_stack = 1;
        data_in = 8'd25;  
        
        #50
        write_to_stack = 1;
        read_from_stack = 0;
        data_in = 8'd35;       
   end
   
   always #5 clk = ~clk;        

endmodule
