---
layout: post
title: Getting Started with Rails 4
categories: articles
tags: [guide,ruby]
updated: 2013-08-16 13:44
---
With a new major version of Rails -on the horizon- now released it makes sense to start taking a look and what's going on. I'm going to show you how to install the Rails 4 gem so you can start playing with the latest version.

## Setup your development environment
If you are new to Rails then you will might want to check out my other post about [setting up a Ruby on Rails development environment on OS X](http://createdbypete.com/articles/ruby-on-rails-development-with-mac-os-x-mountain-lion/) as the following steps will assume a similar setup.

## Installing Rails 4
Rails 4 is now the latest stable release so it's much easier to get going with it.

```bash
gem install rails --no-ri --no-rdoc
rbenv rehash # if you're using rbenv
```

Once the gem installer has done it's thing you can now check the Rails version with `rails -v` and start a new project in the usual way.

```bash
rails new myproject

# Or if you crave the bleeding edge from the repo
rails new myproject --edge
```

### How to create a Rails 3 project with Rails 4 installed
With Rails 4 now taking priority over Rails 3 in your gem list how do you make a new Rails 3.2 project without going through the hassle of uninstalling Rails 4.

Simple really, check the versions of Rails you have installed already with `gem list rails`.

```bash
*** LOCAL GEMS ***

rails (4.0.0, 3.2.13)
```

The output shows I have the Rails `4.0.0` and `3.2.13` installed and you can simply append that version number to your `rails` command like so.

```bash
rails _3.2.13_ new myproject
```

This will create a project in the usual way but this time using the `3.2.13` version of the gem.

**Don't forget** that you should use `bundle exec` within your project when calling `rails generate` and friends so that the correct gem version according to the projects `Gemfile` is used. For example: `bundle exec rails generate model User`.

## Find out more about what's new in Rails 4
The Rails team have made a number of changes, improvements and deprecations that I'm not going to go into here but instead direct you to the following resources to learn more:

* [RailsGuides (edge)](http://edgeguides.rubyonrails.org/4_0_release_notes.html)
* [RailsCasts.com, What's new on Rails 4](http://railscasts.com/episodes/400-what-s-new-in-rails-4)
