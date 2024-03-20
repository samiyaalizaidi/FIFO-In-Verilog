`timescale 1ns / 1ps

module tb_fsm_FIFO();
    parameter num_of_words  = 32; // number of words that can be stored in the queue
    parameter word_length   = 8;  // length of each word in the queue
    parameter pointer_width = 5;  // width of the pointer 
    
    // FSM STATES
    parameter idle       = 3'b1xx;
    parameter read_only  = 3'b001;
    parameter write_only = 3'b010;
    parameter both       = 3'b011;   

    reg [word_length - 1:0] data_in;
    reg         clk,
                reset,
                write_to_stack,
                read_from_stack;
          
    wire    stack_full,
            stack_empty;           
    wire    [word_length - 1:0] data_out;
    
    queue_fsm   uut(clk,             // input clock
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
        write_to_stack = 0;
        read_from_stack = 1;
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
        
        #10
        write_to_stack = 0;
        read_from_stack = 1;
        data_in = 8'd25;       
        
        #10 
        write_to_stack = 1;
        read_from_stack = 0;
        data_in =  8'd26;
        
        #10 
        data_in =  8'd27;    
        
        #10 
        data_in =  8'd28;
        
        #10 
        data_in =  8'd29;        
        
        #10 
        data_in =  8'd27;    
        
        #10 
        data_in =  8'd28;
        
        #10 
        data_in =  8'd29;  
        
        #10 
        data_in =  8'd27;    
        
        #10 
        data_in =  8'd28;
        
        #10 
        data_in =  8'd29;  
        
        #10 
        data_in =  8'd27;    
        
        #10 
        data_in =  8'd38;
        
        #10 
        data_in =  8'd39;        
        
        #10 
        data_in =  8'd37;    
        
        #10 
        data_in =  8'd38;
        
        #10 
        data_in =  8'd39;  
        
        #10 
        data_in =  8'd47;    
        
        #10 
        data_in =  8'd48;
        
        #10 
        data_in =  8'd49;  
        
        #10 
        data_in =  8'd69;        
        
        #10 
        data_in =  8'd67;    
        
        #10 
        data_in =  8'd78;
        
        #10 
        data_in =  8'd79;  
        
        #10 
        data_in =  8'd77;    
        
        #10 
        data_in =  8'd78;
        
        #10 
        data_in =  8'd79;
        
        #10 
        data_in =  8'd87;    
        
        #10 
        data_in =  8'd88;
        
        #10 
        data_in =  8'd89; 
        
        #10 
        data_in =  8'd98;
        
        #10 
        data_in =  8'd99;  
        
        #10
        write_to_stack = 0;
        read_from_stack = 1;
        data_in = 8'd100;
        
        #10
        data_in = 9'd101;
        
        #10
        write_to_stack = 1;
        read_from_stack = 0;
        data_in = 8'd100;
   end
   
   always #5 clk = ~clk;   
        
endmodule
