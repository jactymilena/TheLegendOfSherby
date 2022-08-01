onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Exercice2_bd_opt

do {wave.do}

view wave
view structure
view signals

do {Exercice2_bd.udo}

run -all

quit -force
