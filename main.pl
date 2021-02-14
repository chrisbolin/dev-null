use strict;
use warnings;

use 5.16.0;

=comment
■ BLACK SQUARE (U+25A0)	
□ WHITE SQUARE (U+25A1)	
▢ WHITE SQUARE WITH ROUNDED CORNERS (U+25A2)	
▣ WHITE SQUARE CONTAINING BLACK SMALL SQUARE (U+25A3)	
▤ SQUARE WITH HORIZONTAL FILL (U+25A4)	
▥ SQUARE WITH VERTICAL FILL (U+25A5)	
▦ SQUARE WITH ORTHOGONAL CROSSHATCH FILL (U+25A6)	
▧ SQUARE WITH UPPER LEFT TO LOWER RIGHT FILL (U+25A7)	
▨ SQUARE WITH UPPER RIGHT TO LOWER LEFT FILL (U+25A8)	
▩ SQUARE WITH DIAGONAL CROSSHATCH FILL (U+25A9)	
▪ BLACK SMALL SQUARE (U+25AA)	
▫ WHITE SMALL SQUARE (U+25AB)	
▬ BLACK RECTANGLE (U+25AC)	
▭ WHITE RECTANGLE (U+25AD)	
▮ BLACK VERTICAL RECTANGLE (U+25AE)	
▯ WHITE VERTICAL RECTANGLE (U+25AF)	
=cut

sub print_matrix {
    my ($rows) = @_;
    for my $row (@$rows) {
        for my $char (@$row) {
            print $char || ' ';
        }
        print "\n";
    }
}

sub main {
    my %params = @_;
    my $matrix = [];

    for my $y ((1..$params{height})) {
        my $row;
        for my $x ((1..$params{width})) {
            my $value = $params{func}->($x, $y);
            push @$row, $params{palette}->[$value];
        }
        push @$matrix, $row;
    }

    print_matrix $matrix;
}

sub func_a {
    my ($x, $y) = @_;
    if ((($x % 13)* $y + $x / $y) % 5 == 0) {
        return 1;
    } elsif (($x * $y + $x / $y) % 7 == 0) {
        return 2;
    } elsif (($x * $y + $x / $y) % 17 == 0) {
        return 3;
    }
    return 0;
}

main(
    width => 190,
    height => 95,
    func => \&func_a,
    palette => [qw/ □ ▤ ▩ ■ /],
);

