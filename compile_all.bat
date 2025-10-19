@echo off
REM Run ModelSim compilation script from project directory
"C:\intelFPGA\18.1\modelsim_ase\win32aloem\vsim.exe" -c -do "do compile.tcl; quit -f"
