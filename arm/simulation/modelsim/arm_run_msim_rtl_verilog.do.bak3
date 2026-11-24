transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/controller {D:/single_cycle_ARM_processor/controller/pc_logic.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/controller {D:/single_cycle_ARM_processor/controller/main_decoder.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/controller {D:/single_cycle_ARM_processor/controller/decoder.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/controller {D:/single_cycle_ARM_processor/controller/controller.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/controller {D:/single_cycle_ARM_processor/controller/conditional_logic.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/controller {D:/single_cycle_ARM_processor/controller/alu_decoder.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/shifter.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/register_file.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/pc_unit.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/mux.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/instruction_memory.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/extend.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/datapath.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/data_memory.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/datapath {D:/single_cycle_ARM_processor/datapath/alu.sv}
vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/arm {D:/single_cycle_ARM_processor/arm/arm.sv}

vlog -sv -work work +incdir+D:/single_cycle_ARM_processor/arm {D:/single_cycle_ARM_processor/arm/tb_arm.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_arm

add wave *
view structure
view signals
run -all
