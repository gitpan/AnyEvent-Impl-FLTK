use AnyEvent;
use AnyEvent::Util;
use lib '../../lib';
use AnyEvent::Impl::FLTK;
use Test::More;
$|++;

#
my $cv = AnyEvent->condvar;
ok $cv, 'init with condvar';
my $timer1 = AnyEvent->timer(
    after => 0.1,
    cb    => sub {
        pass 'timer triggered';
        $cv->broadcast;
    }
);
ok $timer1 , 'added $timer1';
AnyEvent->timer(after => 0.01,
                cb    => sub { fail 'this timer should auto-destruct' });
$cv->wait;
is $AnyEvent::MODEL, 'AnyEvent::Impl::FLTK', 'Working with FLTK';
done_testing;
