#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'at';
}

BEGIN { $t->use_ok('Array::AsObject'); }

sub test {
  (@test) = @_;
  @ret    = ();
  $val    = $obj->at(@test);
  $err    = $obj->err();
  push(@ret,$err,$val);
  @val    = $obj->at(@test);
  $err    = $obj->err();
  push(@ret,$err,@val);
  return @ret;
}

$obj = new Array::AsObject;
$obj->list(qw(a b c));

$tests = "

a      => 1 __undef__ 1 __undef__

4      => 1 __undef__ 1 __undef__

-4     => 1 __undef__ 1 __undef__

1      => 0 b 0 b

-2     => 0 b 0 b

1 2    => 1 __undef__ 0 b c

-1 -2  => 1 __undef__ 0 c b

";

$t->tests(func  => \&test,
          tests => $tests);
$t->done_testing();

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 3
# cperl-continued-statement-offset: 2
# cperl-continued-brace-offset: 0
# cperl-brace-offset: 0
# cperl-brace-imaginary-offset: 0
# cperl-label-offset: 0
# End:

