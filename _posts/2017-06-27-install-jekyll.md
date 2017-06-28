---
layout: post
date:   2017-06-27 14:21:29 +0100
title:  "I installed jekyll"
---

As per [docs](https://jekyllrb.com/docs/installation/):

    gem install jekyll bundler

# Dependencies

* `gcc`
* `make`
* `ruby-devel` / `ruby-dev`

RPM systems:

* `/usr/lib/rpm/redhat/redhat-hardened-cc1`

At least that's the failure I had, on Fedora 25.  `mkmf.log` showed the full path.  Pass this path to `dnf install`, then you can install jekyll successfully.  Or use `dnf provides` to see the necessary package - `redhat-rpm-config`.

# Why don't I install the Github Pages gem?

I like GitHub Pages for free and convenient hosting, but I'm *not* using the deployment instructions from jekyll docs.  I can just upload generated HTML to GitHub Pages, like any other static host.  The instructions advocate [pinning everything including ruby][pages-gem], to avoid compatibility issues.  I don't really want to build my own versions of ruby.

It's good they provide the version information.  However no-one's told me why you'd want this, other than for debugging after the fact.  I can easily avoid the two documented issues, by not running years-old versions of ruby.

[pages-gem]:    https://github.com/github/pages-gem

# Why don't I use Fedora packages?

Installing a packaged jekyll may not be the best idea.  Fedora packaged jekyll 3.2.1-3.fc25 without the default theme, "minima".  You would then run an initial `bundle install` to get minima.  Bundler ends up [installing newer versions of existing gems][rhbz-1464502] anyway.  (It doesn't upgrade jekyll; the reason being that `jekyll new` specifies its exact version in the Gemfile).

[rhbz-1464502]: https://bugzilla.redhat.com/show_bug.cgi?id=1464502

If your distribution did include all your gems (themes or plugins), presumably you can use jekyll without `bundle install`. In more recent versions of jekyll e.g. 3.5, you will have to use `jekyll new --skip-bundle`.  You'd then be using jekyll in a different way to its authors.  Package upgrades of the various gems will affect your site, and how it needs to be written.  You won't have a Gemfile.lock to record which versions worked correctly.

This issue is not so prominent in versions before 3.2, when gem-based themes were introduced.  E.g. using 3.1.6 in Debian Stretch, `jekyll new` copies the minima files into your site.  There is no minima gem, and no Gemfile is created.

The other option seems to be `bundle install --local`.  As well as system-installed gems, this also considers versions from your personal gem download _cache_.  The latter doesn't make sense to me, so I'm not able to recommend it.
