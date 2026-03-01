#!/bin/sh

set -o errexit
set -o nounset

dirty_files="$(git status --porcelain)"
if [ -n "$dirty_files" ]; then
    echo "You must commit all changes to git, before building."
    exit 1
fi
unset dirty_files

if [ ! -e _build/.git ]; then
    git worktree add _build/ build
fi
touch _build/.nojekyll

bundle exec jekyll build -d _build/

commit="$(git rev-parse --short HEAD)"
(
    cd _build/
    echo $PWD
    git add .
    git commit -m "jekyll build of commit $commit"
)
