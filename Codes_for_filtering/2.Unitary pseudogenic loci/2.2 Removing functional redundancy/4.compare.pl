#!/usr/bin/perl -w
use strict;

my %len;
my $i;
open IN, "<../../$ARGV[0]-mouse-protein.fa";
while (<IN>){
    chomp;
    if(/>/){
        ($i)=$_=~ /(ENSMUSG\d+)/;
        $len{$i}="ok";
    }else{
        my $l =length $_;
        $len{$i}=$l;
    }
}
close IN;

my %hash;
open I, "<3.$ARGV[0]_copy_number.length";
open F, ">5.final.$ARGV[0]_copy_number_filtered.result";
open O, ">4.$ARGV[0]_copy_length.filtered";
while (<I>){
    chomp;
    my @item=split /\t/,$_;
    my $r= $item[2]/$len{$item[0]};
    if($item[1]<4){
       if(exists $hash{$item[0]}){ 
          if($r > 0.8){
            print O "$_\t$item[2]-$len{$item[0]}\n";
            $hash{$item[0]} +=1;
          }
       }else{
              print O "$_\t$item[2]-$len{$item[0]}\n";
              $hash{$item[0]} +=1; 
       }
    }else{
        if(exists $hash{$item[0]}){
             if($r > 0.6){
              print O "$_\t$item[2]-$len{$item[0]}\n";
              $hash{$item[0]} +=1;  
            }   
        }else{
              print O "$_\t$item[2]-$len{$item[0]}\n";
              $hash{$item[0]} +=1; 
        }
    }
}
close I;
close O;


foreach my $k (sort keys %hash){
    if ($hash{$k} == 1 ){
        print F "$k\n";
    }
}

