#!/usr/bin/perl
use List::Util qw/first max maxstr min minstr reduce shuffle sum/;

open(IN,"$ARGV[0]");
open(I,"$ARGV[1]");
open(OUT,">$ARGV[2]");
open(OUT3,">test");
my %hash;
my $idpair;
my %sta;
my $n=1;

my %h1;
while (my $aa=<I>) {
	chomp $aa;
	if ($aa=~/>(\S+)/) {
		if (defined $id) {
			$h1{$id}=$seq;
			$id=$1;
			$seq="";
		}
		else {$id=$1;}
	}
	else {$seq.=$aa;}
}
$h1{$id}=$seq;

foreach $key (keys %h1) {
	$le=length($h1{$key});
	$length{$key}=$le;
}



while (<IN>) {
 
	chomp;
	@aline=split(/\s+/,$_);
	$idpair=$aline[0]."-".$aline[1];
	$sta{$idpair}=$aline[6];
	push (@{$hash{$idpair}},$_);
	$idpair2=$aline[0]."-".$aline[1]."-".$n;
	@{$hash2{$idpair2}}=$_;

    $sta2{$idpair2}=$aline[6];
	$n++;


}


foreach $key (keys %hash) {
        %tmphash=();
	@tmpid=();
	$m=0;
	foreach $key2 (keys %sta2) {
                @splitkey=split(/-/,$key2);
                $comparekey=$splitkey[0]."-".$splitkey[1];
		if($comparekey eq $key){
		push (@tmpid,$key2);
		}
	
	}



	foreach $tmpkey (@tmpid) {
			$tmphash{$tmpkey}=$sta2{$tmpkey};

		}

		@stasta=keys %tmphash;
		my $length=0;
                my %line;
                my @usenow=();
                my @uselast=();
                my $output=();
                my $add=();
                my @add2=();
                my $m=0;   
	foreach $usekey (sort{$tmphash{$a}<=>$tmphash{$b}} keys %tmphash) {
             
                 if($#stasta==0){
                @{$line{$m}}=@{$hash2{$usekey}};
                 $usenow2=join(",",@{$line{$m}});
                @usenow=split(/,/,$usenow2);      
                 @myusenow=split(/\s+/,$usenow[0]);
               $length=$myusenow[7]-$myusenow[6]+1;
                   }
                  

		if ($m<=$#stasta) {
  
 
		@{$line{$m}}=@{$hash2{$usekey}};
		$usenow2=join(",",@{$line{$m}});
		$uselast2=join (",",@{$line{$m-1}});
              @usenow=split(/\s+/,$usenow2);
              @uselast=split(/\s+/,$uselast2);
      
              
		if ($usenow[6]-$uselast[7]>1) {
			  push(@end,$usenow[7]);
                        push(@end,$uselast[7]);
                         
                       # $myend=max(@end);
                        #@end=();
                        #$add=();
                        $add=$usenow[7]-$usenow[6]+1;
			$sta=$usenow[6];
			$end=$usenow[7];
                        $length += $add;

		}
		else {
                       
			push(@end,$usenow[7]);
                        push(@end,$uselast[7]);
                       # $myend=max(@end);
                        $add=$usenow[7]-$usenow[6]+1;

                          $length += $add;



                            

		}
                
		$m++;
		      }
	}
 

    foreach $usekey (sort{$tmphash{$a}<=>$tmphash{$b}} keys %tmphash) {

		@out=@{$hash2{$usekey}};
 
		$output=join("\t",@out);
		@allidpair=split(/-/,$usekey);
		$geneid=$allidpair[0];
                $length2=abs($length);
		$ratio=$length2/$length{$geneid};
		print OUT "$output\t$length2\t$length{$geneid}\t$ratio\n";
    }
}


 
