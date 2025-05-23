if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name PVT_0P77V_0C.hold_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_RVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_LVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_SLVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_SRAM_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_RVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_LVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_SLVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_SRAM_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_RVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_LVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_SLVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_SRAM_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_RVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_LVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_SLVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_SRAM_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_RVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_LVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_SLVT_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_SRAM_FF_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/SRAM1RW128x12_PVT_0P77V_0C.lib\
    ${::IMEX::libVar}/mmmc/SRAM1RW256x8_PVT_0P77V_0C.lib\
    ${::IMEX::libVar}/mmmc/SRAM2RW16x8_PVT_0P77V_0C.lib]
create_library_set -name PVT_0P63V_100C.setup_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_RVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_LVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_SLVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_SRAM_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_RVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_LVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_SLVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_SRAM_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_RVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_LVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_SLVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_SRAM_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_RVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_LVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_SLVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_SRAM_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_RVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_LVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_SLVT_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_SRAM_SS_nldm_201020.lib\
    ${::IMEX::libVar}/mmmc/SRAM1RW128x12_PVT_0P63V_100C.lib\
    ${::IMEX::libVar}/mmmc/SRAM1RW256x8_PVT_0P63V_100C.lib\
    ${::IMEX::libVar}/mmmc/SRAM2RW16x8_PVT_0P63V_100C.lib]
create_timing_condition -name PVT_0P77V_0C.hold_cond\
   -library_sets [list PVT_0P77V_0C.hold_set]
create_timing_condition -name PVT_0P63V_100C.setup_cond\
   -library_sets [list PVT_0P63V_100C.setup_set]
create_rc_corner -name PVT_0P77V_0C.hold_rc\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 0\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile_typ03_scaled4xV06
create_rc_corner -name PVT_0P63V_100C.setup_rc\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 100\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile_typ03_scaled4xV06
create_delay_corner -name PVT_0P77V_0C.hold_delay\
   -timing_condition {PVT_0P77V_0C.hold_cond}\
   -rc_corner PVT_0P77V_0C.hold_rc
create_delay_corner -name PVT_0P63V_100C.setup_delay\
   -timing_condition {PVT_0P63V_100C.setup_cond}\
   -rc_corner PVT_0P63V_100C.setup_rc
create_constraint_mode -name my_constraint_mode\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/my_constraint_mode/my_constraint_mode.sdc]
create_analysis_view -name PVT_0P63V_100C.setup_view -constraint_mode my_constraint_mode -delay_corner PVT_0P63V_100C.setup_delay -latency_file ${::IMEX::dataVar}/mmmc/views/PVT_0P63V_100C.setup_view/latency.sdc
create_analysis_view -name PVT_0P77V_0C.hold_view -constraint_mode my_constraint_mode -delay_corner PVT_0P77V_0C.hold_delay -latency_file ${::IMEX::dataVar}/mmmc/views/PVT_0P77V_0C.hold_view/latency.sdc
set_analysis_view -setup [list PVT_0P63V_100C.setup_view] -hold [list PVT_0P77V_0C.hold_view]
