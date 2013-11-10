---
layout: post
grid: large
title: Ruby on Rails development with Mac OS X Mountain Lion
image: old_train_by_devils666.jpg
categories: articles
tags: [guide,ruby]
date: 2012-08-27 16:00
updated: 2013-11-10 22:30
alias: /blog/2012/08/ruby-on-rails-development-with-mac-osx-mountain-lion.html
---
<div class="alert">
  <strong>Using OS X Mavericks?</strong> I will be updating this article very soon.
</div>

Most developers like to spend a bit of time setting up their workspace. I've been experimenting Ruby on Rails for some time now and this is still my preferred setup. My core criteria is simple:

1. Unobtrusive, no modifying core files
2. Flexibility with Ruby versions and gem versions per project
3. Minimal configuration
4. Easy to setup new/existing projects

So if you're a Rails developer with the same ideals this should help you get started quickly.

This article assumes a clean install of Mac OS X Mountain Lion, Mac OS X Lion could also be setup in the same way.

## The Essentials

### Install Xcode and Command Line Tools

[Xcode](http://itunes.apple.com/gb/app/xcode/id497799835?mt=12) is available for free from the App Store, you don't actually need it but I find the FileMerge application it comes bundled with very useful. It's a large download so be prepared to wait a little if you've not got a high-speed connection. Once it's downloaded, launch Xcode to make sure it's setup.

Now download and install the [Command Line Tools for Xcode](https://developer.apple.com/downloads) to complete the package; you need this whether you installed Xcode or not.

### Install Homebrew

If you've not used [Homebrew](http://mxcl.github.com/homebrew/) before you're going to love it. The self proclaimed _missing package manager for OS X_ allows us to easily install the stuff we need that Apple doesn't include. Installation is simple, open Terminal (Applications » Utilities » Terminal) and copy this command:

```bash
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# Add Homebrews binary path to the front of the $PATH
echo "export PATH=/usr/local/bin:$PATH" >> ~/.bash_profile
source ~/.bash_profile
```

Now check our environment is correctly configured:

```bash
brew doctor
```

If there are any problems the doctor will give you details about the problem and sometimes even how to fix it. If not your probably not the only one so look it up in Google.
Now we want to update Homebrew to make sure we're getting the latest formulas:

```bash
brew update
```

### Install Ruby

OS X comes with Ruby installed but it's an older version (1.8.7 at time of writing), as we don't want to be messing with core files we're going to use the brilliant [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build) to manage and install our Ruby development environments.

Lets get _brewing_! We can install both using Homebrew, once done we add a line to our ```~/.bash_profile``` and reload our terminal profile.

```bash
brew install rbenv ruby-build
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
```

Now you'll understand why we use `rbenv` and ```ruby-build```. It allows us to install different versions of Ruby and specify which version to use on a per project basis. This is very useful to keep a consistent development environment if you need to work in a particular Ruby version.

We're going to install the latest stable of Ruby (at the time of writing) you can find this out by visiting the [Ruby website](http://www.ruby-lang.org/en/downloads/). Or to see a list of all available versions to install ```rbenv install --list```.

```bash
rbenv install 2.0.0-p247
rbenv rehash
```

**Note:** You need to run the ```rbenv rehash``` after you install a new version of Ruby.

Let’s set this version as the one to use globally so we can make use of it in our terminal.

```bash
rbenv global 2.0.0-p247
```

You can checkout more commands in the [rbenv readme on Github](https://github.com/sstephenson/rbenv#command-reference). It's worth bookmarking that page for reference later, or there is always ```rbenv --help```.

### Install Bundler

Bundler manages an application's dependencies, kind of like a shopping list of other libraries the application needs to work. If you're just starting out with Ruby on Rails you will see just how important and helpful this gem is.

You can use the ```rbenv shell``` command to ensure we have the correct version of Ruby loaded in our terminal window, it overrides both project-specific and global version, if you're paranoid you can always check your Ruby version with ```ruby --version```.

```bash
rbenv shell 2.0.0-p247
gem install bundler
rbenv rehash
```

Notice ```rbenv rehash``` has been used again, you need to do this whenever you install a new gem that provides binaries. So if you've installed a gem and the terminal tells you it can't find it run ```rbenv rehash```.

I like to configure Bundler to install gems in a location relative to my projects instead of globally; in this case the vendor folder of a Rails project:

```bash
mkdir ~/.bundle
touch ~/.bundle/config
echo 'BUNDLE_PATH: vendor/bundle' >> ~/.bundle/config
```

#### Skip rdoc generation

If you use Google for finding your Gem documentation like I do you might consider saving a bit of time when installing gems by skipping the documentation.

```bash
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
```

That's all, as you'll see from ```rbenv install --list``` there are loads of Ruby versions available including [JRuby](http://jruby.org/) just remember you will need to re-install your gems for each version as they are not shared.

### Install SQLite3

SQLite is lightweight SQL service and handy to have installed since Rails defaults to using it with new projects. You may find OS X already provides an (older) version of SQLite3, but in the interests of being thorough we'll install it anyway as Homebrew will set it to 'keg-only' and no interfere with the system version if that is the case.

Installation is simple with Homebrew: (_are you loving Homebrew yet!?_)

```bash
brew install sqlite3
```

### Install Rails

With Ruby installed and the minimum dependencies ready to go [Rails](http://rubyonrails.org/) can be installed as a [Ruby Gem](http://rubygems.org/).

```bash
gem install rails
rbenv rehash
```

Rails has a number of dependencies to install so don't be surprised if you see loads of other gems being installed at the same time.

## Your first Rails project

Ready to put all this to good use and start your first project? Good, we're going to create a new project called ```helloworld```.

```bash
rails new helloworld
cd helloworld
```

Now we're going to set the local Ruby version for this project to make sure this stays constant, even if we change the global version later on. This command will write automatically to ```.ruby-version``` in your project directory. This file will automatically change the Ruby version within this folder and warn you if you don't have it installed.

```bash
rbenv local 2.0.0-p247
```

Now run Bundler to install all the project gems into ```vendor/bundle```, they are kept with the project locally and won't interfere with anything else outside.

```bash
bundle install

# It's also worth updating your .gitignore file so you don't commit all of those gems!
echo '/vendor/bundle' >> .gitignore
```

If your gems ever stop working you can just delete the ```vendor/bundle``` directory and run the command again to re-install them.

Now let's test our application is working:

```bash
rails s
```
<!-- TODO: add screenshot of result? -->

## The Options Pack

Below are some extras you may wish to install. Again [Homebrew](http://mxcl.github.com/homebrew/) to the rescue to make installation a breeze, so open your terminal and get brewing!

**Note:** It's recommend you run ```brew update``` before installing anything new to make sure all the formulas are up to date.

### Install MySQL

One of the most commonly used SQL services, many projects end up using MySQL as a datasource. Homebrew does have formulas for alternatives such as [MariaDB](http://mariadb.org/) if you prefer.

```bash
brew install mysql
```

This will download and compile MySQL for you and anything else MySQL requires to work. Once finished it will give you instructions to follow regarding setting up MySQL. You can see this information any time by using the ```info``` action: ```brew info [package name]```.

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

To start a new Rails app with MySQL instead of the default SQLite3 as the datastore just use the ```-d``` flag like so:

```bash
rails new helloworld -d mysql
```
You can find more information about the other options available with ```rails --help```.

### Install PostgreSQL

OS X Lion and Mountain Lion already come with [PostgreSQL](http://www.postgresql.org/) installed however as with Ruby it is an older version (again).
We want the latest so using Homebrew install PostgreSQL.

```bash
brew install postgresql
initdb /usr/local/var/postgres -E utf8

# Add PostgreSQL to launchctl to let OS X manage the process and start when you login
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

Postgres has a slightly longer command as we need to pass in the locations so I've taken to creating an ```alias``` to shrink all this down to simply ```pg```.

```bash
echo "alias pg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'" >> ~/.bash_profile
source ~/.bash_profile
pg start
# Usage: pg {start|stop|restart|reload|status}
```
To start a new Rails app with PostgreSQL instead of the default SQLite3 as the datastore just use the ```-d``` flag like so:

```bash
rails new helloworld -d postgresql
```
You can find more information about the other options available with ```rails --help```.

### Install Redis

All the cool kids are using [Redis](http://redis.io/) these days and for good reason. Redis is an open source, advanced key-value store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets and sorted sets.

Redis is used by projects such as [Resque](https://github.com/defunkt/resque) for super fast storage.

```bash
brew install redis

# Add Redis to launchctl to let OS X manage the process and start when you login, this will use the default config from /usr/local/etc/redis.conf
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```
The above is usually fine but when you have a few projects on the go all using Redis you'll want to have a project specific config for it so you can set a different port for example. Thankfully this is no problem, first take a copy of the default config.

```bash
cd /my/rails/project
cp /usr/local/etc/redis.conf ./config/redis.conf
```
With that done I usually commit the default into Git so it's always there as a reference before I make any customisations. To launch a new Redis process using this config we need to call ```redis-server```.

```bash
redis-server /my/rails/project/config/redis.conf
```
To connect to this custom Redis process instead of the default we need to use ```redis-cli``` with some extra flags:

```bash
Usage: redis-cli
  -h <hostname>    Server hostname (default: 127.0.0.1)
  -p <port>        Server port (default: 6379)
  -s <socket>      Server socket (overrides hostname and port)
```

### Upgrade Git
As with most of the packages on OS X the version of Git is a few versions behind. We can correct this however with a little help from Homebrew, and because we added the Homebrew binary location to the front of our ```$PATH``` the Homebrew version will be picked up first.

```bash
brew install git
```

<!-- TODO: Pow install -->

### What about the kitchen sink?
That's all you need for most Ruby on Rails applications. It has been serving me pretty well and meets all the requirements I outlined at the beginning of the article.

An alternative to ```rbenv``` is [rvm](https://rvm.io/) the idea behind them both is the same but I find working with ```rbenv``` more comfortable but that maybe because I haven't spent much time with ```rvm```.

If you're just starting out don't worry there's a lot to take in, start off with this setup and you'll find your sweet spot as you get more experienced.

## Further reading for Ruby on Rails
If you're looking for some further reading to improve your knowledge of Rails and Ruby here are a couple of places to take a look (in no particular order):

* [Rails Guides](http://guides.rubyonrails.org/), you can't beat the documentation!
* [Rails API](http://api.rubyonrails.org/), always handy to have this bookmarked.
* [RailsCasts.com](http://railscasts.com/), superb website operated by the talented [@ryanbates](https://twitter.com/rbates) loads of screencasts on a range of topics in the Rails world. Worth the $9 a month subscription for the Pro episodes.
* [Try Ruby](http://tryruby.org/), operated by [Code School](http://www.codeschool.com/) this is focused on Ruby but if you're new to Ruby it's definitely worth a look.
* [Rails for Zombies](http://railsforzombies.org/), another from the guys at [Code School](http://www.codeschool.com/) this time focused on Rails and a good way to get your head into working _the Rails way_.
* [Agile Web Development with Rails](http://pragprog.com/book/rails32/agile-web-development-with-rails-3-2), available in various formats this is another great book to guide you through working with Rails. The link is for the Rails 3.2 version but with [Rails 4 on the horizon you might want this one instead](http://pragprog.com/book/rails4/agile-web-development-with-rails).
