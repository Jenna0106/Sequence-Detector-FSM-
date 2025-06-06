# Sequence-Detector-FSM-

Sequence Detector Project
Overview
This project implements a Moore Finite State Machine (FSM) in Verilog to detect the sequence "01110" in a serial input stream. The design includes a detector module and a testbench to verify its functionality. The FSM outputs '1' when the sequence is detected, otherwise it outputs '0'.
Files

detector.v: The main Verilog module implementing the sequence detector FSM.
tb.v: The testbench module for simulating and verifying the detector's behavior.
detector.vcd: The waveform dump file generated during simulation (not included in the repository).

Module Description
detector.v

Purpose: Detects the sequence "01110" in a serial input stream.
Inputs:
i: Serial input bit.
clk: Clock signal (synchronous, positive edge-triggered).
rst: Active-high reset signal to initialize the FSM to the initial state (s0).


Output:
o: Output signal, set to '1' when the sequence "01110" is detected.


States:
s0: Waiting for the first '0'.
s1: Received '0', waiting for '1'.
s2: Received "01", waiting for second '1'.
s3: Received "011", waiting for '0' to complete the sequence.



tb.v

Purpose: Testbench to simulate the detector module.
Features:
Generates a 100MHz clock (clk toggles every 5ns).
Applies a reset signal (rst) for 20ns.
Tests the sequence "01110" and additional invalid patterns.
Monitors and logs the input (i), state (dut.ps), and output (o) at each time step.
Generates a VCD file (detector.vcd) for waveform viewing.



Simulation
To simulate the project:

Ensure you have a Verilog simulator installed (e.g., Icarus Verilog, ModelSim, or Vivado).
Compile the modules:iverilog -o detector_tb detector.v tb.v


Run the simulation:vvp detector_tb


View the waveform using a tool like GTKWave:gtkwave detector.vcd



Expected Behavior

The detector outputs o = 1 when the sequence "01110" is detected (e.g., at 50ns in the testbench).
The FSM transitions through states s0 → s1 → s2 → s3 → s1 for the correct sequence.
Invalid sequences keep the output o = 0.

Requirements

Verilog simulator (e.g., Icarus Verilog, ModelSim, or Vivado).
Waveform viewer (e.g., GTKWave) for analyzing the VCD file.

How to Use

Clone the repository:git clone <repository-url>


Navigate to the project directory:cd <project-directory>


Compile and simulate as described in the Simulation section.
Inspect the console output or VCD file to verify the detector's behavior.

Notes

The timescale is set to 1ns / 1ps for precise timing simulation.
The testbench includes a mix of valid and invalid input patterns to thoroughly test the FSM.
The $monitor statement in the testbench provides a real-time log of the simulation.

Author : Jennifer George

