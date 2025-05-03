# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.14-s108_1 on Sat May 03 14:52:20 CDT 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1fF
set_units -time 1ps

# Set the current design
current_design MSDAP

create_clock -name "Dclk" -period 1302000.0 -waveform {0.0 651000.0} [get_ports Dclk]
create_clock -name "Sclk" -period 33333.3 -waveform {0.0 16666.65} [get_ports Sclk]
set_load -pin_load 1.0 [get_ports InReady]
set_load -pin_load 1.0 [get_ports OutReady]
set_load -pin_load 1.0 [get_ports OutputL]
set_load -pin_load 1.0 [get_ports OutputR]
set_clock_groups -name "clock_groups_Dclk_to_others" -asynchronous -group [get_clocks Dclk]
set_clock_groups -name "clock_groups_Sclk_to_others" -asynchronous -group [get_clocks Sclk]
set_clock_gating_check -setup 0.0 
set_clock_uncertainty -setup 100.0 [get_clocks Dclk]
set_clock_uncertainty -hold 100.0 [get_clocks Dclk]
set_clock_uncertainty -setup 100.0 [get_clocks Sclk]
set_clock_uncertainty -hold 100.0 [get_clocks Sclk]
