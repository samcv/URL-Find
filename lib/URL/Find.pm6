use v6;
=TITLE URL::Find
=SUBTITLE A Perl 6 module to find all the URL's in a set of text.
=head1 DESCRIPTION
=para
By default it will match domain names
that use unicode characters such as http://правительство.рф. To only match ASCII domains use the
:ascii option. It will also find URL's that end in one of the restricted characters, so
`https://www.google.com, ` will pull out `https://www.google.com`. It will find all the URL's in a
text by default, or you can specify a maximum number with the :limit option. Currently supported
schemes are http, https, ftp, git and ssh.

my token protocol   { [http|https|ftp|git|ssh]                      }
my token baseascii  { [ <[a..z A..Z 0..9 \- . ]> ]+                 }
my token base       { [ <:Number + :Letter + [ . - ]> ]+            }
my token protected  { <[ $ + ! * ( ) , . ; ? @ = % & # " ' ]>           }
my token allowed    { \S                                            }
my regex term       { <allowed>+ <!after <protected>>               }
my token after      { '/' <term>                                    }
my regex url        { <protocol> '://' <base> [<after>+]? '/'?      }
my regex urlascii   { <protocol> '://' <baseascii> [<after>+]? '/'? }
#| Accepts a string and returns a list of URL's. Optionally you can specify a limit to the number
#| of URL's returned, or whether you want to only match URL's with ASCII domain names. Matches
#| http https ftp git and ssh schemes.
sub find-urls ( Str $string, Num :$limit? is copy, :$ascii?) is export returns List  {
    $limit = ∞ if ! $limit.defined;
    if $ascii {
        return $string.comb(/<urlascii>/, $limit);
    }
    else {
        return $string.comb(/<url>/, $limit);
    }
}

=AUTHOR Samantha McVey (samcv) samantham@posteo.net
=LICENSE
This is free software; you can redistribute it and/or modify it under
the Artistic License 2.0.
