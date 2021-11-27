#!/usr/bin/perl -w
use strict;

my %hash;
my %gene;
open IN, "<Mus_musculus.GRCm38.pep.all.fa";
while (<IN>){
    if (/>/){
      my ($p,$g)=$_=~ /(ENSMUSP\d+).*(ENSMUSG\d+)/;
      #print "$p\t$g\n";
      $hash{$p}=$g;
    }
    
}

close IN;


open IN, "<$ARGV[0]-mouse.info";
while (<IN>){
      my ($g)=$_=~ /(ENSMUSG\d+)/;
      $gene{$g}="ok";
    
}

close IN;


open I, "$ARGV[0].pseudo.list";
open O, ">$ARGV[0].po";
while (<I>){
    my ($p)=$_=~ /(ENSMUSP\d+)/;
    if (exists $hash{$p}){
        my $line="$hash{$p}\t$_";
        print "$line";
        if(exists $gene{$hash{$p}}){
          print O $line;  
        }
        
    }
    
}
close I;
close O;