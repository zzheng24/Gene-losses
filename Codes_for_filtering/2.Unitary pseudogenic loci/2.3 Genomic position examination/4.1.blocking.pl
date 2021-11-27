#!/usr/bin/perl -w
use strict;

open IN, "<$ARGV[0]-posi-from-alignment.info";
open OUT, ">$ARGV[0]-alignment-block.info";
while (<IN>){
    chomp;
    undef my  %hash;
    my @item=split /\t/,$_;
    my $num=@item;
    for (2..$num){
        my ($id,$s1,$e1)=$item[$_]=~ /(\S+)--(\d+)--(\d+)\;/;
        #print "$id\t$s1\t$e1\n";
        if ($e1=~/\S+/){
        if (exists $hash{$id}){
            my ($refs,$refe)=$hash{$id}=~ /(\d+)--(\d+)/;
            
            if ($s1 >= $refe){# 往右扩展，无overlapping；
                $hash{$id}="$refs--$e1";
            }
            
            elsif(($s1 >= $refs) && ($s1 < $refe) && ($e1 > $refe)){#往右扩展，有overlapping；
                $hash{$id}="$refs--$e1";
            }
            
            elsif(($s1 >= $refs) && ($e1 <= $refe) ){#完全overlapping，ref长；
                
            }
            
            elsif(($s1 < $refs) && ($e1 > $refe)){#完全overlapping，ref短；
                $hash{$id}="$s1--$e1";
            }
            
            elsif(($e1 > $refs) && ($e1 <= $refe) && ($s1 < $refs)){#往左扩展，有overlapping；
                $hash{$id}="$s1--$refe";
            }
            
            elsif($e1 <= $refs){# 往左扩展，无overlapping；
                $hash{$id}="$s1--$refe";
            }
        }else{
            $hash{$id}="$s1--$e1";
        }
    }
    }
    
   foreach my $i (sort keys %hash){
    print OUT "$item[0]\t$item[1]\t$i\t$hash{$i}\n";
   }
}

close IN;
close OUT;
