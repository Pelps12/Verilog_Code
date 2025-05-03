create_floorplan -core_margins_by die -flip f -die_size_by_io_height max -site asap7sc7p5t -die_size { 236.864 180.328 0 0 0 0 }

place_inst R_mem_L/mem_0_0 44.768 60.384 my
create_place_halo -insts R_mem_L/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst R_mem_L/mem_0_0

place_inst R_mem_R/mem_0_0 180.288 60.384 my
create_place_halo -insts R_mem_R/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst R_mem_R/mem_0_0

place_inst Co_mem_L/mem_0_0 1.92 121.824 my
create_place_halo -insts Co_mem_L/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_L/mem_0_0

place_inst Co_mem_L/mem_0_1 30.688 121.824 my
create_place_halo -insts Co_mem_L/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_L/mem_0_1

place_inst Co_mem_L/mem_0_2 59.456 121.824 my
create_place_halo -insts Co_mem_L/mem_0_2 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_L/mem_0_2

place_inst Co_mem_L/mem_0_3 88.224 121.824 my
create_place_halo -insts Co_mem_L/mem_0_3 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_L/mem_0_3

place_inst Co_mem_R/mem_0_0 209.056 121.824 r0
create_place_halo -insts Co_mem_R/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_R/mem_0_0

place_inst Co_mem_R/mem_0_1 180.288 121.824 r0
create_place_halo -insts Co_mem_R/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_R/mem_0_1

place_inst Co_mem_R/mem_0_2 151.52 121.824 r0
create_place_halo -insts Co_mem_R/mem_0_2 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_R/mem_0_2

place_inst Co_mem_R/mem_0_3 122.752 121.824 r0
create_place_halo -insts Co_mem_R/mem_0_3 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Co_mem_R/mem_0_3

place_inst Data_mem_L/mem_0_0 1.92 1.824 my
create_place_halo -insts Data_mem_L/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Data_mem_L/mem_0_0

place_inst Data_mem_L/mem_0_1 1.92 60.384 my
create_place_halo -insts Data_mem_L/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Data_mem_L/mem_0_1

place_inst Data_mem_R/mem_0_0 202.016 1.824 r0
create_place_halo -insts Data_mem_R/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Data_mem_R/mem_0_0

place_inst Data_mem_R/mem_0_1 202.016 60.384 r0
create_place_halo -insts Data_mem_R/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst Data_mem_R/mem_0_1

