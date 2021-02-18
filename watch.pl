use v5.10;
use strict;
use warnings;

my $filename = $ARGV[0] || die "file name required";
my $filename_and_args = join(" ", @ARGV);
my $prev_changed = "";

while () {
    my $last_changed = `stat $filename`;
    if ($last_changed ne $prev_changed) {
        system "clear";
        system "perl $filename_and_args";
    }
    $prev_changed = $last_changed;
    sleep 1;
}
