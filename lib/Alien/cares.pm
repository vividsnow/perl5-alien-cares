package Alien::cares;
use strict;
use warnings;
use parent 'Alien::Base';

our $VERSION = '0.01';

sub _add_rpath {
    my ($self, $libs) = @_;
    if ($^O eq 'darwin' && $self->install_type eq 'share' && $libs =~ /-L(\S+)/) {
        return "-Wl,-rpath,$1 $libs";
    }
    return $libs;
}

sub libs        { $_[0]->_add_rpath($_[0]->SUPER::libs) }
sub libs_static { $_[0]->_add_rpath($_[0]->SUPER::libs_static) }

1;

__END__

=head1 NAME

Alien::cares - Find or build the c-ares async DNS resolver library

=head1 SYNOPSIS

In your F<Makefile.PL>:

    use Alien::cares;
    use ExtUtils::MakeMaker;

    WriteMakefile(
        ...
        CONFIGURE_REQUIRES => { 'Alien::cares' => 0 },
        INC  => Alien::cares->cflags,
        LIBS => [Alien::cares->libs],
    );

In your F<alienfile> (if wrapping for another Alien):

    use alienfile;
    share { requires 'Alien::cares' };

=head1 DESCRIPTION

Alien::cares finds or builds the L<c-ares|https://c-ares.org/> C library
for asynchronous DNS resolution.

=over 4

=item *

If a system-installed c-ares E<gt>= 1.22.0 is detected via C<pkg-config>,
it is used directly.

=item *

Otherwise the latest release is downloaded from GitHub and built with
CMake as a static library.

=back

=head1 METHODS

Inherited from L<Alien::Base>.  On macOS share installs, C<libs> and
C<libs_static> inject C<-Wl,-rpath> for the dynamic linker.

=head1 SEE ALSO

L<Alien::Base>, L<EV::cares>, L<https://c-ares.org/>

=head1 AUTHOR

vividsnow

=head1 LICENSE

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
