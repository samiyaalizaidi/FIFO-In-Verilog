# Implementation of a FIFO Using Verilog HDL

## Parameters
 - Length of a single word: 8 bits.
 - Height of the FIFO: 32

### Input Signals
- Clock @ 1 MHz: 1 bit
- Reset: 1-bit signal to set everything to zero.
- Input Data: 8 bits
- Write: 1-bit signal given when the data has to be written into the FIFO.
- Read: 1-bit signal given when the data has to be read from the FIFO.

### Output Signals
- Output Data: 8 bits 
- Full: 1-bit signal generated when the FIFO is full. 
- Empty: 1-bit signal generated when the FIFO is empty.
