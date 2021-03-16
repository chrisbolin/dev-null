use strict;
use warnings;

main();

sub main {
    my $path = "$0image.svg";
    $path =~ s/victor\.pl//;
    write_file($path, demo());
    print 'Finished.';
}

sub write_file {
    my ($path, $string) = @_;
    
    unless(open(FILE, '>' . $path)) {
        die "Unable to write file: $path\n";
    }

    print FILE $string;

    close FILE;
}

sub demo {
    return <<'EOF';
<svg version="1.1"
   baseProfile="full"
   width="300" height="200"
   xmlns="http://www.w3.org/2000/svg">
      <rect width="100%" height="100%" fill="red" />
      <circle cx="150" cy="100" r="80" fill="green" />
      <text x="150" y="125" font-size="60" text-anchor="middle" fill="white">SVG</text>
</svg>
EOF
}
