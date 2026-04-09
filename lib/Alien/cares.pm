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

Alien::cares - Find or build c-ares async DNS resolver library

=head1 SYNOPSIS

    use Alien::cares;
    use ExtUtils::MakeMaker;

    WriteMakefile(
        ...
        CONFIGURE_REQUIRES => { 'Alien::cares' => 0 },
        CCFLAGS => Alien::cares->cflags,
        LIBS    => Alien::cares->libs,
    );

=head1 DESCRIPTION

This module provides the c-ares C library for asynchronous DNS resolution.
It will use the system library if available (>= 1.22.0), or download and
build from source if necessary.

=head1 METHODS

All methods are inherited from L<Alien::Base>.

On macOS with a share install, C<libs> and C<libs_static> append
C<-Wl,-rpath> so the dynamic linker can find the shared library.

=head1 SEE ALSO

L<Alien::Base>, L<https://c-ares.org/>

=head1 LICENSE

Same terms as Perl 5.

=cut
