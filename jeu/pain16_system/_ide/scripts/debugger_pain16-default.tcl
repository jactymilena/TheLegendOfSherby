# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\github\TheLegendOfSherby\jeu\pain16_system\_ide\scripts\debugger_pain16-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\github\TheLegendOfSherby\jeu\pain16_system\_ide\scripts\debugger_pain16-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351A77E63A" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351A77E63A-13722093-0"}
fpga -file C:/github/TheLegendOfSherby/jeu/pain16/_ide/bitstream/Exercice2_bd_wrapper_map16.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/github/TheLegendOfSherby/jeu/Exercice2_bd_wrapper_map16/export/Exercice2_bd_wrapper_map16/hw/Exercice2_bd_wrapper_map16.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/github/TheLegendOfSherby/jeu/pain16/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/github/TheLegendOfSherby/jeu/pain16/Debug/pain16.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
