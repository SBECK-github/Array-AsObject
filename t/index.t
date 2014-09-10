#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'index/rindex';
}

BEGIN { $t->use_ok('Array::AsObject'); }

sub test {
  ($o,$val) = @_;
  $o = $obj{$o};

  @ret = ();
  @idx = $o->index($val);
  $idx = $o->index($val);
  push(@ret,@idx,'--',$idx,'--');
  @idx = $o->rindex($val);
  $idx = $o->rindex($val);
  push(@ret,@idx,'--',$idx);
  return @ret;
}

%obj       = ();
$obj{'01'} = new Array::AsObject qw( a b c a b );

$i         = [ qw(a b) ];
$obj{'02'} = new Array::AsObject ('a', $i, $i, 'b', undef, 'a');

$j         = [ qw(a b) ];
$obj{'03'} = new Array::AsObject ('a', $i, $j, undef, 'b', undef, 'a');

$tests = "

01       => -- -1 -- -- -1

01 a     => 0 3 -- 0 -- 3 0 -- 3

01 z     => -- -1 -- -- -1

02       => 4 -- 4 -- 4 -- 4

02 a     => 0 5 -- 0 -- 5 0 -- 5

02 z     => -- -1 -- -- -1

03       => 3 5 -- 3 -- 5 3 -- 5

";

$t->tests(func     => \&test,
          tests    => $tests);

$t->tests(func     => \&test,
          tests    => [ [ '02', $i ] ],
          expected => "1 2 -- 1 -- 2 1 -- 2");
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

