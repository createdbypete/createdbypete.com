---
layout: post
title: Ruby on Rails development with Mac OS X Mountain Lion
categories: [articles]
grid: [large]
alias: /blog/2012/08/ruby-on-rails-development-with-mac-osx-mountain-lion.html
---

Most developers like to spend a bit of time setting up their environment. Being new to the Ruby on Rails world I’ve spent a bit of time experimenting with different setups to find the ideal one for me. The criteria was simple:

1. Unobtrusive, no modifying core files
2. Flexibility with Ruby versions and gem versions per project
3. Minimal configuration development server
4. Easy to setup new/exisiting projects

So if you’re a Rails developer with the same ideals this should help you get started quickly.

This article assumes a clean install of Mac OS X Mountain Lion, Mac OS X Lion could also be setup in the same way.

<!-- more -->

### The Essentials

#### Install Xcode

[Xcode](http://itunes.apple.com/gb/app/xcode/id497799835?mt=12) is available for free from the App Store, it provides many of necessary tools we’ll need later on. It’s a large download so be prepared to wait a little if you’ve not got a high-speed connection. Once it’s downloaded, launch Xcode to make sure it’s setup.

Now download and install the [Command Line tools for Xcode](https://developer.apple.com/downloads) to complete the package.

#### Install Homebrew

If you’ve not used [Homebrew](http://mxcl.github.com/homebrew/) before you’re going to love it. It is _The missing package manager for OS X_ and allows us to easily install the stuff we need that Apple doesn’t include. Installation is simple, open Terminal (Utilities » Terminal) and copy this command:

{% highlight console %}
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
{% endhighlight %}

Now let’s check our environment is correctly configured:

{% highlight console %}
brew doctor
{% endhighlight %}

If there are any problems the doctor will give you details about the problem and sometimes even how to fix it. If not your probably not the only one so look it up in Google.
Now we want to update Homebrew to make sure we’re getting the latest formulas:

    brew update

#### Install Ruby

OS X comes with Ruby installed but it’s an older version, as we don’t want to be messing with core files we’re going to use [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build) to manage and install our Ruby development environments.

Lets get _brewing_! We can install both using Homebrew, once done we add a line to our ````~/.bash_profile```` and exit. By exiting we logout of the terminal session so close the terminal window and open a new one; this will reload the profile.

    brew install rbenv
    brew install ruby-build
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    exit

Now you’ll understand why we use ````rbenv````. It allows us to install different versions of Ruby and specify which version to use on a per project basis. This is very useful to keep a consistent development environment if you need to work in a particular Ruby version.

We’re going to install the latest stable of Ruby (at the time of writing) you can find this out by visiting the [Ruby website](http://www.ruby-lang.org/en/downloads/).

    rbenv install 1.9.3-p194
    rbenv rehash

**Note:** You need to run the ````rbenv rehash```` after you install a new version of Ruby.

Let’s set this version as the one to use globally so we can make use of it in our terminal.

    rbenv global 1.9.3-p194

You can checkout more commands in the [rbenv readme on Github](https://github.com/sstephenson/rbenv#section_3). It’s worth bookmarking that page for reference later.

#### Install Bundler

Bundler manages an application’s dependencies through its entire life across many machines systematically and repeatably. This is a good thing.

We use the following command to ensure we have the correct version of Ruby loaded in our terminal window, it overrides both project-specific and global version so we know we’re working with the right one.

    rbenv shell 1.9.3-p194
    gem install bundler
    rbenv rehash

Notice ````rbenv rehash```` has been used again, you need to do this whenever you install a new gem that provides binaries.

Now we need to configure Bundler to install your gems in a location relative to your project, in this case the vendor folder of a Rails project:

    mkdir ~/.bundle
    touch ~/.bundle/config
    echo 'BUNDLE_PATH: vendor/bundle' >> ~/.bundle/config

If you’ve installed other versions of Ruby you can use the same commands just change the Ruby version you want to work with.

#### Install SQLite3

SQLite is lightweight SQL service and handy to have installed since Rails defaults to using it with new projects. Installing [MySQL](http://www.mysql.com/) or [PostgreSQL](http://www.postgresql.org/) is discussed further down as they are based on your preference/project requirements.

Installation is simple: (are you loving Homebrew yet!?)

    brew install sqlite3

#### Install Rails

With Ruby installed and ready to go [Rails](http://rubyonrails.org/) can be installed as a [Ruby Gem](http://rubygems.org/). If you’re just starting out developing in Ruby gems will become very familiar.

    rbenv shell 1.9.3-p194
    gem install rails
    rbenv rehash

Rails has a number of dependencies to install so don’t be surprised if you see loads of other gems being installed at the same time.

#### Install Pow and Powify

If you’ve played with Rails already you’ll be familiar with the WEBrick server launched with ````rails server````. [Pow](http://pow.cx/) is a zero-config Rack server for Mac OS X. What this means to us is a slightly easier development environment as every app we add to pow will be available at ````http://project-name.dev````. You can read more about [why we’re installing Pow](http://pow.cx/manual.html).

    curl get.pow.cx | sh

That’s Pow installed, now we’re going to install a new gem that makes working with Pow even easier. It’s called [Powify](https://github.com/sethvargo/powify) and it allows you to easily install, update, and manage pow and pow applications seamlessly.

    rbenv shell 1.9.3-p194
    gem install powify
    rbenv rehash

We’ll go through a few of the most common commands in a moment but check out the readme on Github for a [full guide to using Powify](https://github.com/sethvargo/powify#usage).

#### Your first Rails project

Ready to put all this to good use and start your first project? Good, we’re going to create a new project called ````myapp````.

    cd ~/Desktop
    rails new myapp
    cd myapp

Now we’re going to set the local Ruby version for this project to make sure this stays constant, even if we change the global version later on. This command will write the version to ````.rbenv-version```` in your project directory.

    rbenv local 1.9.3-p194

Now run Bundler to install all the project gems into vendor/bundle so they are kept with the project locally and won’t interfere with anything else outside.

    bundle install

If your gems ever stop working you can just delete the vendor/bundle directory and run the command again to reinstall them again.

Now let’s add our new project to Pow, we’ll use Powify for this. Make sure you’re inside the myapp directory before running this command.

    powify create myapp

You can now access your app at [http://myapp.dev](http://myapp.dev) or use Powify to open it for you.

    powify browse myapp

#### The Options Pack

Below are some extras you may wish to install to complete your development environment. Again [Homebrew](http://mxcl.github.com/homebrew/) to the rescue to make installation a breeze, so open your terminal and let’s get brewing!

**Note:** It’s recommend you run ````brew update```` before installing anything new to make sure all the formulas are up to date.

#### Install MySQL

One of the most commonly used SQL services many projects end up using MySQL as a datasource. Homebrew does have formulas for alternatives such as [MariaDB](http://mariadb.org/) if you prefer.

    brew install mysql

This will download and compile MySQL for you and anything else MySQL requires to work. Once finished it will give you instructions to follow regarding setting up MySQL. You can see this information anytime by using the **info** action: ````brew info <package>````.

#### Install PostgreSQL

OS X Lion and Mountain Lion already come with [PostgreSQL](http://www.postgresql.org/) installed however as with Ruby it is an older version (again).
We want the latest so using Homebrew install PostgreSQL.

    brew install postgresql

Follow the post installation steps provided by Homebrew and we’re almost ready to go. Because PostgreSQL already exists on OS X we need to update our ````$PATH```` so that it will read the Homebrew version first. So we need to add this to ````~/.bash_profile````.

    echo "export PATH=/usr/local/bin:$PATH" >> ~/.bash_profile

This will put the Homebrew binary path in front so after reloading the terminal by typing exit you can issue this command to check the path to PostgreSQL.

    which psql
    # Output:
    /usr/local/bin/psql

#### Install Redis

All the cool kids are using [Redis](http://redis.io/) these days and for good reason. Redis is an open source, advanced key-value store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets and sorted sets.

Redis is used by projects such as [Resque](https://github.com/defunkt/resque) for storage.

    brew install redis

#### Skip rdoc generation

If you use Google for finding your Gem documentation you might consider generating the documentation when you install gems bit of a waste.

To prevent this add this line to ````~/.gemrc````.

    gem: --no-rdoc --no-ri
