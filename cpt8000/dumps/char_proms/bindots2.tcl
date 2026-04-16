#!/usr/bin/tclsh

set fn1    [lindex $argv 0]
set fn2    [lindex $argv 1]
set width [lindex $argv 2]

puts "File 1:  $fn1"
puts "File 2:  $fn2"
puts "Width: $width"

set f1 [open $fn1 "rb"]
set bindata1 [read $f1]
close $f1

set f2 [open $fn2 "rb"]
set bindata2 [read $f2]
close $f2

# convert to binary
binary scan $bindata1 B* bindigits1
binary scan $bindata2 B* bindigits2

set bitstream ""

set i 0
set j 0

foreach {d1a d1b d1c d1d d1e d1f d1g d1h} [split $bindigits1 ""] {d2a d2b d2c d2d d2e d2f d2g d2h} [split $bindigits2 ""] {
    set bitstream "$bitstream$d1e"
    set bitstream "$bitstream$d1f"
    set bitstream "$bitstream$d1g"
    set bitstream "$bitstream$d1h"

    set bitstream "$bitstream$d2e"
    set bitstream "$bitstream$d2f"
    set bitstream "$bitstream$d2g"
    set bitstream "$bitstream$d2h"
}

foreach d [split $bitstream ""] {

    # Discard upper nibbles
    # Use lower nibble to generate pixel data
    if { $d } {
        puts -nonewline " "
    } else {
        puts -nonewline "X"
    }

    if { $i == $width} {
        puts -nonewline "\n"
        set i 0
    }

    if { ($i % 8) == 0 } {
        incr j 1
        if { $j == 15 } {
            puts "\n\n\n"
            set j 0
        }
        puts -nonewline " "
    }

    incr i 1 
}



