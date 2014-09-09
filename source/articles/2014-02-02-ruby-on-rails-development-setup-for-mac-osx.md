---
layout: post
title: Ruby on Rails development setup for Mac OSX
categories: articles
date: 2014-02-02 19:13
updated: 2014-08-13 08:15
alias:
  - articles/ruby-on-rails-development-with-mac-os-x-mountain-lion/index.html
  - articles/ruby-on-rails-development-with-mac/index.html
---

Most developers like to spend a bit of time setting up their development workspace. I'm no different, after a number of years tweaking and experimenting the following article details how I setup my environment for Mavericks.

There has always been a consistent critera my development environment needed to meet:

1. Unobtrusive, no modifying core files
2. Flexibility with Ruby versions
3. Minimal configuration
4. Easy to setup new/existing projects

So if you're a Ruby developer with the same ideals this should help you get started quickly.

This article assumes a clean install of Mac OS X Mavericks but I've added notes for Mountain Lion and those stuck on Lion should also be able to follow along.

## The Essentials

### Install Command Line Tools

Installion of Command Line Tools for Mavericks has changed from the previous versions, there is now a single command you can run in the terminal to trigger the install.

    xcode-select --install

You should see a pop-up window appear asking you to install, after clicking install just sit back and wait for it to finish.

**Mountain Lion:** If you're on Mountain Lion (or Lion) you will need to [download Command Line Tools](https://developer.apple.com/downloads) from Apple. The Apple Developer site requires you to sign in to access the downloads page but once you're in search for the Command Line Tools for your version, download and install.

### What about Xcode?

You can install [Xcode](http://itunes.apple.com/gb/app/xcode/id497799835?mt=12) from the App Store but it's not essential. I find the FileMerge application comes in very useful but it's a large download just for that so be prepared to wait a little if you've not got a high-speed connection. Once it's downloaded, launch Xcode to make sure it's setup.

### Install Homebrew

If you've not used [Homebrew](http://brew.sh/) before you're going to love it. The self proclaimed _missing package manager for OS X_ allows us to easily install the stuff we need that Apple doesn't include. Installation is simple, open Terminal (Applications » Utilities » Terminal) and copy this command:

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Add Homebrews binary path to the front of the $PATH
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
```

Now check our environment is correctly configured for Homebrew.

    brew doctor

If there are any problems the `brew doctor` will give you details about the it and sometimes even how to fix it. If not your probably not the only one so look it up in Google.
Now we want to update Homebrew to make sure we're getting the latest formulas:

    brew update

### Install Ruby

OS X comes with Ruby installed (Mavericks even gets version 2.0.0, previously it was only 1.8.7), as we don't want to be messing with core files we're going to use the brilliant [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build) to manage and install our Ruby versions for our development environment.

Lets get _brewing_! We can install both of the required packages using Homebrew, once done we add a line to our `~/.bash_profile` and reload our terminal profile.

```bash
brew install rbenv ruby-build rbenv-gem-rehash
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
```

Now close terminal and open it again, this ensure everything has been reloaded in your shell.

The package we just installed allow us to install different versions of Ruby and specify which version to use on a per project basis and globally. This is very useful to keep a consistent development environment if you need to work in a particular Ruby version.

We're going to install the latest stable of Ruby (at the time of writing) you can find this out by visiting the [Ruby website](https://www.ruby-lang.org/en/downloads/). Or to see a list of all available versions to install `rbenv install --list`.

    rbenv install 2.1.2
    rbenv rehash

Let’s set this version as the one to use globally so we can make use of it in our terminal.

    rbenv global 2.1.2

You can checkout more commands in the [rbenv readme on Github](https://github.com/sstephenson/rbenv#command-reference). It's worth bookmarking that page for reference later, or there is always `rbenv --help`.

### Install Bundler

Bundler manages an application's dependencies, kind of like a shopping list of other libraries the application needs to work. If you're just starting out with Ruby on Rails you will soon see just how important and helpful this gem is.

    gem install bundler

We can also make use of the [rbenv-default-gems](https://github.com/sstephenson/rbenv-default-gems) plugin to install bundler automatically for us whenever we install a new version of Ruby. I had some trouble with this working on the first version of Ruby you install but any others seemed to go ok.

```bash
brew install rbenv-default-gems
echo "bundler\n" >> ~/.rbenv/default-gems
```

#### Skip rdoc generation

If you use Google for finding your Gem documentation like I do you might consider saving a bit of time when installing gems by skipping the documentation.

```bash
echo "gem: --no-document\n" >> ~/.gemrc
```

That's all, as you'll see from `rbenv install --list` there are loads of Ruby versions available including [JRuby](http://jruby.org/). You will need to re-install any gems for each version as they are not shared.

## Install Ruby on Rails

So far you've installed Ruby, if you're not going to be working with Rails you can pat yourself on the back and start working with Ruby! If you intend to work with Rails then you've just got a couple more things to do.

### Install SQLite3

SQLite is lightweight SQL service and handy to have installed since Rails defaults to using it with new projects. You may find OS X already provides an (older) version of SQLite3, but in the interests of being thorough we'll install it anyway as Homebrew will set it to 'keg-only' and not interfere with the system version if that is the case.

Installation is simple with Homebrew: (_are you loving Homebrew yet!?_)

    brew install sqlite3

### Install Rails

With Ruby installed and the minimum dependencies ready to go [Rails](http://rubyonrails.org/) can be installed as a [Ruby Gem](http://rubygems.org/).

    gem install rails

If you would like Rails to be a default gem in the future when you install a new version of Ruby you can add it to the `default-gems` file.

```bash
echo "rails\n" >> "~/.rbenv/default-gems"
```

Rails has quite a number of other gem dependencies so don't be surprised if you see loads of other gems being installed at the same time.

## Your first Rails project

Ready to put all this to good use and start your first project? Good, we're going to create a new project called `helloworld`.

    rails new helloworld
    cd helloworld

Now we're going to set the local Ruby version for this project to make sure this stays constant, even if we change the global version later on. This command will write automatically to `.ruby-version` in your project directory. This file will automatically change the Ruby version within this folder and warn you if you don't have it installed.

    rbenv local 2.1.2

**Note:** If your gems start causing problems you can just run `gem pristine --all` to restore them to pristine condition.

Now let's test our application is working:

    rails server

## The Options Pack

Below are some extras you may wish to install. Again [Homebrew](http://brew.sh/) to the rescue to make installation a breeze, so open your terminal and get brewing!

**Note:** It's recommended you run `brew update` before installing anything new to make sure all the formulas are up to date.

### Install MySQL

One of the most commonly used SQL services, many projects end up using MySQL as a datasource. Homebrew does have formulas for alternatives such as [MariaDB](http://mariadb.org/) if you prefer.

    brew install mysql
    brew services start mysql

This will download and compile MySQL for you and anything else MySQL requires to work. Once finished the second command will `start` the MySQL service and also start it everytime you login. You can see more commands with `brew services`.

To start a new Rails app with MySQL instead of the default SQLite3 as the datastore just use the `-d` flag like so:

    rails new helloworld -d mysql

You can find more information about the other options available with `rails --help`.

### Install PostgreSQL

OS X already comes with [PostgreSQL](http://www.postgresql.org/) installed however as with Ruby it is an older version (again).
We want the latest so using Homebrew install PostgreSQL.

    brew install postgresql
    brew services start postgresql

To start a new Rails app with PostgreSQL instead of the default SQLite3 as the datastore just use the `-d` flag like so:

    rails new helloworld -d postgresql

You can find more information about the other options available with `rails --help`.

### Install Redis

All the cool kids are using [Redis](http://redis.io/) these days and for good reason. Redis is an open source, advanced key-value store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets and sorted sets.

Redis is required by projects such as [Resque](https://github.com/defunkt/resque) for super fast storage.

    brew install redis
    brew services start redis

The above is usually fine but when you have a few projects on the go all using Redis you'll want to have a project specific config for it so you can set a different port for example. Thankfully this is no problem, first take a copy of the default config.

    cd /my/rails/project
    cp /usr/local/etc/redis.conf ./config/redis.conf

With that done I usually commit the default into Git so it's always there as a reference before I make any customisations. To launch a new Redis process using this config we need to call `redis-server`.

    redis-server /my/rails/project/config/redis.conf

To connect to this custom Redis process instead of the default we need to use `redis-cli` with some extra flags:

```bash
redis-cli --help
  Usage: redis-cli [OPTIONS] [cmd [arg [arg ...]]]
    -h <hostname>    Server hostname (default: 127.0.0.1)
    -p <port>        Server port (default: 6379)
    -s <socket>      Server socket (overrides hostname and port)
    ...
```

### Upgrade Git

As with most of the packages on OS X the version of Git is a few versions behind. We can correct this however with a little help from Homebrew, and because we added the Homebrew binary location to the front of our `$PATH` the Homebrew version will be picked up first.

    brew install git

### What about the kitchen sink?

That's all you need for most Ruby on Rails applications. It has been serving me pretty well and meets all the requirements I outlined at the beginning of the article.

An alternative to `rbenv` is [rvm](https://rvm.io/) the idea behind them both is the same but I find working with `rbenv` more comfortable but that maybe because I haven't spent much time with `rvm`.

If you're just starting out don't worry there's a lot to take in, start off with this setup and you'll find your sweet spot as you get more experienced.

## Further reading for Ruby on Rails
If you're looking for some further reading to improve your knowledge of Rails and Ruby here are a couple of places to take a look (in no particular order):

* [Rails Guides](http://guides.rubyonrails.org/), you can't beat the documentation!
* [Rails API](http://api.rubyonrails.org/), always handy to have this bookmarked.
* [RailsCasts.com](http://railscasts.com/), superb website operated by the talented [@ryanbates](https://twitter.com/rbates) loads of screencasts on a range of topics in the Rails world. Worth the $9 a month subscription for the Pro episodes.
* [Try Ruby](http://tryruby.org/), operated by [Code School](http://www.codeschool.com/) this is focused on Ruby but if you're new to Ruby it's definitely worth a look.
* [Rails for Zombies](http://railsforzombies.org/), another from the guys at [Code School](http://www.codeschool.com/) this time focused on Rails and a good way to get your head into working _the Rails way_.
* [Agile Web Development with Rails](http://pragprog.com/book/rails4/agile-web-development-with-rails), available in various formats this is another great book to guide you through working with Rails.
