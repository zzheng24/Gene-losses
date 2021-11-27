Usage: merged psl files from BLAT were used as input; NMR were used as example.

1.1
perl stablast3.pl NMR-sorted-merged.psl NMR-mouse-protein.fa NMR.out

less NMR.out |sort  -sb -k 1,1 >NMR-sort.out

1.2
perl sta-gene-ratio.pl NMR-sort.out NMR-final

less NMR-final  |sort -nk7 |sort  -sb -k 1,1 >NMR-final2


2
Perl filter_low_e_value.pl NMR


3
Perl copy_number_sta.pl NMR

4
Perl compare.pl NMR