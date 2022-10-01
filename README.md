NAME
====

UUID::V4 - generates a random v4 UUID (Universally Unique IDentifier)

SYNOPSIS
--------

```raku
use UUID::V4;

# generate a uuid
my $uuid = uuid-v4(); # 62353163-3235-4165-b337-316436626539

# validate a string against uuid-v4 regexp
my $confirmation = is-uuid-v4($uuid); # True
```

DESCRIPTION
-----------

UUID::V4 generates a random v4 UUID (Universally Unique IDentifier). See [the RFC 4122 specification](https://www.ietf.org/rfc/rfc4122.txt) for details.

AUTHOR
------

masukomi (a.k.a Kay Rhodes) based on Nobuyoshi Nakada's work in Ruby.

COPYRIGHT AND LICENSE
---------------------

Copyright 2022 

This library is free software; you can redistribute it and/or modify it under the MIT license.

WHY
---

Unfortunately [LibUUID](https://github.com/CurtTilmes/perl6-libuuid) requires the `uuid` dynamic library which didn't exist on my mac. This library uses [Crypt::Random](https://github.com/skinkade/crypt-random) which doesn't suffer from that problem and should work on all Unix / Linux systems and Windows.

### sub uuid-v4

```raku
sub uuid-v4() returns Str
```

Generate a UUID in V4 format.

### sub is-uuid-v4

```raku
sub is-uuid-v4(
    Str $maybe_uuid
) returns Bool
```

Test if a string matches the UUID v4 format.

