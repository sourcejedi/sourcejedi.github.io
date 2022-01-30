# Current usage

## "Github pages"

This git repo is pushed to:

https://github.com/sourcejedi/sourcejedi.github.io/

"Github pages" build it using their version of jekyll, and serve it at https://sourcejedi.github.io


## Local testing

Install the jekyll package e.g. `dnf install rubjgem-jekyll` on Fedora Workstation.

`jekyll serve --source ~/sysnote/blog-maybe`


## FIXME

I think the above do not use Gemfile or Gemfile.lock?

Running the `jekyll` command inside this directory fails.

That's fine right now. I haven't touched this recently, and wasn't keen to rely on whatever old code files I had here.

```
<internal:/usr/share/rubygems/rubygems/core_ext/kernel_require.rb>:85:in `require': cannot load such file -- bundler (LoadError)
	from <internal:/usr/share/rubygems/rubygems/core_ext/kernel_require.rb>:85:in `require'
	from /usr/share/gems/gems/jekyll-4.2.1/lib/jekyll/plugin_manager.rb:50:in `require_from_bundler'
	from /usr/share/gems/gems/jekyll-4.2.1/exe/jekyll:11:in `<top (required)>'
	from /usr/bin/jekyll:23:in `load'
	from /usr/bin/jekyll:23:in `<main>'
```

I expect it's because I deleted `~/.gems`.  I did so because it appeared to be causing conflicts when I used the system version of jekyll (previous section).
