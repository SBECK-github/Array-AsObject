#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'as_hash';
}

BEGIN { $t->use_ok('Array::AsObject'); }

sub test {
  ($o,$full) = @_;
  $o = $obj{$o};

  if ($full) {

    @ret = ();
    ($count,$vals) = $o->as_hash(1);
    @k = sort { ref($$vals{$a}) cmp ref($$vals{$b})  ||
                $a cmp $b } keys %$count;
    foreach my $k (@k) {
       my $v = $$vals{$k};
       if (ref($v)) {
          push(@ret,ref($v) . "($k)",$$count{$k});
       } else {
          push(@ret,$v,$$count{$k});
       }
    }
    return @ret;

  } else {

    @ret = ();
    %h = $o->as_hash();
    @k = sort keys %h;
    foreach my $k (@k) {
      push(@ret,$k,$h{$k});
    }
    return @ret;

  }
}

%obj       = ();
$obj{'01'} = new Array::AsObject qw( a b c a b );

$i         = [ qw(a b) ];
$obj{'02'} = new Array::AsObject ('a', $i, $i, 'b', 'a');

$j         = [ qw(a b) ];
$obj{'03'} = new Array::AsObject ('a', $i, $j, 'b', 'a');


$tests = "

01 0 => a 2 b 2 c 1

01 1 => a 2 b 2 c 1

02 0 => a 2 b 1

02 1 => a 2 b 1 ARRAY(2) 2

03 0 => a 2 b 1

03 1 => a 2 b 1 ARRAY(2) 1 ARRAY(3) 1

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

