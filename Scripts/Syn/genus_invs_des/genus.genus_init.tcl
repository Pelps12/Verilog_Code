################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 05/03/2025 14:52:48
#
################################################################################

      if { ![is_common_ui_mode] } {
        error "This script must be loaded into an 'innovus -stylus' session."
      }
    


read_mmmc genus_invs_des/genus.mmmc.tcl

read_physical -lef {/proj/cad/library/asap7/asap7sc7p5t_27/techlef_misc/asap7_tech_4x_201209.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_R_4x_201211.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_L_4x_201211.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SL_4x_201211.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SRAM_4x_201211.lef /home/eng/t/txg150930/workspace/ASIC/Memory/lef/SRAM1RW128x12_x4.lef /home/eng/t/txg150930/workspace/ASIC/Memory/lef/SRAM1RW256x8_x4.lef /home/eng/t/txg150930/workspace/ASIC/Memory/lef/SRAM2RW16x8_x4.lef}

read_netlist genus_invs_des/genus.v.gz

init_design -skip_sdc_read
