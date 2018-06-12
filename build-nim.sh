#!/bin/bash

NIMVER="0.18.0"
wget -N https://nim-lang.org/download/nim-$NIMVER.tar.xz
wget -N https://nim-lang.org/download/nim-$NIMVER.tar.xz.sha256

sha256sum -c nim-$NIMVER.tar.xz.sha256

if [ ! $? = 0 ]; then
    echo "Failed to download nim source code"
fi

tar xf nim-$NIMVER.tar.xz
cd nim-$NIMVER

sh build.sh
bin/nim c koch
./koch tools
rm -r c_code/ nimcache/ doc/ dist/nimble/src/nimcache/ nimsuggest/nimcache/ tests/ build.sh

cd ..
mkdir -p public
tar cJf public/nim-$NIMVER-binary.tar.xz nim-$NIMVER/

git status
