use strict;
use warnings;
use ExtUtils::MakeMaker;
use Alien::Build::MM;

my $abmm = Alien::Build::MM->new;

WriteMakefile($abmm->mm_args(
    NAME             => 'Alien::cares',
    DISTNAME         => 'Alien-cares',
    VERSION_FROM     => 'lib/Alien/cares.pm',
    ABSTRACT         => 'Find or build c-ares async DNS library',
    AUTHOR           => 'vividsnow',
    LICENSE          => 'perl_5',
    MIN_PERL_VERSION => '5.014',

    CONFIGURE_REQUIRES => {
        'Alien::Build::MM'                        => '2.37',
        'Alien::Build::Plugin::Build::CMake'      => 0,
        'Alien::Build::Plugin::Download::GitHub'  => 0,
    },
    BUILD_REQUIRES => {
        'Alien::Build::MM' => '2.37',
    },
    PREREQ_PM => {
        'Alien::Base' => '2.37',
    },
    TEST_REQUIRES => {
        'Test::More'  => 0,
        'Test::Alien' => 0,
    },

    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/vividsnow/perl5-alien-cares.git',
                web  => 'https://github.com/vividsnow/perl5-alien-cares',
            },
        },
    },
));

sub MY::postamble {
    $abmm->mm_postamble;
}
