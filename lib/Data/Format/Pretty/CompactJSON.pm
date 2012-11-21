package Data::Format::Pretty::CompactJSON;

use 5.010;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(format_pretty);

our $VERSION = '0.06'; # VERSION

sub content_type { "application/json" }

sub format_pretty {
    my ($data, $opts) = @_;
    state $json;

    $opts //= {};

    if ($opts->{color} // $ENV{COLOR} // (-t STDOUT)) {
        require JSON::Color;
        JSON::Color::encode_json($data, {pretty=>0, linum=>0});
    } else {
        if (!$json) {
            require JSON;
            $json = JSON->new->utf8->allow_nonref;
        }
        $json->encode($data);
    }
}

1;
# ABSTRACT: Pretty-print data structure as compact JSON


=pod

=head1 NAME

Data::Format::Pretty::CompactJSON - Pretty-print data structure as compact JSON

=head1 VERSION

version 0.06

=head1 SYNOPSIS

 use Data::Format::Pretty::CompactJSON qw(format_pretty);
 print format_pretty($data);

Some example output:

=over 4

=item * format_pretty({a=>1, b=>2});

 {"a":1,"b":2}

=back

=head1 DESCRIPTION

Like L<Data::Format::Pretty::JSON>, but will always print with JSON option C<<
pretty => 0 >> (minimal indentation).

=head1 FUNCTIONS

=head2 format_pretty($data, \%opts)

Return formatted data structure as JSON. Options:

=over 4

=item * color => BOOL

Whether to enable coloring. The default is the enable only when running
interactively.

=back

=head2 content_type() => STR

Return C<application/json>.

=head1 ENVIRONMENT

=head2 COLOR => BOOL

Set C<color> option (if unset).

=head1 SEE ALSO

L<Data::Format::Pretty::JSON>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


