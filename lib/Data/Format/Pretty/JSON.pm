package Data::Format::Pretty::JSON;

use 5.010;
use strict;
use warnings;

use JSON;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(format_pretty);

my $json = JSON->new->utf8->allow_nonref;

our $VERSION = '0.01'; # VERSION

sub format_pretty {
    my ($data, $opts) = @_;
    $opts //= {};
    $json->pretty($opts->{pretty} // 1);
    $json->encode($data);
}

1;
# ABSTRACT: Pretty-print data structure as JSON


=pod

=head1 NAME

Data::Format::Pretty::JSON - Pretty-print data structure as JSON

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 use Data::Format::Pretty::JSON qw(format_pretty);
 print format_pretty($data);

Some example output:

=over 4

=item * format_pretty({a=>1, b=>2})

  {
      "a" : 1,
      "b" : 1,
  }

=item * format_pretty({a=>1, b=>2}, {pretty=>0});

 {"a":1,"b":2}

=head1 DESCRIPTION

This module uses L<JSON> to encode data as JSON.

=for Pod::Coverage new

=head1 FUNCTIONS

=head2 format_pretty($data, \%opts)

Return formatted data structure as JSON. Options:

=over 4

=item * pretty => BOOL (default 1)

Whether to pretty-print JSON.

=back

=head1 SEE ALSO

L<Data::Format::Pretty>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


