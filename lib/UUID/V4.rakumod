unit module UUID::V4:ver<1.0.0>:auth<masukomi (masukomi@masukomi.org)>;;


=begin pod

=head1 NAME

UUID::V4 - generates a random v4 UUID (Universally Unique IDentifier)

=head2 SYNOPSIS

=begin code :lang<raku>

use UUID::V4;

# generate a uuid
my $uuid = uuid-v4(); # 62353163-3235-4165-b337-316436626539

# validate a string against uuid-v4 regexp
my $confirmation = is-uuid-v4($uuid); # True

=end code

=head2 DESCRIPTION

UUID::V4 generates a random v4 UUID (Universally Unique IDentifier).
See L<the RFC 4122 specification|https://www.ietf.org/rfc/rfc4122.txt> for details.

=head2 AUTHOR

masukomi (a.k.a Kay Rhodes) based on Nobuyoshi Nakada's work in Ruby.

=head2 COPYRIGHT AND LICENSE

Copyright 2022 

This library is free software; you can redistribute it and/or modify it under the MIT license.

=head2 WHY

Unfortunately L<LibUUID|https://github.com/CurtTilmes/perl6-libuuid> requires the C<uuid> dynamic library
which didn't exist on my mac. This library uses L<Crypt::Random|https://github.com/skinkade/crypt-random>
which doesn't suffer from that problem and should work on all Unix / Linux systems and Windows.




=end pod

use Crypt::Random;
use experimental :pack;

#| Generate a UUID in V4 format.
our sub uuid-v4() returns Str is export  {
	my Buf $buf = crypt_random_buf(16);
	my @unpacked = $buf.list.fmt("%x", "").encode.unpack("NnnnnN");
	@unpacked[2] = ( @unpacked[2] +& 0x0fff ) +| 0x4000;
	@unpacked[3] = ( @unpacked[3] +& 0x3fff ) +| 0x8000;
	"%08x-%04x-%04x-%04x-%04x%08x".sprintf(@unpacked);
}

#| Test if a string matches the UUID v4 format.
our sub is-uuid-v4(Str $maybe_uuid) returns Bool is export {
	 my $regexp = /^ <[0..9 a..f A..F]> ** 8 "-"
					 [ <[0..9 a..f A..F]> ** 4 "-" ] ** 2
					 <[8 9 a b A B]><[0..9 a..f A..F]> ** 3 "-"
					 <[0..9 a..f A..F]> ** 12 $/;
	$maybe_uuid ~~ $regexp ?? True !! False;
}
