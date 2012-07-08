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

It is complicated for the moment.  Download the project, build it, archive it,
and grab the executable out of the archive and drop that in /usr/local/bin.

Then, update the Alfred Reflecticle extension to use 

    /usr/local/bin/alfred\_reflecticle\_extension {query}

as the command.

![screenshot of how it should look in alfred](https://img.skitch.com/20120708-xegs2q2869iqnks1seip4hy4ut.png "how it should look in alfred")

I'd love to automate the install but that's beyond my Xcode knowledge at this
time.  Please contact me/issue a pull request if you can help in this area.

### Usage

    ./alfred_refleticle_extension <project name> <message>

### TODO

 0. Add tests
 1. Implement error handling
 2. Implement growl notifications to show you the most recent reflecticle updates.
 3. Automate the installation of the command line utility

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
