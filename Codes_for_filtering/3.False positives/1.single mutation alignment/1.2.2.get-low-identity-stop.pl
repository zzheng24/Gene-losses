
#!/usr/bin/perl -w
use strict;
my %hash;
open(IN, "<one_mutation_list.txt") or die $!;
while (<IN>){
    my ($id)=$_=~ /^(\S+)/;
    $hash{$id}="ok";
}
close IN;


open(IN, "<protein-alignment.txt") or die $!;
open(OUT, ">low-identity-stop.txt") or die $!;
$/= ">";
while (<IN>) {
    chomp;
    my ($id)=$_=~ /(ENSMUSP\d+)/;
    if (exists $hash{$id}){
        my ($query, $target)=$_=~ /\d+\n(\S+)\n(\S+)$/;
        if ($target=~/X/){
        my ($bef_seq)=$target=~/^(\S+)X/;
        my $pos=length $bef_seq;
        my $q_ten_bef=substr ($query,$pos-30,30);
        my $q_ten_aft=substr ($query,$pos+1,30);
        my $t_ten_bef=substr ($target,$pos-30,30);
        my $t_ten_aft=substr ($target,$pos+1,30);
        
        my @q_ten_bef=split //, $q_ten_bef;
        my @q_ten_aft=split //, $q_ten_aft;
        my @t_ten_bef=split //, $t_ten_bef;
        my @t_ten_aft=split //, $t_ten_aft;
        my $bef_eq=0;
        my $aft_eq=0;
         for (0..29){
            if ($q_ten_bef[$_] eq $t_ten_bef[$_]){
                 print "$q_ten_bef[$_]\t$t_ten_bef[$_]\n";
                $bef_eq++;
            }
            }
        for (0..29){
            if($q_ten_aft[$_] eq $t_ten_aft[$_]){
                print "$q_ten_aft[$_]\t$t_ten_aft[$_]\n";
                $aft_eq++;
            }
       }
        my $bef_id=$bef_eq/30;
        my $aft_id=$aft_eq/30;
        if (($bef_id<0.4)|($aft_id<0.4)){
            print OUT "$id\n";
        }
           }
        }
}

close IN;
close OUT;