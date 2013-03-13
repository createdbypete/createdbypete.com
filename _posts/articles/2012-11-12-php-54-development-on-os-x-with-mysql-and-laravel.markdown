---
layout: post
title: PHP 5.4 development on OS X with MySQL and Laravel
categories: articles
grid: large
alias: /blog/2012/11/php-54-development-on-osx.html
---
For an industry that always craves the latest and greatest it baffles me why we always seems to be behind the times when it comes to versions of things. Having managed servers I certainly know why you follow the rule of "if it isn't broke don't upgrade it"; but when I still come across hosts offering PHP 5.2 when the lastest version of PHP at the time of writting is 5.4.9 it saddens me to think of what people are missing.

Incase your host can offer you PHP 5.4, here's how to install it on OSX, I'm running Mountain Lion but since this uses Homebrew I would think any previous versions that can also run Homebrew can follow along.

### The Essentials

#### Install Xcode

[Xcode](http://itunes.apple.com/gb/app/xcode/id497799835?mt=12) is available for free from the App Store, it provides many of necessary tools we’ll need later on. It’s a large download so be prepared to wait a little if you’ve not got a high-speed connection. Once it’s downloaded, launch Xcode to make sure it’s setup.

Now download and install the [Command Line tools for Xcode](https://developer.apple.com/downloads) to complete the package.

#### Install Homebrew

If you’ve not used [Homebrew](http://mxcl.github.com/homebrew/) before you’re going to love it. It is _The missing package manager for OS X_ and allows us to easily install the stuff we need that Apple doesn’t include. Installation is simple, open Terminal (Utilities » Terminal) and copy this command:

    ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

Now let’s check our environment is correctly configured:

    brew doctor

If there are any problems the doctor will give you details about the problem and sometimes even how to fix it. If not your probably not the only one so look it up in Google.
Now we want to update Homebrew to make sure we’re getting the latest formulas:

    brew update

#### Install PHP 5.4

With Homebrew "ready to brew" we want to run a quick search for PHP to see what's available in Homebrew land.

    brew search php54

This command should return a list of formulas that can be installed, you'll notice that they are all under a forumla respository `josegonzalez/php` so we need to tap that repository so Homebrew knows can use it.

    brew tap josegonzalez/php

You'll see some familiar git cloning feedback as Homebrew clones the repository but once it has been done run the `brew search php54` command again and you'll see all the formulas without that repository prefix. Before we install PHP though we need to tap another repository for some dependencies.

    brew tap homebrew/dupes
    brew install php54 --with-pgsql --with-mysql --with-tidy --with-intl

A number of other dependency libraries will be installed that PHP relies on when compiling itself so once everything has run through we can start playing with PHP 5.4!

### Using PHP 5.4 Development Server

Having enjoyed the ease of using the WEBrick server bundled with Rails this addition was particularly exciting. It allows you to spawn a development instance of website from the command line. No need to configure Apache and you get a live log output which during development is so useful!

    cd /path/to/php/project
    php -S localhost:4000

This will start the webserver with the current folder as the web root. You can also specify the directory using the `-t` flag like so:

    php -S localhost:4000 -t /path/to/web/root

You can find out more from the [PHP documentation](http://php.net/manual/features.commandline.webserver.php). You can also find out [what's changed in PHP 5.4](http://php.net/manual/migration54.changes.php) and how to migrate/test your older projects.
