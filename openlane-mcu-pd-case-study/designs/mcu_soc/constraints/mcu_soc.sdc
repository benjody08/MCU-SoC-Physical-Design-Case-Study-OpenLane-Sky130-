############################################################
# MCU_SOC — Production-Quality SDC
############################################################

############################
# Clock Definition
############################

# 50 MHz system clock (20 ns period)
create_clock \
    -name core_clk \
    -period 10.000 \
    [get_ports clk]

# Conservative clock quality assumptions
set_clock_uncertainty 0.10 [get_clocks core_clk]
set_clock_transition  0.15 [get_clocks core_clk]

############################
# Reset Modeling
############################

# rst_n is asynchronous control, not data
# Do NOT time reset paths
set_false_path -from [get_ports rst_n]
set_false_path -to   [get_ports rst_n]

############################
# Input Constraints
############################

# No data inputs in this design
# (Clock and reset are excluded by design)

############################
# Output Constraints
############################

# GPIO outputs go to external pads / MCU fabric
# Conservative external delay assumption
set_output_delay 4.0 \
    -clock core_clk \
    [get_ports gpio_out[*]]

# Conservative load (matches OpenLane defaults)
set_load 0.033442 [get_ports gpio_out[*]]

############################
# Design Intent
############################


