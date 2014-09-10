######################################################################
# Makefile.PL for Array::AsObject
######################################################################

use strict;
use warnings;
use 5.006;
use ExtUtils::MakeMaker 6.30;

my %module_prereq = (
   'Sort::DataTypes'          => '0',
);

my %script_prereq = (
);

my %test_prereq = (
   'Storable'                 => '0',
   'Test::More'               => '0',
);

my %config_prereq = (
   'ExtUtils::MakeMaker'      => '6.30',
);

%module_prereq = (%module_prereq,%script_prereq);
my $EU_MM_V    = $ExtUtils::MakeMaker::VERSION;
$EU_MM_V       =~ s/_//g;
if ($EU_MM_V < 6.64) {
   %config_prereq = (%config_prereq,%test_prereq);
}

WriteMakefile(
   NAME             => "Array::AsObject",
   VERSION          => "1.03",
   ABSTRACT         => "full set of array and set operations",
   LICENSE          => "perl",
   ($EU_MM_V >= 6.48
    ? (MIN_PERL_VERSION => "5.006")
    : ()),
   AUTHOR           => "Sullivan Beck (sbeck\@cpan.org)",
   "dist"           => {COMPRESS=>"gzip",SUFFIX=>"gz"},
   PL_FILES         => {},
   PREREQ_PM        => \%module_prereq,
   ($EU_MM_V >= 6.52
    ? (CONFIGURE_REQUIRES => \%config_prereq)
    : ()),
   ($EU_MM_V >= 6.64
    ? (TEST_REQUIRES   => \%test_prereq)
    : ()),
   EXE_FILES        => [
                        '.git/hooks/pre-commit.sample',
                        '.git/hooks/post-update.sample',
                        '.git/hooks/pre-applypatch.sample',
                        '.git/hooks/applypatch-msg.sample',
                        '.git/hooks/update.sample',
                        '.git/hooks/pre-rebase.sample',
                        '.git/hooks/pre-push.sample',
                        '.git/hooks/commit-msg.sample',
                        '.git/hooks/prepare-commit-msg.sample',
                       ],
);
