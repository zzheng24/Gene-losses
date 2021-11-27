#!/usr/bin/perl -w
use strict;

my %len;
open IN, "<$ARGV[0]-alignment-block.info";
while (<IN>){
     chomp;
    $_=~ s/\s+/\t/;
    my @item=split /\t/,$_;
    my $gene=$item[0];
    #my ($st,$ed)=$item[1]=~ /(\d+)-(\d+)/;
    my ($st)=$item[3]=~/(\d+)--/;
    my ($ed)=$item[3]=~ /--(\d+)/;
    my $len=$ed-$st;
    $len{$gene} += $len;
}
close IN;

my %hash;
open IN, "<$ARGV[0]-alignment-block.info";
while (<IN>){
    chomp;
    $_=~ s/\s+/\t/;
    my @item=split /\t/,$_;
    my $gene=$item[0];
    my ($chr)=$item[2]=~ /\w+.(\S+)/;
    my $po=$item[3];
    my $total;
    if (exists $hash{$gene}){
        $total=$len{$gene};
        $hash{$gene}{$chr}="$po---$total";
    }else{
      $total=$len{$gene};
      $hash{$gene}={$chr => "$po---$total"};  
    }
   
}

close IN;



open IN, "<$ARGV[0].po";
open OUT, ">$ARGV[0].result";
while (<IN>){
    chomp;
    my $line=$_;
    $line=~ s/\s+/\t/;
    my @item=split /\t/,$line;
    my $gene=$item[0];
    #print $gene;
    #my ($chr)=$item[2]=~ /gb\|(\S+)\|/;#for NMR, BMR; 
    my $chr=$item[2];#for Cavia, Rat;
    #print "$chr\n";
    my $st1=$item[3];# for test
    my $ed1=$item[4];# for test
    if (exists $hash{$gene}{$chr} ){# same scaffold
        #print $hash{$gene}{$chr};
        my ($refst, $refed, $total)=$hash{$gene}{$chr}=~ /(\d+)--(\d+)---(\d+)/; #from block; ref
        my $reflen=$refed-$refst;
        #print "$st2\t$ed2\n";
        if (($ed1 > $refst) && ($st1 < $refed)){ 
            my $overlap;
            if(($ed1 > $refst) && ($ed1 <= $refed) && ($st1 < $refst)){
               $overlap=$ed1-$refst;
               my $ratio1=$overlap/$reflen;
               my $ratio2=$reflen/$total;
               if (($ratio1 > 0.1 ) && ($ratio2 > 0.1)){
                print OUT "$line\tConserved\t$overlap\t$ratio1\t$ratio2\n";
               }
               
            }elsif(($st1 >= $refst) && ($st1 < $refed) && ($ed1 > $refed)){
               $overlap=$refed-$st1;
               my $ratio1=$overlap/$reflen;
               my $ratio2=$reflen/$total;
               if (($ratio1 > 0.1 ) && ($ratio2 > 0.1)){
                print OUT "$line\tConserved\t$overlap\t$ratio1\t$ratio2\n";
               }
            }elsif(($st1 >= $refst) && ($ed1 <= $refed)){
               $overlap=$ed1-$st1;
               my $ratio1=$overlap/$reflen;
               my $ratio2=$reflen/$total;
              # if (($ratio1 > 0.1 ) && ($ratio2 > 0.1)){
                print OUT "$line\tConserved\t$overlap\t$ratio1\t$ratio2\n";
               #}
            }elsif(($st1 < $refst) && ($ed1 > $refed)){#
               $overlap=$refed-$refst;
               my $ratio1=$overlap/$reflen;
               my $ratio2=$reflen/$total;
               if (($ratio1 > 0.1 ) && ($ratio2 > 0.1)){
                print OUT "$line\tConserved\t$overlap\t$ratio1\t$ratio2\n";
               }
            }
            
        }else{
            #print OUT "$line\tNot_Conserved\tNA\tNA\n";
        }
        
        
    }else{
            #print OUT "$line\tNot_Conserved\tNA\tNA\n";
    }
}

close IN;
close OUT;