#!/usr/bin/perl -w
# randomly shuffle read alignments between sample/control (used to generate background for CSAR peaks)

use strict;

my $usage = "Usage: perl shuffle_reads_CSAR.pl sample_fn control_fn shuffled_sample_fn shuffled_control_fn [options]\n\toptions are [-noPCR] to ignore clone count (ie assign all clones to either sample or control)\n";
my $sample_file = shift or die $usage;
my $control_file = shift or die $usage;
my $shuffled_sample_file = shift or die $usage;
my $shuffled_control_file = shift or die $usage;
my $useCloneCount = 1;
while (my $opt = shift) {
	if ($opt eq "-noPCR") {
		$useCloneCount = 0;
	}
	else {
		die "Invalid option $opt\n";
	}
}

open(SAMPLE_IN, "<$sample_file") || die "Unable to open: $!";
open(CONTROL_IN, "<$control_file") || die "Unable to open: $!";
open(SHUFFLED_SAMPLE_OUT, ">$shuffled_sample_file") || die "Unable to write to: $!";
open(SHUFFLED_CONTROL_OUT, ">$shuffled_control_file") || die "Unable to write to: $!";

# randomly mix alignments from sample and control
while (my $line = <SAMPLE_IN>) {
	chomp $line;
	my ($idstr, $chrom, $strand, $start, $end, $seed_mm, $all_mm, $nocc) = split(/\t/, $line);
	my ($id, $count, $len) = split(/@@/, $idstr);
	my $samp_count = 0;
	my $contr_count = 0;
	if ($useCloneCount) {
		for (my $i = 0; $i < $count; $i++) {
			if (int(rand(2)) == 1) {
				$samp_count++;
			}
			else {
				$contr_count++;
			}
		}
	}
	else {
		(int(rand(2)) == 1) ? $samp_count = $count : $contr_count = $count;
	}
	
	if ($samp_count > 0) {
		print SHUFFLED_SAMPLE_OUT "$id\@\@$samp_count\@\@$len\t$chrom\t$strand\t$start\t$end\t$seed_mm\t$all_mm\t$nocc\n";
	}
	if ($contr_count > 0) {
		print SHUFFLED_CONTROL_OUT "$id\@\@$contr_count\@\@$len\t$chrom\t$strand\t$start\t$end\t$seed_mm\t$all_mm\t$nocc\n";
	}
}
while (my $line = <CONTROL_IN>) {
	chomp $line;
	my ($idstr, $chrom, $strand, $start, $end, $seed_mm, $all_mm, $nocc) = split(/\t/, $line);
	my ($id, $count, $len) = split(/@@/, $idstr);
	my $samp_count = 0;
	my $contr_count = 0;
	if ($useCloneCount) {
		for (my $i = 0; $i < $count; $i++) {
			if (int(rand(2)) == 1) {
				$samp_count++;
			}
			else {
				$contr_count++;
			}
		}
	}
	else {
		(int(rand(2)) == 1) ? $samp_count = $count : $contr_count = $count;
	}
	if ($samp_count > 0) {
		print SHUFFLED_SAMPLE_OUT "$id\@\@$samp_count\@\@$len\t$chrom\t$strand\t$start\t$end\t$seed_mm\t$all_mm\t$nocc\n";
	}
	if ($contr_count > 0) {
		print SHUFFLED_CONTROL_OUT "$id\@\@$contr_count\@\@$len\t$chrom\t$strand\t$start\t$end\t$seed_mm\t$all_mm\t$nocc\n";
	}
}

close(SAMPLE_IN);
close(CONTROL_IN);
close(SHUFFLED_SAMPLE_OUT);
close(SHUFFLED_CONTROL_OUT);


