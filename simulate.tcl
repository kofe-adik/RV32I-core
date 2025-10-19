# === CONFIG ===
set project_path "c:/BK/CTMT/RISCV_RV32I"
set tb_path [file join $project_path "tb"]
set sim_log [file join $project_path "simulate.log"]

# === ARGUMENT ===
set tb_module $1
if {$tb_module eq ""} {
    puts "Usage: do simulate.tcl <tb_module>"
    puts "Example: do simulate.tcl tb_FA"
    quit -f
}

# === LOG ===
set log [open $sim_log "w"]
puts $log "=== Simulation started at [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"] ==="
puts $log "Running testbench: $tb_module"

# === RUN SIMULATION ===
puts $log "Simulating work.$tb_module ..."

# Chạy vsim (blocking)
set vsim_cmd "vsim -c -do \"run -all; quit -f\" work.$tb_module"
puts "Running: $vsim_cmd"
exec {*}$vsim_cmd

# === PARSE TRANSCRIPT ===
if {[file exists "transcript"]} {
    set fp [open "transcript" r]
    set content [read $fp]
    close $fp

    set filtered_lines ""
    foreach line [split $content "\n"] {
        # Lọc những dòng quan trọng
        if {[regexp {=== Start .* comparison ===} $line] || 
            [regexp {PASS line} $line] ||
            [regexp {FAIL line} $line] ||
            [regexp {=== .* PASSED ===} $line] ||
            [regexp {=== .* FAILED} $line]} {
            append filtered_lines "$line\n"
        }
    }

    puts $log "\n--- Simulator Key Output ---"
    puts $log $filtered_lines
} else {
    puts $log "WARNING: Transcript file not found!"
}

# === SUMMARY ===
puts $log "\n=== Simulation Summary ==="
puts $log "Testbench: $tb_module"
if {[regexp {FAIL line} $filtered_lines]} {
    puts $log "Result: FAILED"
} else {
    puts $log "Result: PASSED"
}
