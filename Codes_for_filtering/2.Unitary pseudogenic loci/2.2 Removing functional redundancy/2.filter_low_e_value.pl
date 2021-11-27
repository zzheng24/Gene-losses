#!/usr/bin/perl -w
use strict;

    open IN, "<1.$ARGV[0]-final2";
    open OUT, ">2.$ARGV[0]-evalue-filtered";
    
    while (<IN>){
        $_=~ s/\s+/\t/g;
        my @item=split /\t/, $_;
        if ($item[10] < 1E-03){
            print OUT "$_\n";
        }
    }
    close IN;
    close OUT;

