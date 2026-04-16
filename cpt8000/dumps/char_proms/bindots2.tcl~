#!/usr/bin/tclsh

set fn    [lindex $argv 0]
set width [lindex $argv 1]

puts "File:  $fn]"
puts "Width: $width"

set f [open $fn "rb"]
set bindata [read $f]
close $f

# convert to binary
binary scan $bindata B* bindigits

set i 0
foreach digit [split $bindigits ""] {
    if { $i == $width} {
        puts "\n"
        set i 0
    }
    incr i 1
    if { $digit } {
        puts -nonewline "X"
    } else {
        puts -nonewline "O"
    }
}



