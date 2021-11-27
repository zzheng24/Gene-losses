
#!/usr/bin/perl -w
use strict;
my %hash;
open(IN, "<one_mutation_list.txt") or die $!;
while (<IN>){
    my ($id)=$_=~ /^(\S+)/;
    $hash{$id}="ok";
}
close IN;


open(IN, "<pseudogene-genewise.txt") or die $!;
open(OUT, ">splicing-shift.txt") or die $!;
open(OUTT, ">ending-shift.txt") or die $!;
$/= "//";
while (<IN>) {
        if ((/\![A-Z]\s\s\s/)|(/\s\s\s[A-Z]\!/) |(/\!\s\s\s/)|(/\s\s\s\!/)){
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
            $_=~ /(.*)tr(\S+)$/;
               my $len=length $2;
               if ($len < 50){ #rough cutoff
                if (exists $hash{$id}){
                    print OUTT "$id\n"; 
                }
               
            } 
            }
            
        }
#}

close IN;
close OUT;
close OUTT;