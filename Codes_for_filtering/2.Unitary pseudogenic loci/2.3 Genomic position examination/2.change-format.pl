#!/usr/bin/perl -w
use strict;

    open IN, "<$ARGV[0]-alignment.info";
    open OUT, ">$ARGV[0]-alignment-changed.info";
    while (<IN>){
        if (/mus_musculus/){
            $_=~ s/\n/\t/;
            $_=~ s/\s+/\t/g;
            print OUT $_;
        }else{
            $_=~ s/\s+/\t/g;
            print OUT "$_\n";
        }
    }
    close IN;
    close OUT;
