use v5.10;
use strict;
use warnings;

my $script_path = $ARGV[0] || die "file name required";

my $i = 0;

say "press Enter to print script...";
while (<STDIN>) {
    system "clear";
    system "perl $script_path";
    chomp(my $timestamp = `date +%Y-%m-%dT%H.%M.%S%z`);
    my $print_file = "print-$timestamp.png";
    sleep 1;
    system "screencapture $print_file";
    say "Printed $i. ($print_file)";
    $i++;
}

