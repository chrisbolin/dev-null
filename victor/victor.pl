use strict;
use warnings;

use Data::Dumper;

main();

sub main {
    my $path = "$0image.svg";
    $path =~ s/victor\.pl//;
    write_file($path, demo());
    
    print `cat $path`;

    print "\nFinished.";
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
    my $letters = 'EL FIN';
    my $inside = <<"EOF";
      <rect width="100%" height="100%" fill="red" />
      <circle cx="150" cy="100" r="80" fill="green" />
      <text x="150" y="120" font-size="60" text-anchor="middle" fill="white">
        $letters
      </text>
EOF
    return svg([$inside]);
}

sub get_props {
    my ($thing) = @_;
    
    # if it's a hash, return it
    return $thing if ref($thing) eq 'HASH';
    return { children => $thing } if ref($thing) eq 'ARRAY';
    return { children => [$thing] } if ref($thing) eq '';
}

sub props {
    my $props = get_props(@_);
    $props->{child} = join(" ", @{$props->{children}});
    return $props;
}

sub svg {
    my $props = props(@_);

    return <<"EOF";
<svg version="1.1"
   baseProfile="full"
   width="300" height="200"
   xmlns="http://www.w3.org/2000/svg">
    $props->{child}
</svg>
EOF
}

