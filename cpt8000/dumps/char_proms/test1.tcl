#!/usr/bin/tclsh

set a1 "abcd"
set a2 "wxyz"

foreach {ad1 ad2 bd1 bd2} {$a1 $a2} {
    puts "$ad1 $ad2 $bd1 $bd2"
}
