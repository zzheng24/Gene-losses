#!/usr/bin/perl -w
use strict;

open(IN, "<ARGV[0]") or die $!; #genblasta.genewise.output.txt
open(OUT, ">temp.txt") or die $!;
$/= "//";
while (<IN>) {
    if(/(!)/){
          $_ =~ /Query protein:\s+(ENSMUSP\d+)/;
          print OUT "$1\n";
    }
    
    elsif(/\*/) {
            $_ =~ />(ENSMUSP\d+)/;
          print OUT "$1\n";
        }
}

close IN;
close OUT;

system ("sort temp.txt|uniq >candidate-pseudogenes.txt");
system ("rm temp.txt");