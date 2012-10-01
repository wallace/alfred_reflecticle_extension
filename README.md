### Alfred Reflecticle Extension, Objective C style.

This command line Objective C app is modeled after [the ruby version of the same
name](https://github.com/highgroove/alfred_reflecticle_extension).  It lets you
post updates to [Reflecticle](http://reflecticle.com) from the command line.

For whatever reason, possibly due to how RVM and interacts with Reflecticle
shell extensions, I was not able to get the ruby version to work... so here we
are!

# Installation

Setup your API Key:

    $ echo 'API_KEY' > ~/.reflecticle

Download the [latest
binary](https://github.com/wallace/alfred_reflecticle_extension/downloads). The
ZIP file will contain one file: the executable `alfred_reflecticle_extension`.

Move the executable to a place in your `$PATH`; for instance, `/usr/local/bin`
or `~/bin` (if you have setup the latter to be in your `$PATH`).

Then, add a "Shell Script" extension with the command:

    /usr/local/bin/alfred_reflecticle_extension "{query}"

as the command.

![screenshot of how it should look in alfred](https://img.skitch.com/20120806-nebdbeedg771d34wfksdjh2sg1.jpg "how it should look in alfred")

Finally, adjust the advanced options so that only "Double Quotes" are escaped:

![advanced options](http://img.skitch.com/20120806-tc49fnd5efa34sj12eaidqcs11.jpg "advanced options")

An automated installer would be really nice: if you have knowledge about how to
make this work, please submit a pull request.

### Usage

    ./alfred_refleticle_extension "<project name> <message>"

### TODO

 0. Add tests
 1. Implement error handling
 2. Automate the installation of the command line utility

###  License

 Copyright (c) 2012 Jonathan R. Wallace

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
