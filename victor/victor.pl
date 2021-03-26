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
    return svg([
        rect({ fill => '#333' }),
        '<circle cx="150" cy="100" r="80" fill="black" />',
    ]);
}

sub props_polymorphic {
    my ($thing) = @_;
    
    # if it's a hash, return it
    return $thing if ref($thing) eq 'HASH';
    return { children => $thing } if ref($thing) eq 'ARRAY';
    return { children => [$thing] } if ref($thing) eq '';
}

sub props {
    my ($raw_props, $defaults) = @_;
    my %props = (
        %{$defaults // {}},
        %{props_polymorphic($raw_props)},
    );
    $props{child} = join(" ", @{$props{children} // []});
    return \%props;
}

# standard components

sub svg {
    my $props = props(@_);

    return <<"EOF";
        <svg version="1.1"
           baseProfile="full"
           width="600" height="400"
           xmlns="http://www.w3.org/2000/svg">
            $props->{child}
        </svg>
EOF
}

sub rect {
    my $props = props(@_, {
        fill   => 'blue',
        width  => '100%',
        height => '100%',
    });
    return qq(<rect width="100%" height="100%" fill="$props->{fill}" />);
}


