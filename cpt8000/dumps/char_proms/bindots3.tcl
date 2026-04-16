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

set bitstream1 ""
set bitstream2 ""

set i 0
set j 0

foreach {d1a d1b d1c d1d d1e d1f d1g d1h} [split $bindigits1 ""] {d2a d2b d2c d2d d2e d2f d2g d2h} [split $bindigits2 ""] {
    set bitstream1 "$bitstream1$d1e"
    set bitstream1 "$bitstream1$d1f"
    set bitstream1 "$bitstream1$d1g"
    set bitstream1 "$bitstream1$d1h"

    set bitstream2 "$bitstream2$d2e"
    set bitstream2 "$bitstream2$d2f"
    set bitstream2 "$bitstream2$d2g"
    set bitstream2 "$bitstream2$d2h"
}

# We have two bitstreams, which are the contants of the two PROMs
# Required bits can be extracted by using the index into the stream

proc getbit {stream code scanline} {

    set idx [expr $code + (2 ^ 7) * $scanline]
    
    set bit [string index $stream $idx]
    return $bit
}

proc getnib {stream code scanline} {
    set nib ""
    for {set ni 0} {$ni < 4} {incr ni 1} {
        set idx [expr $code + (2**7)*$scanline+$ni]
        set bit [string index $stream $idx]
        set nib "$nib$bit"
    }
    
    return $nib
}

puts "Length of bitstream1:[string length $bitstream1]"
puts "Length of bitstream2:[string length $bitstream2]"

for { set code 0} {$code < [expr 2**7]} {incr code 1} {
    puts [format "\nCode :%02X " $code]
    
    for {set scan 0} {$scan < 16} {incr scan 1} {
        
        set nib1 [getnib $bitstream1 $code $scan]
        set nib2 [getnib $bitstream2 $code $scan]

        foreach d [split $nib1 ""] {
            # Discard upper nibbles
            # Use lower nibble to generate pixel data
            if { $d } {
                puts -nonewline " "
            } else {
                puts -nonewline "X"
            }
        }

        foreach d [split $nib2 ""] {
            # Discard upper nibbles
            # Use lower nibble to generate pixel data
            if { $d } {
                puts -nonewline " "
            } else {
                puts -nonewline "X"
            }
        }
        puts -nonewline "\n"
    }
    puts "\n\n\n"
}


