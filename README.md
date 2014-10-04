# Andy's modified zbase

This is a modified version of the zbase graphics pack for OpenTTD. This is
just a learning exercise for me in Blender and OpenTTD grfs, so it's 99.99% original
zbase and just a few tweaks to suit my own tastes.

![screenshot](https://raw.githubusercontent.com/gravitystorm/zbase/master/preview.png)

# zbase

The upstream zbase project is at http://dev.openttdcoop.org/projects/zbase/ and
at the time of writing hasn't seen any changes in almost 2 years.

# Building

To create the .grf files for use in OpenTTD, you'll need the
[zbasebuild](http://dev.openttdcoop.org/projects/zbasebuild/) project. It comes
with no documentation at all but here are some notes:

* `hg clone` zbasebuild alongside your zbase folder
* `hg clone` opengfx alongside both zbase and zbasebuild
* Install nmlc from [https://dev.openttdcoop.org/projects/nml](https://dev.openttdcoop.org/projects/nml).
I've had success with v0.3.1 on Ubuntu 12.04 - all dependencies are packaged there (`python-setuptools`, `python-pil`, `python-ply`).
* Edit zbasebuild/scripts/Makefile.def and edit the NML_VERSION and NML_REVISION variables (they don't work because ENOIDEA).

```diff
-NML_VERSION    := $(shell $(NML) --version | head -n1 | cut -b1,3,5)
-NML_REVISION   := $(shell $(NML) --version | head -n1 | cut -dr -f2 | cut -d: -f1 | cut -dM -f1)
+NML_VERSION    := 031
+NML_REVISION   := 5242
```
* cd zbasebuild and run `make` and wait for about an hour (nmlc gets stuck on some images because ENOIDEAEITHER)

# License

zbase is licensed under GPLv2, see [COPYING](COPYING)

# Thanks

Thanks to the zbase authors, principally Zephris


