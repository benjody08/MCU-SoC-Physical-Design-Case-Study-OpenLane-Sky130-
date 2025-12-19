create_clock -name core_clk -period 20.0 [get_ports clk]
set_clock_uncertainty 0.25 [get_clocks core_clk]

set_false_path -from [get_ports rst_n]

set_input_delay  0.5 -clock core_clk [all_inputs]
set_output_delay 0.5 -clock core_clk [all_outputs]

