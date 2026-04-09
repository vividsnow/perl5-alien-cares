use strict;
use warnings;
use Test::More;
use Test::Alien;

use_ok('Alien::cares');
alien_ok 'Alien::cares';

diag 'version:      ' . (Alien::cares->version // 'unknown');
diag 'install_type: ' . Alien::cares->install_type;
diag 'cflags:       ' . Alien::cares->cflags;
diag 'libs:         ' . Alien::cares->libs;

xs_ok { xs => <<'XS', verbose => 1 }, with_subtest {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <ares.h>

MODULE = TA_MODULE PACKAGE = TA_MODULE

const char *
version(...)
CODE:
    RETVAL = ares_version(NULL);
OUTPUT:
    RETVAL
XS
    my $mod = shift;
    my $ver = $mod->version();
    ok $ver, "ares_version returned: $ver";
};

done_testing;
