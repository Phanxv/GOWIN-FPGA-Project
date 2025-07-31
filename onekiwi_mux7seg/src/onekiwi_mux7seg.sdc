//Copyright (C)2014-2025 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.11.03 (64-bit) 
//Created Time: 2025-07-30 17:50:55
create_clock -name clk27mhz -period 37.037 -waveform {0 18.518} [get_ports {clk}]
create_generated_clock -name clk_270 -source [get_ports {clk}] -master_clock clk27mhz -divide_by 10000 [get_nets {clk_270hz}]
