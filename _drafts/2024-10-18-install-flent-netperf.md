---
layout: post
date:   2024-08-18
title:  "Installing netperf (and flent)"
---

[netperf][netperf] is in the non-free section

[netperf][netperf] fails to build with current compilers, due to "multiple definition" errors.

A [fix][netperf-fix] has been posted, but there is nobody left to accept it.

[netperf]: https://hewlettpackard.github.io/netperf/
[netperf-fix]: https://github.com/HewlettPackard/netperf/pull/46

This error can be disabled by compiling with `-fcommon`.  It may also be necessary to use `-Wno-error=implicit-function-declaration`.  (If there are still errors, maybe try adding `-fpermissive` as well).  For example:

```
$ sudo apt install autoconf texinfo
```

```
$ git clone https://github.com/HewlettPackard/netperf.git
$ cd netperf
$ ./autogen.sh
$ ./configure --enable-demo CFLAGS="-fcommon -Wno-error=implicit-function-declaration"
```

```
$ make
$ sudo make install
```

## Installing flent ##

The workaround above allowed me to install [flent](https://flent.org/) on Ubuntu 22.04 and Debian 12.  `flent` requires `netperf` (built with `--enable-demo`).  You can install the `flent` package using `apt`.

`flent` also suggests you install the `fping` package.

For UDP tests, `flent` suggests you install the `irtt` package.  Debian/Ubuntu will start the `irtt` network service automatically, so you should only install it if you need it.

