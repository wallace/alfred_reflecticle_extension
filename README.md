### Alfred Reflecticle Extension, Objective C style.

This is a command line Objective C app is modeled after [the ruby version of the
same name](https://github.com/highgroove/alfred_reflecticle_extension).

For whatever reason, possibly due to how RVM and interacts with Reflecticle
shell extensions, I was not able to get the ruby version to work... so here we
are!

# Installation

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
