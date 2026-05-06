package Alien::cares;
use strict;
use warnings;
use parent 'Alien::Base';

our $VERSION = '0.02';

1;

__END__

=head1 NAME

Alien::cares - find or build the c-ares asynchronous DNS resolver library

=head1 SYNOPSIS

In an XS distribution's F<Makefile.PL>, using L<Alien::Base::Wrapper>:

    use ExtUtils::MakeMaker;
    use Alien::Base::Wrapper qw( Alien::cares !export );

    WriteMakefile(
        Alien::Base::Wrapper->mm_args,
        NAME               => 'My::Module',
        CONFIGURE_REQUIRES => {
            'Alien::Base::Wrapper' => 0,
            'Alien::cares'         => 0,
        },
        PREREQ_PM => { 'Alien::cares' => 0 },
    );

Or, accessing the flags directly:

    use Alien::cares;
    INC  => Alien::cares->cflags,
    LIBS => [ Alien::cares->libs ],

In another distribution's F<alienfile>:

    use alienfile;
    share { requires 'Alien::cares' };

=head1 DESCRIPTION

Alien::cares finds or builds the L<c-ares|https://c-ares.org/> C library,
which provides asynchronous DNS resolution.  The dual install strategy
follows the L<Alien::Base> convention:

=over 4

=item *

A system-installed c-ares E<gt>= 1.22.0 detected via C<pkg-config> is
used directly (I<system> install).

=item *

Otherwise the latest release tarball is downloaded from GitHub and built
with CMake as a static library bundled with this distribution
(I<share> install).

=back

Set the C<ALIEN_INSTALL_TYPE> environment variable to C<system> or
C<share> to force a particular install type.

=head1 METHODS

This module inherits all methods from L<Alien::Base>.  The most useful
ones are C<cflags>, C<libs>, C<libs_static>, C<version>, and
C<install_type>.

=head1 SEE ALSO

=over 4

=item *

L<Alien::Base> - the framework this module is built on

=item *

L<Alien::Build::Manual::AlienUser> - guide to consuming an Alien

=item *

L<EV::cares> - libev-based Perl bindings to c-ares

=item *

L<https://c-ares.org/> - upstream project

=back

=head1 AUTHOR

vividsnow

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2026 by vividsnow.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
