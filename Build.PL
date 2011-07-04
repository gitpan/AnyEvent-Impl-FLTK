use Module::Build;
Module::Build->new(
    dist_author        => 'Sanko Robinson <sanko@cpan.org>',
    module_name        => 'AnyEvent::Impl::FLTK',
    license            => 'artistic_2',
    configure_requires => {'Module::Build' => 0.38},
    requires           => {perl => 5.006001, AnyEvent => 0, FLTK => 0.532009},
    build_requires     => {
                       'Module::Build' => '0.36',
                       perl            => 5.006001,
                       'Test::More'    => '0.94'
    },
    add_to_cleanup       => [qw[AnyEvent-Impl-FLTK-*]],
    recursive_test_files => 1,
    meta_merge           => {
        keywords  => [qw[FLTK Fast Light Toolkit AnyEvent GUI]],
        resources => {
            bugtracker => 'http://github.com/sanko/anyevent-impl-fltk/issues',
            repository => 'http://github.com/sanko/anyevent-impl-fltk/',
            ChangeLog => 'http://github.com/sanko/anyevent-impl-fltk/commits',
            license   => 'http://www.perlfoundation.org/artistic_license_2_0'
        }
    }
)->create_build_script;

=pod

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

Neither this module nor the L<Author|/Author> is affiliated with Microsoft.

=cut
