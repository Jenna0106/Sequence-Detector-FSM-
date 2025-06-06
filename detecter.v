// Module: detector
// Description: A Moore finite state machine (FSM) to detect the sequence "01110" in a serial input stream.
//              The module outputs '1' when the sequence is detected, otherwise outputs '0'.
// Inputs:
//   - i: Serial input bit
//   - clk: Clock signal for synchronous state transitions
//   - rst: Active-high reset signal to initialize the FSM to state s0
// Output:
//   - o: Output signal, set to '1' when the sequence "01110" is detected
// States:
//   - s0: Initial state, waiting for first '0'
//   - s1: Received '0', waiting for '1'
//   - s2: Received "01", waiting for second '1'
//   - s3: Received "011", waiting for '0' to complete sequence
// Author: Jennifer George
// Date: 03/06/2025 `timescale 1ns / 1ps
// detects 01110

module detector(
    input i,
    input clk,
    input rst,
    output reg o
);
    reg [1:0] ps, ns;
    parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;

    // State register (sequential logic)
    always @(posedge clk or posedge rst) begin
        if (rst) 
            ps <= s0;
        else 
            ps <= ns;
    end

    // Next state and output logic (combinational)
    always @(*) begin
        case(ps)
            s0: begin
                ns = i ? s0 : s1;  // Stay at s0 if 1, move to s1 if 0
                o = 0;
            end           
            s1: begin
                ns = i ? s2 : s1;  // Move to s2 if 1, stay at s1 if 0
                o = 0;
            end
            s2: begin
                ns = i ? s3 : s1;  // Move to s3 if 1, back to s1 if 0
                o = 0;
            end
            s3: begin
                ns = i ? s0 : s1;  // Back to s0 if 1, to s1 if 0
                o = i ? 0 : 1;     // Output 1 only when we get '0' in s3
            end
            default: begin
                ns = s0;
                o = 0;
            end
        endcase
    end
endmodule
