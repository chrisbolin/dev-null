use strict;
use warnings;

use 5.16.0;
use Math::Trig;

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
▰ BLACK PARALLELOGRAM (U+25B0)	
▱ WHITE PARALLELOGRAM (U+25B1)	
▲ BLACK UP-POINTING TRIANGLE (U+25B2)	
△ WHITE UP-POINTING TRIANGLE (U+25B3)	
▴ BLACK UP-POINTING SMALL TRIANGLE (U+25B4)	
▵ WHITE UP-POINTING SMALL TRIANGLE (U+25B5)	
▶ BLACK RIGHT-POINTING TRIANGLE (U+25B6)	
▷ WHITE RIGHT-POINTING TRIANGLE (U+25B7)	
▸ BLACK RIGHT-POINTING SMALL TRIANGLE (U+25B8)	
▹ WHITE RIGHT-POINTING SMALL TRIANGLE (U+25B9)	
► BLACK RIGHT-POINTING POINTER (U+25BA)	
▻ WHITE RIGHT-POINTING POINTER (U+25BB)	
▼ BLACK DOWN-POINTING TRIANGLE (U+25BC)	
▽ WHITE DOWN-POINTING TRIANGLE (U+25BD)	
▾ BLACK DOWN-POINTING SMALL TRIANGLE (U+25BE)	
▿ WHITE DOWN-POINTING SMALL TRIANGLE (U+25BF)	
◀ BLACK LEFT-POINTING TRIANGLE (U+25C0)	
◁ WHITE LEFT-POINTING TRIANGLE (U+25C1)	
◂ BLACK LEFT-POINTING SMALL TRIANGLE (U+25C2)	
◃ WHITE LEFT-POINTING SMALL TRIANGLE (U+25C3)	
◄ BLACK LEFT-POINTING POINTER (U+25C4)	
◅ WHITE LEFT-POINTING POINTER (U+25C5)	
◆ BLACK DIAMOND (U+25C6)	
◇ WHITE DIAMOND (U+25C7)	
◈ WHITE DIAMOND CONTAINING BLACK SMALL DIAMOND (U+25C8)	
◉ FISHEYE (U+25C9)	
◊ LOZENGE (U+25CA)	
○ WHITE CIRCLE (U+25CB)	
◌ DOTTED CIRCLE (U+25CC)	
◍ CIRCLE WITH VERTICAL FILL (U+25CD)	
◎ BULLSEYE (U+25CE)	
● BLACK CIRCLE (U+25CF)	
◐ CIRCLE WITH LEFT HALF BLACK (U+25D0)	
◑ CIRCLE WITH RIGHT HALF BLACK (U+25D1)	
◒ CIRCLE WITH LOWER HALF BLACK (U+25D2)	
◓ CIRCLE WITH UPPER HALF BLACK (U+25D3)	
◔ CIRCLE WITH UPPER RIGHT QUADRANT BLACK (U+25D4)	
◕ CIRCLE WITH ALL BUT UPPER LEFT QUADRANT BLACK (U+25D5)	
◖ LEFT HALF BLACK CIRCLE (U+25D6)	
◗ RIGHT HALF BLACK CIRCLE (U+25D7)	
◘ INVERSE BULLET (U+25D8)	
◙ INVERSE WHITE CIRCLE (U+25D9)	
◚ UPPER HALF INVERSE WHITE CIRCLE (U+25DA)	
◛ LOWER HALF INVERSE WHITE CIRCLE (U+25DB)	
◜ UPPER LEFT QUADRANT CIRCULAR ARC (U+25DC)	
◝ UPPER RIGHT QUADRANT CIRCULAR ARC (U+25DD)	
◞ LOWER RIGHT QUADRANT CIRCULAR ARC (U+25DE)	
◟ LOWER LEFT QUADRANT CIRCULAR ARC (U+25DF)	
◠ UPPER HALF CIRCLE (U+25E0)	
◡ LOWER HALF CIRCLE (U+25E1)	
◢ BLACK LOWER RIGHT TRIANGLE (U+25E2)	
◣ BLACK LOWER LEFT TRIANGLE (U+25E3)	
◤ BLACK UPPER LEFT TRIANGLE (U+25E4)	
◥ BLACK UPPER RIGHT TRIANGLE (U+25E5)	
◦ WHITE BULLET (U+25E6)	
◧ SQUARE WITH LEFT HALF BLACK (U+25E7)	
◨ SQUARE WITH RIGHT HALF BLACK (U+25E8)	
◩ SQUARE WITH UPPER LEFT DIAGONAL HALF BLACK (U+25E9)	
◪ SQUARE WITH LOWER RIGHT DIAGONAL HALF BLACK (U+25EA)	
◫ WHITE SQUARE WITH VERTICAL BISECTING LINE (U+25EB)	
◬ WHITE UP-POINTING TRIANGLE WITH DOT (U+25EC)	
◭ UP-POINTING TRIANGLE WITH LEFT HALF BLACK (U+25ED)	
◮ UP-POINTING TRIANGLE WITH RIGHT HALF BLACK (U+25EE)	
◯ LARGE CIRCLE (U+25EF)	
◰ WHITE SQUARE WITH UPPER LEFT QUADRANT (U+25F0)	
◱ WHITE SQUARE WITH LOWER LEFT QUADRANT (U+25F1)	
◲ WHITE SQUARE WITH LOWER RIGHT QUADRANT (U+25F2)	
◳ WHITE SQUARE WITH UPPER RIGHT QUADRANT (U+25F3)	
◴ WHITE CIRCLE WITH UPPER LEFT QUADRANT (U+25F4)	
◵ WHITE CIRCLE WITH LOWER LEFT QUADRANT (U+25F5)	
◶ WHITE CIRCLE WITH LOWER RIGHT QUADRANT (U+25F6)	
◷ WHITE CIRCLE WITH UPPER RIGHT QUADRANT (U+25F7)	
◸ UPPER LEFT TRIANGLE (U+25F8)	
◹ UPPER RIGHT TRIANGLE (U+25F9)	
◺ LOWER LEFT TRIANGLE (U+25FA)	
◻ WHITE MEDIUM SQUARE (U+25FB)	
◼ BLACK MEDIUM SQUARE (U+25FC)	
◽ WHITE MEDIUM SMALL SQUARE (U+25FD)	
◾ BLACK MEDIUM SMALL SQUARE (U+25FE)	
◿ LOWER RIGHT TRIANGLE (U+25FF)
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
            my $value = $params{func}->($x, $y, $params{palette});
            push @$row, $params{palette}->[$value];
        }
        push @$matrix, $row;
    }

    print_matrix $matrix;
}

sub func_a {
    my ($_x, $_y) = @_;
    my $x = $_x / 2;
    my $y = $_y;
    if ((($x % 13)* $y + $x / $y) % 5 == 0) {
        return 1;
    } elsif (($x * $y + $x / $y) % 7 == 0) {
        return 2;
    } elsif (($x * $y + $x / $y) % 11 == 0) {
        return 3;
    }
    return 0;
}

sub funci_b {
    my ($_x, $_y) = @_;
    my $x = sin($_x / 20) * 8;
    my $y = sin($_y / 20) * 3 - 30.01;
    ($y, $x) = ($x, $y);

    if (($x * $y + $x / $y) % 5 == 0) {
        return 1;
    } elsif (($x * $y + $x / $y) % 7 == 0) {
        return 2;
    } elsif (($x * $y + $x / $y) % 11 == 0) {
        return 3;
    } elsif (($x * $y + $x / $y) % 13 == 0) {
        return 4;
    }
    return 0;
}


sub func_c {
    my ($x, $y) = @_;

    if (($x * $y + $x / $y) % 5 == 0) {
        return 1;
    } elsif (($x * $y + $x / $y) % 7 == 0) {
        return 2;
    } elsif (($x * $y + $x / $y) % 11 == 0) {
        return 3;
    } elsif (($x * $y + $x / $y) % 13 == 0) {
        return 4;
    }
    return 0;
}

sub func_d {
    my ($x, $y, $palette) = @_;
    my $z = scalar(@$palette) - 1;
    my $a = (
        $y
        + abs(($x % (2 * $z)) - $z)
    ) % ($z + 1);

    if ((($x % 7)* $y + $x / $y) % ($z + 2) == 0) {
        return $a;
    }
}    

main(
    width => $ARGV[0],
    height => $ARGV[1],
    func => \&func_d,
    palette => [qw/ 0 ▨ ▩ ■ /],
);

