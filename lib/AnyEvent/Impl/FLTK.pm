package AnyEvent::Impl::FLTK;
{
    use AnyEvent qw[];
    use FLTK qw[];
    push @AnyEvent::REGISTRY, [FLTK:: => AnyEvent::Impl::FLTK::, 1];
    our $VERSION = '0.0.1';

    sub io {
        my (undef, %arg) = @_;
        my $poll = $arg{poll} eq 'r' ? FLTK::READ() : FLTK::WRITE();
        bless \\FLTK::add_fd(($arg{fh}), $poll, $arg{cb}),
            'AnyEvent::Impl::FLTK::io';
    }

    sub AnyEvent::Impl::FLTK::io::DESTROY {
        my $io = shift;
        FLTK::remove_fd $$$io;
    }

    sub timer {
        my (undef, %arg) = @_;
        my $after = $arg{after} < 0 ? 0 : $arg{after};
        my $cb = $arg{cb};
        my $timer;
        if ($arg{interval}) {
            my $rcb = sub {
                $timer = FLTK::add_timeout($arg{interval}, $cb);
                &$cb;
            };
            $timer = FLTK::add_timeout($after, $rcb);
        }
        else {
            $timer = FLTK::add_timeout($after, $cb);
        }
        bless \\$timer, 'AnyEvent::Impl::FLTK::timeout';
    }

    sub AnyEvent::Impl::FLTK::timeout::DESTROY {
        my $timer = shift;
        FLTK::remove_timeout $$$timer;
    }

    sub idle {
        my (undef, %arg) = @_;
        my $cb   = $arg{cb};
        my $idle = FLTK::add_idle($cb);
        bless \\$idle, 'AnyEvent::Impl::FLTK::idle';
    }

    sub AnyEvent::Impl::FLTK::idle::DESTROY {
        my $idle = shift;
        FLTK::remove_idle $$$idle;
    }
    sub one_event { FLTK::wait(0) }
    sub loop      { FLTK::run() }
}
1;

=pod

=head1 NAME

AnyEvent::Impl::FLTK - AnyEvent adaptor for the Fast Light ToolKit

=head1 SYNOPSIS

   use AnyEvent;
   use FLTK;
   use AnyEvent::Impl::FLTK;

=head1 DESCRIPTION

This module provides transparent support for AnyEvent. You must load this
module yourself to make FLTK work with AnyEvent.

=head1 SEE ALSO

=over

=item L<AnyEvent>

=item L<FLTK>

=back

=head1 Author

Sanko Robinson <sanko@cpan.org> - http://sankorobinson.com/

CPAN ID: SANKO

=head1 License and Legal

Copyright (C) 2011 by Sanko Robinson <sanko@cpan.org>

This program is free software; you can redistribute it and/or modify it under
the terms of
L<The Artistic License 2.0|http://www.perlfoundation.org/artistic_license_2_0>.
See the F<LICENSE> file included with this distribution or
L<notes on the Artistic License 2.0|http://www.perlfoundation.org/artistic_2_0_notes>
for clarification.

When separated from the distribution, all original POD documentation is
covered by the
L<Creative Commons Attribution-Share Alike 3.0 License|http://creativecommons.org/licenses/by-sa/3.0/us/legalcode>.
See the
L<clarification of the CCA-SA3.0|http://creativecommons.org/licenses/by-sa/3.0/us/>.

=cut
