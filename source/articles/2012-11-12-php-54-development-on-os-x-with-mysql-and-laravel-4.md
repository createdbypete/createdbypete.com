---
layout: post
title: PHP 5.4 development on OS X with MySQL and Laravel 4
categories: articles
date: 2012-11-12 11:23
updated: 2014-02-01 20:48
alias: blog/2012/11/php-54-development-on-osx.html
---

As a developer I'm always exited by the latest releases, in contrast for any servers I setup I want solid, stable, time tested releases that are going to work flawlessly. I certainly know why you follow the rule of "if it isn't broken don't upgrade it", but when I still hear of hosts offering PHP 5.2 when the latest stable version of PHP at the time of writing is 5.5 it saddens me to think of what people are missing.

Most hosts should be able to offer you at least 5.3 by now (if not find someone else right now!). In case your host can offer you PHP 5.4, or you want to start using the new awesomeness here's how to install it on OS X. I'm running Mavericks but since most of this guide uses Homebrew I have included a few notes for differences installing on Mountain Lion and I would think any previous versions that can also run Homebrew can follow along.

## The Essentials

### Install Command Line Tools

Installion of Command Line Tools for Mavericks has changed from the previous versions, there is now a single command you can run in the terminal to trigger the install.

    xcode-select --install

You should see a pop-up window appear asking you to install, after clicking install just sit back and wait for it to finish.

**Mountain Lion:** If you're on Mountain Lion (or Lion) you will need to [download Command Line Tools](https://developer.apple.com/downloads) from Apple. The Apple Developer site requires you to sign in to access the downloads page but once you're in search for the Command Line Tools for your version, download and install.

### What about Xcode?

You can install [Xcode](http://itunes.apple.com/gb/app/xcode/id497799835?mt=12) from the App Store but you don't actually need it. I find the FileMerge application comes in very useful but it's a large download just for that so be prepared to wait a little if you've not got a high-speed connection. Once it's downloaded, launch Xcode to make sure it's setup.

### Install Homebrew

If you’ve not used [Homebrew](http://brew.sh/) before you're going to love it over the next few steps as it makes the whole process so much easier! Installation is a simple "one liner".

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Check every is configured properly
brew doctor
```

If there are any problems the ```brew doctor``` will give you details about the problem and sometimes even how to fix it. Homebrew formulas are updated all the time so make sure we're getting the latest formulas before we start.

```bash
brew update
```

### Install MySQL using Homebrew

MySQL and PHP go hand in hand just about everywhere these days you just can't keep them apart. Homebrew also has formulas for alternatives such as [MariaDB](https://mariadb.org) and [Percona Server](http://www.percona.com/software/percona-server).

```bash
brew install mysql
```
Now you just sit back and let Homebrew do its magic and not only install MySQL but also any dependencies. Once it's finished it will display some post installation instructions; I'm going to go through the steps here but please double check you're not following out of date steps.

```bash
# Add MySQL to launchctl to let OS X manage the process and start when you login
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# Or if you want to control it yourself
mysql.server start
# Usage: mysql.server {start|stop|restart|reload|force-reload|status}

# "Secure" your MySQL installation, really it's just a handy way to clean up defaults and set a root password
mysql_secure_installation
```
And you're done setting up MySQL for now. If you're looking for a good client application for MySQL [Sequel Pro](http://www.sequelpro.com/) is the best in my eyes, if you love it please donate as the team have done a fantastic job.

### Install PHP 5.4 and Composer

With Homebrew already brewing we want to run a quick search for PHP to see what's available in Homebrew's formula repository. This is a useful command to remember.

```bash
brew search php54
```
This command should return a list of formulas that can be installed, you'll notice that they are all under a formula repository `josegonzalez/php` so we need to tap that repository so Homebrew knows can use it.

```bash
brew tap josegonzalez/php
```

You'll see some familiar git cloning feedback as Homebrew clones the repository but once it has been done run the `brew search php54` command again and you'll see all the formulas without that repository prefix now. Before we install PHP though we need to tap another repository for some dependencies. I'm also going to install the [Xdebug](http://xdebug.org/) module for PHP at the same time as it's a useful development aid.

```bash
brew tap homebrew/dupes
brew install php54 php54-xdebug
```

A number of other dependency libraries will be installed that PHP relies on when compiling itself, once complete we should install [Composer](http://getcomposer.org/) the _Dependency Manager for PHP_. Laravel 4 uses this to install it's dependencies and is slowly trying to cement itself as the standard for PHP, much like [Bundler](http://gembundler.com/) is for Ruby Gems.

```bash
brew install composer
composer --version # Check we have access to it
```

## Laravel 4
With more PHP frameworks than it's worth making joke about, [Laravel](http://laravel.com) by [Taylor Otwell](https://github.com/taylorotwell) and [team](https://github.com/laravel?tab=members) looks to me like a step in the right direction.

> It's like a dirty weekend away from Rails

What I really like with the Laravel, is the adoption of the latest PHP syntax features, Composer to manage the packages, completely unit tested and has a really clean way to work with multiple environments. I'll stop stalling and get it setup so we can play! First install the PHP Mcrypt module that Laravel requires.

```bash
brew install php54-mcrypt
```

Using Composer we can follow Laravel's one liner [quickstart](http://laravel.com/docs/quick#installation). Obviously change `your-project-name` for something more meaningful.

```bash
cd /where/projects/are/kept
composer create-project laravel/laravel your-project-name --prefer-dist
```

### Using the PHP 5.4 built-in webserver

With Laravel now ready to go, let's fire up the [PHP built-in webserver](http://php.net/manual/features.commandline.webserver.php). Having enjoyed the ease of using the `rails server` command in Rails this addition was particularly exciting. It allows you to spawn a development webserver from the command line. No need to configure Apache and you get a live (and colourful) log output which during development is incredibly useful!

Laravel 4 comes with a routing script so we can still work with pretty URLs (usually you would need to have index.php in the URL which is not a big deal in development).

```bash
# While inside the projects directory
php -S localhost:4000 server.php

# Open the URL in your default browser
open http://localhost:4000
```

In your browser you should see the customary "Hello World!" message confirming everything is working.

You'll notice I've used `localhost:4000` above you can use any hostname/IP or port number with a few limitations:

* The port number must be above 1024, any lower and you will need to use `sudo` as these are reserved for system use.
* The hostname/IP must resolve to your machine. You can use `0.0.0.0` as a wild card to match any IP your machine can answer to. This is if another machine needs access to the application.

There are a number of other options you can use with the command line webserver. I've also used different hostname/IP combinations.

```bash
# Starting webserver in the current directory
php -S my-machine-name.local:4000

# Starting with a specific document root directory
php -S 0.0.0.0:4000 -t /path/to/web/root
php -S myproject.dev:5000 -t ./path/can/be/relative/too

# Using a router script (this is method we used with Laravel)
php -S localhost:8000 my-router-script.php
```
You can find out more details from the [PHP documentation](http://php.net/manual/features.commandline.webserver.php). You can also find out [what's changed in PHP 5.4](http://php.net/manual/migration54.changes.php) and how to migrate/test your older projects if you are upgrading.
