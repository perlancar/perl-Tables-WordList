package Tables::WordList;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
use Role::Tiny::With;
with 'TablesRole::Source::Iterator';

sub new {
    require Module::Load::Util;

    my ($class, %args) = @_;
    defined $args{wordlist} or die "Please specify 'wordlist' argument";
    $class->_new(
        gen_iterator => sub {
            my $wl = Module::Load::Util::instantiate_class_with_optional_args(
                {ns_prefix=>'WordList'}, $args{wordlist});
            sub {
                my $w = $wl->next_word;
                return undef unless defined $w;
                {word=>$w};
            },
        },
    );
}

1;
# ABSTRACT: Table from a WordList module

=head1 SYNOPSIS

From perl code:

 use Tables::WordList;

 my $table = Tables::WordList->new(wordlist => 'ID::BIP39');

From command-line (using L<tables> CLI):

 % tables show WordList=wordlist,ID::BIP39


=head1 METHODS

=head2 new

Arguments:

=over

=item * wordlist

=back


=head1 SEE ALSO

L<WordList>

L<Tables>
