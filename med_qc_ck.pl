#!usr/bin/perl
#数据量、错误率、Q30
use warnings;
use strict;

open IN,"@ARGV";
my ($i,$q,$e,@nn,@EE,@QQ);
my $header=<IN>;
while (<IN>){
	my @all = split/\t/,$_;	
	$all[4]=~ s/(.*)G$//;
	my $after=$1;
	if ($after<6){
		push @nn,$_;
	#	print "$all[1]\t$all[4]\n";
		$i++;
	}
	if ($all[6]>0.1){
		push @EE,$_;
		$e++;
	}
	if ($all[8]<95){
		push @QQ,$_;
		$q++;
	}
}

if ($i){
	#my $ll="-X10"."\n";	
	print '-'x40, "#there be $i sample 【data not enough】#",'-'x30,"\n";
	print $header,@nn;
}
if ($e){
	#my $ll="-X10"."\n";	
	print '-'x40,"#there be $e sample 【error too high】#",'-'x30,"\n";
	print $header,@EE;
}
if ($q){
	#my $ll="-X10"."\n";	
	print '-'x40,"#there be $q sample 【Q30 too low】#",'-'x30,"\n";
	print $header,@QQ;
}
if (!defined $i && !defined $e && !defined $q){
	print "all OK\n";	
}
