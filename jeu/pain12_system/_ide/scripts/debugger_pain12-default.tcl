# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\GitHub\TheLegendOfSherby\jeu\pain12_system\_ide\scripts\debugger_pain12-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\GitHub\TheLegendOfSherby\jeu\pain12_system\_ide\scripts\debugger_pain12-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351A77E63A" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351A77E63A-13722093-0"}
fpga -file C:/GitHub/TheLegendOfSherby/jeu/pain12/_ide/bitstream/Exercice2_bd_wrapper_slow.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/GitHub/TheLegendOfSherby/jeu/Exercice2_bd_wrapper_slow/export/Exercice2_bd_wrapper_slow/hw/Exercice2_bd_wrapper_slow.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/GitHub/TheLegendOfSherby/jeu/pain12/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/GitHub/TheLegendOfSherby/jeu/pain12/Debug/pain12.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
