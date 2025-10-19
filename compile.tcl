set project_path "c:/BK/CTMT/RISCV_RV32I"

# Log setup
set compile_log [file join $project_path "compile.log"]
if [catch {open $compile_log "w"} log] {
    puts "Warning: Could not open $compile_log: $log"
    set log stdout
} else {
    puts "Created $compile_log successfully"
}

set start_time [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]
puts $log "=== Compilation started at $start_time ==="

set LIB_NAME "work"

# Clean & recreate work lib
if [file exists $LIB_NAME] {
    vdel -lib $LIB_NAME -all
}
vlib $LIB_NAME
vmap work work

# Standard library mapping
vmap altera_mf C:/intelFPGA/18.1/modelsim_ase/altera/verilog/altera_mf
vmap altera C:/intelFPGA/18.1/modelsim_ase/altera/verilog/altera
vmap lpm C:/intelFPGA/18.1/modelsim_ase/altera/verilog/220model
vmap sgate C:/intelFPGA/18.1/modelsim_ase/altera/verilog/sgate

puts $log "\n=== Compiling all RTL files ==="

set rtl_files [glob -nocomplain [file join $project_path "src" "*.sv"]]
if {[llength $rtl_files] == 0} {
    puts $log "No RTL files found."
} else {
    if [catch {vlog -sv -work work {*}$rtl_files} result] {
        puts $log "ERROR during RTL compilation."
    } else {
        puts $log "RTL compilation finished."
    }

    # Extract all errors from transcript
    set transcript_file "transcript"
    if {[file exists $transcript_file]} {
        set fp [open $transcript_file r]
        set content [read $fp]
        close $fp

        set error_lines ""
        foreach line [split $content "\n"] {
            if {[regexp {\*\* Error:} $line]} {
                append error_lines "$line\n"
            }
        }

        if {$error_lines != ""} {
            puts $log "--- Extracted RTL Error Lines ---\n$error_lines--- End of RTL Error Lines ---"
        } else {
            puts $log "No errors found in transcript."
        }
    }
}

puts $log "\n=== Compiling testbench files ==="
set tb_files [glob -nocomplain [file join $project_path "tb" "*.sv"]]
if {[llength $tb_files] == 0} {
    puts $log "No TB files found."
} else {
    if [catch {vlog -sv -work work {*}$tb_files} result] {
        puts $log "ERROR during TB compilation."
    } else {
        puts $log "TB compilation finished."
    }

    # Extract all errors from transcript
    set transcript_file "transcript"
    if {[file exists $transcript_file]} {
        set fp [open $transcript_file r]
        set content [read $fp]
        close $fp

        set error_lines ""
        foreach line [split $content "\n"] {
            if {[regexp {\*\* Error:} $line]} {
                append error_lines "$line\n"
            }
        }

        if {$error_lines != ""} {
            puts $log "--- Extracted TB Error Lines ---\n$error_lines--- End of TB Error Lines ---"
        } else {
            puts $log "No errors found in transcript."
        }
    }
}

# === Summary Section ===

# Count errors & warnings from transcript (nếu có)
set transcript_file "transcript"
set err_count 0
set warn_count 0
if {[file exists $transcript_file]} {
    set fp [open $transcript_file r]
    set content [read $fp]
    close $fp

    foreach line [split $content "\n"] {
        if {[regexp {\*\* Error:} $line]} {
            incr err_count
        } elseif {[regexp {\*\* Warning:} $line]} {
            incr warn_count
        }
    }
}

set end_time [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]

set summary "\n=== Compilation Summary ===\n"
append summary "RTL files compiled: [llength $rtl_files]\n"
append summary "Testbench files compiled: [llength $tb_files]\n"
append summary "Errors detected: $err_count\n"
append summary "Warnings detected: $warn_count\n"
append summary "Compilation completed at $end_time\n"

puts $log $summary
if {$log != "stdout"} {
    close $log
}

puts "Compilation completed. Check compile.log for results."
