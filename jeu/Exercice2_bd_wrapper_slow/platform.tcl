# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\GitHub\TheLegendOfSherby\jeu\Exercice2_bd_wrapper_slow\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\GitHub\TheLegendOfSherby\jeu\Exercice2_bd_wrapper_slow\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {Exercice2_bd_wrapper_slow}\
-hw {C:\GitHub\TheLegendOfSherby\jeu\Exercice2_bd_wrapper_slow.xsa}\
-fsbl-target {psu_cortexa53_0} -out {C:/GitHub/TheLegendOfSherby/jeu}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {Exercice2_bd_wrapper_slow}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate