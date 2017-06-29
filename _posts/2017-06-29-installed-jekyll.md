---
layout: post
date:   2017-06-27 18:31:00 +0100
title:  "How I installed Jekyll"
---

As per the [docs][install-docs]

    gem install jekyll bundler

[install-docs]: https://jekyllrb.com/docs/installation/


# Dependencies #

* `gcc`
* `make`
* `ruby-devel` / `ruby-dev`

Additionally, on systems that use RPM:

* `/usr/lib/rpm/redhat/redhat-hardened-cc1`

At least that's what I was missing, on Fedora 25.  `mkmf.log` showed the full path.  Pass this path to `dnf install`, then you can install jekyll successfully.  Or use `dnf provides` to see the necessary package, `redhat-rpm-config`.


# Why don't I install the Github Pages gem? #

I like GitHub Pages for free and convenient hosting, but I'm *not* using the deployment instructions from jekyll docs.  I can just upload generated HTML to GitHub Pages, like any other static host.

The Jekyll docs page confuses me.  The instructions advocate [matching versions of everything including ruby][pages-gem], to avoid compatibility issues.  I like that Github provide their version information.  However if breaking changes are a concern, why would you upgrade gems on someone else's schedule?  It seems mainly useful to debug a breaking change on Github - some time after you notice a failure - which was caused by Github not implementing `Gemfile.lock`.

It's also useful for people who want to edit on Github.  This is unrelated to the reason given in the Jekyll documentation, which doesn't mention editing on Github at all.

On top of this, it's not immediately clear how this gem matches versions of _ruby_.  What implications does that have?  I can avoid the two issues they documented easily, by not running years-old versions of ruby.

[pages-gem]:    https://github.com/github/pages-gem


# Why don't I use Fedora packages? #

Installing a packaged jekyll may not be the best idea.  Fedora packaged jekyll 3.2.1-3.fc25 without the default theme, "minima".  You would then run an initial `bundle install` to get minima.  Bundler ends up [installing newer versions of existing gems][rhbz-1464502] anyway.  (It doesn't upgrade jekyll; the reason being that `jekyll new` specifies its exact version in the Gemfile).

[rhbz-1464502]: https://bugzilla.redhat.com/show_bug.cgi?id=1464502

If your distribution did include all your gems (themes or plugins), presumably you can use jekyll without `bundle install`. In more recent versions of jekyll e.g. 3.5, you will have to use `jekyll new --skip-bundle`.  You'd then be using jekyll in a different way to its authors.  Package upgrades of the various gems will affect your site, and how it needs to be written.  You won't have a Gemfile.lock to record which versions worked correctly.

This issue is not so prominent in versions before 3.2, when gem-based themes were introduced.  E.g. using 3.1.6 in Debian Stretch, `jekyll new` copied the minima files into the new site.  There was no minima gem, and no Gemfile was created.

Another option I saw suggested was `bundle install --local`.  As well as system-installed gems, this also considers versions from your personal gem download _cache_.  The latter doesn't make sense to me, so I'm not able to recommend this.
