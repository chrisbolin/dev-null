use strict;
use warnings;

use 5.16.0;

my $results = [
    {'estimated_revenue' => '0.15', 'type_tag' => 'ipad', 'user_country' => 'Zimbabwe', 'raw_srpvs' => '146', 'epoch' => '1606780800',},
    {'estimated_revenue' => '0.04', 'type_tag' => 'ipadext', 'user_country' => 'Zimbabwe', 'raw_srpvs' => '146', 'epoch' => '1606780800',},
    {'estimated_revenue' => '3.03', 'type_tag' => 'other', 'user_country' => 'US', 'raw_srpvs' => '146', 'epoch' => '1606780800',},
    {'estimated_revenue' => '1.01', 'type_tag' => 'ipad', 'user_country' => 'US', 'raw_srpvs' => '146', 'epoch' => '1606780800',},
];

use List::MoreUtils qw(uniq);
use List::Util qw(sum);
use Data::Dumper;

sub countries {
    uniq(map {$_->{user_country}} @$results);
}

sub filtered_results {
    my ($country, $category) = @_;
    grep {$_->{user_country} eq $country && $_->{type_tag} =~ /^$category/ } @$results;
}

sub sum_of {
    my ($field, $array) = @_;
    sum(map {$_->{$field}} @$array);
}

say Dumper countries();
say Dumper filtered_results('US', 'other');
say sum_of('estimated_revenue', $results);

