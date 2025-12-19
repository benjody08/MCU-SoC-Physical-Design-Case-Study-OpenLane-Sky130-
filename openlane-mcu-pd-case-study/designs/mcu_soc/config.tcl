set ::env(DESIGN_NAME) soc_top
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/rtl/*.v]
set ::env(SDC_FILE) "$::env(DESIGN_DIR)/constraints/soc.sdc"

set ::env(PDK) sky130A
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd

set ::env(CLOCK_PORT) clk
set ::env(CLOCK_PERIOD) 20.0

set ::env(FP_CORE_UTIL) 0.65
set ::env(FP_ASPECT_RATIO) 1.0
set ::env(FP_IO_MODE) 1

set ::env(CTS_TARGET_SKEW) 0.2
set ::env(CTS_CLK_BUFFER_LIST) \
    "sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2"

set ::env(RUN_LVS) 1
set ::env(RUN_DRC) 1
#============================================================
# Timing Constraints
#============================================================
set ::env(PNR_SDC_FILE)      "$::env(DESIGN_DIR)/constraints/mcu_soc.sdc"
set ::env(SIGNOFF_SDC_FILE) "$::env(DESIGN_DIR)/constraints/mcu_soc.sdc"

#============================================================
# PDN tuning for high utilization
#============================================================
set ::env(PDN_VWIDTH) 3.1
set ::env(PDN_HWIDTH) 3.1
set ::env(PDN_VPITCH) 7.0
set ::env(PDN_HPITCH) 7.0

# ---- Explicit Die / Core Sizing (PDN-safe) ----
set ::env(FP_SIZING) absolute

# Die size (microns)
set ::env(DIE_AREA) "0 0 80 80"

# Core offset from die boundary (microns)
set ::env(CORE_MARGIN) 12

