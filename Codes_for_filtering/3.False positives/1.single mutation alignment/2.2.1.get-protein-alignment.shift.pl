#!/usr/bin/perl -w
use strict;
#my %hash;
#open(IN, "<one_mutation_list.txt") or die $!;
#while (<IN>){
#    my ($id)=$_=~ /^(\S+)/;
#    $hash{$id}="ok";
#}
#close IN;

open(IN, "<pseudogene-genewise.txt") or die $!;
open(OUT, ">protein-alignment.txt") or die $!;
my $start;
my $raw;
my $que_seq;
my $tar_seq;
my $que_num=0;
my $tar_num=0;
my $id;
while (<IN>){
    if (/Query\sprotein/){
        ($id)=$_=~/(ENSMUSP\d+)/;
    }
    
    
    if (/See\sWWW/){
        $start=1;
        $raw=0;
    }
    elsif(/\.sp\.tr/){
        $start=0;
   }
    
    if ($start==1){
       $raw++;
       my $que_seg;
       my $tar_seg;
       if ($raw==3){
        ($que_seg)=$_=~/ENSMUSP\d+\s+\d+\s(.*)$/;
        #print "$que_seg";
        $que_seg=~ s/\s//g;
        
        $que_seq.=$que_seg;
        $que_num=3;
        #print $que_seq;
       }elsif($raw==5){
        ($tar_seg)=$_=~/^(.*)$/;
        $tar_seg=~ s/\S\:\S\[\S+\]//g;
        $tar_seg=~ s/\s//g;
        $tar_seq.=$tar_seg;
        $tar_num=5;
       }
       if ($raw == $que_num+8){
        $que_num=$raw;
        ($que_seg)=$_=~/ENSMUSP\d+\s+\d+\s+(.*)$/;
        $que_seg=~ s/\s//g;
        $que_seq.=$que_seg;
        
       }elsif($raw == $tar_num+8){
        $tar_num=$raw;
        ($tar_seg)=$_=~/^(.*)$/;
        $tar_seg=~ s/\S\:\S\[\S+\]//g;
        $tar_seg=~ s/\s//g;
        $tar_seq.=$tar_seg;
        }
       
    }elsif (/Name/){
        $start=0;
        print OUT ">$id\n$que_seq\n$tar_seq\n";
        #print "$id\n$que_seq\n$tar_seq\n";
        undef $que_seq;
        undef $tar_seq;
    }
}
close IN;
close OUT;