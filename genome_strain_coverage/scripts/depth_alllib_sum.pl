#!/usr/bin/perl

use strict;
use warnings;
use File::Spec;
use Getopt::Long;

my ($bamlist,$srainfo);
GetOptions('b|bamlist:s'  => \$bamlist,
	   's|srastrain:s' => \$srainfo);

if ( ! $bamlist || ! -f $bamlist ) {
    die "need the bamlist";
}

my %info2strain;
if( $srainfo ) {
    open(my $fh => $srainfo) || die $!;
    while(<$fh>) {
	next if /^\#/;
	my ($info,$strain) = split;
	$info2strain{$info} = $strain;
    }
}

my @bamfiles;
open(my $fh => $bamlist) || die $!;
while(<$fh>) {
    my (undef,undef,$file) = File::Spec->splitpath($_);
    my ($base);
    if ($file =~ /(\S+)\.realign\.bam/) {
	my ($libname) = ($1);
	my $strain = $info2strain{$libname} || $libname;
	push @bamfiles, [$file,$strain];
    } else {
	warn("cannot parse $file\n");
    }
}
my %suminfo;
my $bases = 0;
while(<>) {
    my ($chr,$pos,@matches) = split;
    my $i = 0;
    for my $m ( @matches ) {
	$suminfo{$bamfiles[$i]->[1]} += $m;
	$i++;
    }
    $bases++;
}
print join("\t", qw(#STRAIN BASECT READCT AVG_COVERAGE)),"\n";
for my $strain ( sort keys %suminfo ) {
    print join("\t", $strain, $bases, $suminfo{$strain}, sprintf("%.2f",$suminfo{$strain} / $bases)), "\n";
}
