@echo off
echo Starting simulation...

REM Save the project directory
set PROJECT_DIR=%~dp0
set TB_MODULE=%1

REM Clean up old work directory and log files
if exist "%PROJECT_DIR%work" rmdir /s /q "%PROJECT_DIR%work"
if exist "%PROJECT_DIR%compile.log" del /f "%PROJECT_DIR%compile.log"
if exist "%PROJECT_DIR%simulate.log" del /f "%PROJECT_DIR%simulate.log"

REM Add ModelSim to PATH
set PATH=C:\intelFPGA\18.1\modelsim_ase\win32aloem;%PATH%

REM Change to project directory
cd /d "%PROJECT_DIR%"

echo Running ModelSim...
echo Working directory: %CD%

REM Launch ModelSim in command-line mode
"C:\intelFPGA\18.1\modelsim_ase\win32aloem\vsim.exe" -c -do "do compile.tcl; do simulate.tcl %TB_MODULE%; quit -f"

echo Simulation complete.
if errorlevel 1 (
    echo Simulation failed with errors.
) else (
    echo Simulation completed successfully.
)