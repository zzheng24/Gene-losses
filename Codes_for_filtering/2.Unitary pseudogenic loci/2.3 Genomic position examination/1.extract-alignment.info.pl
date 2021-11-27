#!/usr/bin/perl -w
use strict;

my @file=glob "*.maf";# all MAF files
my $i;
my $j;
foreach my $file (@file){
    open IN, "<$file";
    open OUT, ">>$ARGV[0]-alignment.info";
    while (<IN>){
    if (/^a\s/){
        $i++;
    }
    if (/^s\s/){
        $_=~ s/\s+/\t/g;
        my @item=split /\t/, $_;
        print OUT "$item[1]\t$item[2]\t$item[3]\t$item[4]\t$item[5]\n";
        $j++;
    }
    }
    close OUT;
    close IN;
}
my $h=$i*2;

print "$h\t$j\n";
