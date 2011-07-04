use AnyEvent;
use AnyEvent::Util;
use lib '../../lib';
use AnyEvent::Impl::FLTK;
use Test::More;
$|++;

#
my ($a, $b) = AnyEvent::Util::portable_socketpair;
ok $a && $b, "sockpair: $a, $b";
my ($cv, $t, $ra, $wa, $rb, $wb);
$rb = AnyEvent->io(
    fh   => $b,
    poll => "r",
    cb   => sub {
        pass 'read callback on $b';
        is sysread($b, my $buf, 1), 1, 'read a byte';
        $wb = AnyEvent->io(
            fh   => $b,
            poll => "w",
            cb   => sub {
                pass 'write callback on $b';
                undef $wb;
                syswrite $b, "1";
            }
        );
    }
);
{
    my $cv = AnyEvent->condvar;
    $t = AnyEvent->timer(after => 0.05,
                         cb    => sub { $cv->send; pass 'escape' });
    $cv->wait
}
$wa = AnyEvent->io(
    fh   => $a,
    poll => "w",
    cb   => sub {
        syswrite $a, "0";
        undef $wa;
        pass 'write callback on $a';
    }
);
$ra = AnyEvent->io(
    fh   => fileno $a,
    poll => "r",
    cb   => sub {
        sysread $a, my $buf, 1;
        pass 'read callback on $a';
        $cv->send;
    }
);
$cv = AnyEvent->condvar;
$cv->wait;
is $AnyEvent::MODEL, 'AnyEvent::Impl::FLTK', 'Working with FLTK';
done_testing();
