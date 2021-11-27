#!/usr/bin/perl -w
use strict;

my $flag="ok";
open IN, "<2.$ARGV[0]-evalue-filtered";
open OUT, ">3.$ARGV[0]_copy_number.length";
my @gene;
while (<IN>){
    $_=~ s/\s+/\t/g;
    my @item=split /\t/, $_;
    if($item[0] ne $flag){
        my @para= copy (@gene);
        my $num=$para[0];
        my @length=@{$para[1]};
        foreach my $length (@length){
           print OUT "$flag\t$num\t$length\n"; 
        }
        
        
        undef @gene;
        push @gene, "$item[6]-$item[7]";
        $flag=$item[0];
    }else {
        push @gene, "$item[6]-$item[7]";
       #my $len=$e-$s;
       #my $num=@gene;#元素个数；
       
        
    }
     
}
        my @para= copy (@gene);
        my $num=$para[0];
        my @length=@{$para[1]};
        foreach my $length (@length){
           print OUT "$flag\t$num\t$length\n"; 
        }
        
  
close IN;
close OUT;
        
  

        
           
sub copy{
            my @copy;
            my @len;
            my $add=0;
            my $total=@gene;
            my $copy_num;
            while ($add < $total){
                  print "$add\n";
                  my $ref="0-0";
                  $copy_num++;
                  my $copy_len;
                  #print "$copy_num\n";
                  my $nb=$copy_num-1;
                  $copy[$nb]=[];
                  foreach my $pair (@gene){
                   my @item=split /-/, $pair;
                   my $num=@item;
                      if ($num==2){
                        my ($refs,$refe)=$ref=~ /(\d+)-(\d+)/;
                        my ($s,$e)=$pair=~ /(\d+)-(\d+)/;
                        my $len=$e-$s;
                        if($s < $refe){#有overlap；
                            if($e < $refe){#包含,not_add；

                              }else{#伸出，计算overlap长度，大于自身的50% not_add；
                                  my $overlap=$refe-$s;
                                  my $r=$overlap/$len;
                                     if($r > 0.5){#not_add；
                                        
                                     }else{#add；#长度加 “$e-$refe”
                                        $copy_len += $e-$refe;
                                        push $copy[$nb], $pair;
                                        $add++;
                                        $ref=$pair;
                                        $pair .= "-ok";
                                        
                                    }
                              }
                
                        }else{ #add #长度直接加 += $len;
                           $copy_len += $len;
                           push $copy[$nb], $pair;
                           $add++;
                           $ref=$pair;
                           $pair .= "-ok";   
                        }
                         
                        
                }
            }
            $len[$nb]=$copy_len;      
        
        
            
            
            
        }
            return ($copy_num,\@len);
        
}   