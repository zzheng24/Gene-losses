#!/usr/bin/perl -w
use strict;

open(IN, "<$ARGV[0].txt") or die ; # gene description file for each mouse gene
open(OUT, ">remaining.genes.txt") or die ;
while (<IN>){
if(/olfactory\sreceptor/){
    }
     elsif(/predicted\sgene/){
    }
      elsif(/zinc\sfinger\sprotein/){
    }
       elsif(/vomeronasal/){
    }
       elsif(/expressed\ssequence/){
    }
      else{
        print OUT $_;
    }
    
        }

close IN;
close OUT;



