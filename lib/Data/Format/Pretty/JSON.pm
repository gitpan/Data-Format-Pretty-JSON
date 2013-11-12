package Data::Format::Pretty::JSON;

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(format_pretty);

our $VERSION = '0.08'; # VERSION

sub content_type { "application/json" }

sub format_pretty {
    my ($data, $opts) = @_;
    $opts //= {};

    state $json;
    my $pretty = $opts->{pretty} // 1;
    my $linum  = $opts->{linum} // $ENV{LINUM} // $opts->{pretty};
    my $color  = $opts->{color} // $ENV{COLOR} // (-t STDOUT);
    if ($color) {
        require JSON::Color;
        JSON::Color::encode_json($data, {pretty=>$pretty, linum=>$linum})."\n";
    } else {
        if (!$json) {
            require JSON;
            $json = JSON->new->utf8->allow_nonref;
        }
        $json->pretty($pretty);
        if ($linum) {
            require SHARYANTO::String::Util;
            SHARYANTO::String::Util::linenum($json->encode($data));
        } else {
            $json->encode($data);
        }
    }
}

1;
# ABSTRACT: Pretty-print data structure as JSON

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Format::Pretty::JSON - Pretty-print data structure as JSON

=head1 VERSION

version 0.08

=head1 SYNOPSIS

 use Data::Format::Pretty::JSON qw(format_pretty);
 print format_pretty($data);

Some example output:

=over 4

=item * format_pretty({a=>1, b=>2})

  1:{
  2:    "a" : 1,
  3:    "b" : 2,
  4:}

By default color is turned on (unless forced off via C<COLOR> environment) as
well as pretty printing (unless turned off via pretty=>1) and line numbers
(unless when pretty=>0 or turned off by linum=>0).

=item * format_pretty({a=>1, b=>2}, {pretty=>0});

 {"a":1,"b":2}

=back

=head1 DESCRIPTION

This module uses L<JSON> to encode data as JSON.

=for Pod::Coverage new

=head1 FUNCTIONS

=head2 format_pretty($data, \%opts)

Return formatted data structure as JSON. Options:

=over 4

=item * color => BOOL

Whether to enable coloring. The default is the enable only when running
interactively. Currently also enable line numbering.

=item * pretty => BOOL (default: 1)

Whether to pretty-print JSON.

=item * linum => BOOL (default: 1 or 0 if pretty=0)

Whether to add line numbers.

=back

=head2 content_type() => STR

Return C<application/json>.


None are exported by default, but they are exportable.

=head1 ENVIRONMENT

=head2 COLOR => BOOL

Set C<color> option (if unset).

=head2 LINUM => BOOL

Set C<linum> option (if unset).

=head1 SEE ALSO

L<Data::Format::Pretty>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Format-Pretty-JSON>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Data-Format-Pretty-JSON>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Format-Pretty-JSON>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
