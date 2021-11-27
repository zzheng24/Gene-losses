#!/usr/bin/perl -w
use strict;

my %hash;
open IN, "<$ARGV[0]-mouse.info"; # coordinats of corresponding mouse genes; need to be prepared
while (<IN>){
    my @item=split /\t/,$_;
    my $gene=$item[0];
    my $chr=$item[1];
    my $st=$item[2];
    my $ed=$item[3];
    if (exists $hash{$chr}){
        $hash{$chr}{$gene}="$st-$ed"; #在已有的哈希中添加健值对；
    }else{
      $hash{$chr}={$gene => "$st-$ed"};   #创建一个匿名的嵌套哈希；
    }
   
}

close IN;

#foreach my $i (sort keys %hash){
#    print "$i\t$hash{$i}\n";
#    foreach my $j (sort keys $hash{$i}){
#        print "$j\t$hash{$i}{$j}\n";
#    }
#}

open IN, "<$ARGV[0]-alignment-changed.info";
#open IN, "<test";
while (<IN>){
    my ($chr)=$_=~ /musculus.(\S+)\s+\d+/;
    my @item=split /\t/,$_;
    my $refst=$item[1];
    my $reflen=$item[2];
    my $refed=$refst+$reflen;
    my $tarst;
    my $tarlen;
    my $tared;
    if ($item[8]=~ /\+/){
        $tarst=$item[6];
        $tarlen=$item[7];
        $tared=$tarst+$tarlen;
    }else{
        $tarst=$item[9]-($item[6]+$item[7]);
        $tarlen=$item[7];
        $tared=$tarst+$tarlen;
    }
    my $tarchr=$item[5];
    
    if (exists $hash{$chr}){
        foreach my $gene (sort keys $hash{$chr}){
            my ($s)=$hash{$chr}{$gene}=~ /(\d+)-/;
            my ($e)=$hash{$chr}{$gene}=~ /-(\d+)/;
            if (($refed > $s) && ($refst < $e)){ #overlap
                my $overlap;
                if (($refed < $e) && ($refed > $s) && ($refst < $s)){
                    $overlap=$refed-$s;
                    my $ratio=$overlap/$reflen;
                    if ($ratio > 0.5){
                       $hash{$chr}{$gene} .="\t$tarchr--$tarst--$tared;";
                     }
                }elsif(($refst < $e) && ($refst > $s) && ($refed > $e)){
                    $overlap=$e-$refst;
                    my $len=$refed-$refst;
                    my $ratio=$overlap/$len;
                    if ($ratio > 0.5){
                       $hash{$chr}{$gene} .="\t$tarchr--$tarst--$tared;";
                     }
                }elsif(($refst > $s) && ($refed < $e)){
                    $hash{$chr}{$gene} .="\t$tarchr--$tarst--$tared;";
                }elsif(($refst < $s) && ($refed > $e)){
                    $hash{$chr}{$gene} .="\t$tarchr--$tarst--$tared;";
                }
                
            }
    }
}
}
close IN;

open OUT, ">$ARGV[0]-posi-from-alignment.info";
foreach my $i (sort keys %hash){
    foreach my $j (sort keys $hash{$i}){
        print OUT "$j\t$hash{$i}{$j}\n";
    }
}