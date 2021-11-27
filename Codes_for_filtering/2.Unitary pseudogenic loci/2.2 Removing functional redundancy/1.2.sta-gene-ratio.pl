#!/usr/perl/bin
open(IN,$ARGV[0]);
open(OUT,">$ARGV[1]");

print OUT "id\tcopy\tidentity\tl1\tmis\ttmp\tsta\tend\tsta\tend\tevalue\ttmp2\tcopy-match-length\tgene-length\tcopy-match-ratio\tgene-match-length\tgene-match-ratio\tgene-copy-num\n";
chomp(@all=<IN>);
foreach (@all){

chomp;
@aline=split;

if(defined $sta{$aline[0]}{$aline[1]}){
next;

}

else {
$num{$aline[0]}++;
$sta{$aline[0]}{$aline[1]}=1;
$hash{$aline[0]}+=$aline[12];

}


}


foreach (@all){
chomp;
@aline=split;
$ratio=$hash{$aline[0]}/$aline[13];
print OUT "$_\t$hash{$aline[0]}\t$ratio\t$num{$aline[0]}\n";



}






