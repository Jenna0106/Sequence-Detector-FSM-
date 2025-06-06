`timescale 1ns / 1ps

module tb;
    reg i, clk, rst;
    wire o;
    
    detector dut(.o(o), .i(i), .clk(clk), .rst(rst));
    
    // Clock generation (100MHz)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        // Initialize and reset
        rst = 1;
        i = 0;
        #20 rst = 0;
        
        // Test sequence
        // Correct "0110" pattern (should detect at 80ns)
        #10 i = 0;  // 20ns
        #10 i = 1;  // 30ns
        #10 i = 1;  // 40ns
        #10 i = 0;  // 50ns (complete pattern)
        #10 i = 1;  // 60ns
        #10 i = 0;  // 70ns
        #10 i = 1;  // 80ns
        #10 i = 1;  // 90ns
        #10 i = 0;  // 100ns (second pattern)
        
        // Add some invalid patterns
        #10 i = 1;
        #10 i = 0;
        #10 i = 0;
        #10 i = 1;
        
        #50 $finish;
    end
    
    // Monitoring
    initial begin
        $dumpfile("detector.vcd");
        $dumpvars(0, tb);
        $monitor("Time=%0t: i=%b, State=%b, o=%b", 
                $time, i, dut.ps, o);
    end
endmodule
