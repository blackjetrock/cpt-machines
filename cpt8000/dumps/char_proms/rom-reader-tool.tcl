#!/usr/bin/tclsh
#
################################################################################
#
# Tool to process rom-reader files
#
#
################################################################################


# Which command?

foreach arg $argv {
    puts $arg
}

# First argument is file, second command

if { [llength $argv] < 2} {
    puts "rom-reader-tool<file> <command> "
    exit
}

set file [lindex $argv 0]
set cmd  [lindex $argv 1]

proc read_file {filename} {
    set f [open $filename]
    set ftext [read $f]
    close $f

    set ::fullhexdata ""
    
    foreach line [split $ftext "\n"] {
	if { [regexp {([0-9A-Fa-f]+):([0-9A-Fa-f ]+)} $line all addr expdata ] } {
	    set compdata [string map {" " ""} $expdata]
	    puts -nonewline "A:$addr H:$compdata"
	    set hexdata [binary format H* $compdata]
	    puts "   $hexdata"
	    set ::fullhexdata "$::fullhexdata$hexdata"
	}
    }
}

################################################################################

proc write_binary_data {filename first_addr last_addr} {
    set bindata [string range $::fullhexdata $first_addr $last_addr]

    set f [open $filename wb]
    
    puts -nonewline $f $bindata
    close $f
}

################################################################################
#
# Check the multiple images in the file are the same
#
################################################################################

proc check_file {filename} {
    read_file $filename
}

proc to_bin {file} {
    read_file $file
    write_binary_data $file\.a.bin [expr [lindex $::argv 2]] [expr [lindex $::argv 3]]
}

switch $cmd {
    check {
	check_file $file
    }

    to-bin {
	to_bin $file
    }
}
