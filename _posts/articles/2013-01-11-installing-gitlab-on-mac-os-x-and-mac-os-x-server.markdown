---
layout: post
title: Installing Gitlab on Mac OS X and Mac OS X Server
image: install-gitlab-osx.jpg
categories: articles
tags: [guide,devops,git]
grid: large
---

[Gitlab](http://gitlab.org) is self hosted Git management software, not only that but it's also _free and open-source_. 

While Gitlab has a brilliant [installation guide](https://github.com/gitlabhq/gitlabhq/blob/stable/doc/install/installation.md) available, it is focused on Ubuntu/Debian and not all those instructions carry over to OS X so after a bit of tinkering I've put together this guide for anyone else looking to run Gitlab on OS X.

I'll be working on 10.8 (Mountain Lion) but these instructions will most likely work on 10.7 (Lion) as well. My original install of Gitlab was on an Xserve machine that also had [OS X Server](http://www.apple.com/uk/osx/server/) installed so these steps will work with that also.

## Requirements

The Gitlab team suggests atleast 1GB RAM in your machine to run the Gitlab application, since Mountain Lion requires about 2GB+ RAM you can go ahead and tick that off the list.

### Install Command Line Tools and Homebrew
If you don't have [Homebrew](http://mxcl.github.com/homebrew/) installed already then before you start copy & pasting into Terminal you had better check you have [Command Line Tools](https://developer.apple.com/downloads) installed first. Done that? OK, time to install Homebrew.

```bash
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

# Add Homebrews binary path to the front of the $PATH 
echo "export PATH=/usr/local/bin:$PATH" >> ~/.bash_profile
source ~/.bash_profile
```

A simple script that will automatically install Homebrew on your machine, once it's done we need to check it's all working and update the formulas.

```bash
brew doctor # Ready to brew?
brew update
```

### Packages and dependencies
We actually have most of what we need on OS X already, but we are missing a few core packages that we'll install with Homebrew now. Some of the other such as MySQL I will go through separately.

```bash
brew install icu4c redis
```

#### What's better than one Python? Two!
We need to create a symlink for Python for compatibility reasons not relating to OS X but for some other Linux distributions.

```bash
sudo ln -s /usr/bin/python /usr/bin/python2
python2 --version # Should be Python 2.7.X
```