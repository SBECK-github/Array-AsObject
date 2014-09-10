######################################################################
# Build.PL for Array::AsObject
######################################################################

use strict;
use warnings;
use 5.006;
use Module::Build 0.21;

my %module_prereq = (
   'perl'                     => '5.006',
   'Sort::DataTypes'          => '0',
);

my %script_prereq = (
);

my %test_prereq = (
   'Storable'                 => '0',
   'Test::More'               => '0',
);

my %config_prereq = (
   'Module::Build'            => '0.21',
);

my %build_prereq = %config_prereq;
if ($Module::Build::VERSION < 0.4004) {
   %build_prereq = (%config_prereq,%test_prereq);
}

my $class = Module::Build->subclass(
   class  => "Module::Build::Custom",
   code   => q { sub ACTION_html { my $self = shift ; $self->SUPER::ACTION_html ( @_ ) if ( $ENV{ MAKE_HTML } ) ; } }
);

my $build = $class->new(
      module_name        => "Array::AsObject",
      dist_version       => "1.03",
      dist_abstract      => "full set of array and set operations",
      license            => "perl",
      dist_author        => "Sullivan Beck <sbeck\@cpan.org>",

      requires           => \%module_prereq,
      ($Module::Build::VERSION >= 0.4004
       ? (test_requires  => \%test_prereq)
       : ()),
      ($Module::Build::VERSION >= 0.30
       ? (configure_requires  => \%config_prereq)
       : ()),
      build_requires     => \%build_prereq,
      recommends         => \%script_prereq,
      sign               => 1,
      script_files       => [
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

$build->create_build_script;
