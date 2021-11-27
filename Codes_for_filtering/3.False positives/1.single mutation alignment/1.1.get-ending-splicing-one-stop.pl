
#!/usr/bin/perl -w
use strict;
my %hash;
open(IN, "<one_mutation_list.txt") or die $!;# need to be prepared
while (<IN>){
    my ($id)=$_=~ /^(\S+)/;
    $hash{$id}="ok";
}
close IN;


open(IN, "<pseudogene-genewise.txt") or die $!;
open(OUT, ">splicing-stop.txt") or die $!;
open(OUTT, ">ending-stop.txt") or die $!;
$/= "//";
while (<IN>) {
        if (/\:X\[\S+\]/){
           my ($id)=$_=~ /Query protein\:\s+(ENSMUSP\d+)/; 
           if (exists $hash{$id}){
            print "$id\n";
            print OUT "$id\n";
           }
        }elsif(/\.sp\.tr/){
            my ($id)=$_=~ />(ENSMUSP\d+)/;
            $_=~ s/\s//g;
            $_=~ s/\n//g;
            $_=~ s/\r//g;
            if (/\*/){
               my ($prot)=$_=~/\*(\S+)$/;
               my $len=length $prot;
               if ($len < 50){ #rough cutoff
                if (exists $hash{$id}){
                    print OUTT "$id\n"; 
                }
               
            } 
            }
            
        }
    }
#}

close IN;
close OUT;
close OUTT;