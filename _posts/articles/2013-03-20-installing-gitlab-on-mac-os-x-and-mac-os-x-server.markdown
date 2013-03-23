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
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
```

A simple script that will automatically install Homebrew on your machine, once it's done we need to check it's all working and update the formulas.

```bash
brew doctor # Raring to brew?
brew update
```

### Packages and dependencies
We actually have most of what we need on OS X already, but we are missing a few core packages that we'll install with Homebrew now, these are mainly required for RVM to compile Ruby a little later on. Some of the other packages such as MySQL and Redis I will go through separately.

```bash
brew tap homebrew/dupes
brew install bash curl git icu4c
brew install autoconf automake libtool pkg-config openssl readline libyaml sqlite libxml2 libxslt libksba
```

#### What's better than one Python? Two apparently!
We need to create a symlink for Python for compatibility reasons not relating to OS X but for some other Linux distributions that are in limbo between version 2 and 3 of Python.

```bash
sudo ln -sv /usr/bin/python /usr/bin/python2
python2 --version # Should be Python 2.7.X
```

We also need Pygments for colourful syntax highlighting.

```bash
sudo easy_install Pygments
```

## Create Git user account

Gitolite and Gitlab need a user to operate as. In OS X you can create this user using the GUI via System Preferences or via the command line like we are about to do.

First, we need to check for an ID we can use, the commands below list the IDs of all the users and groups on your system. I'm going to use and ID of `1050` in this guide so check in each list for this number, if it doesn't appear then good news, if it does find the next number available in both lists (I like to keep the group and user IDs the same for this).  

```bash
# Check user IDs 
dscl . -list /Users UniqueID | awk '{print $2}' | sort -n

# Check group IDs
dscl . -list /Groups PrimaryGroupID | awk '{print $2}' | sort -n
```

Create a new group called `git` with the ID of `1050` (if that ID is available on your system).

```bash
sudo dscl . -create /Groups/git
sudo dscl . -create /Groups/git PrimaryGroupID 1050
```

Now we create a `git` user account with the recently created `git` group as the primary group.

```bash
sudo dscl . -create /Users/git
sudo dscl . -create /Users/git UserShell /bin/bash
sudo dscl . -create /Users/git RealName "Git"
sudo dscl . -create /Users/git UniqueID 1050
sudo dscl . -create /Users/git PrimaryGroupID 1050
sudo dscl . -create /Users/git NFSHomeDirectory /Users/git
sudo dscl . -append /Groups/staff GroupMembership git

# Obviously change "mysupersecurepassword123" to something better ;)
sudo dscl . –passwd /Users/git mysupersecurepassword123

# Check our new Git user exists 
dscl . -read /Users/git

# Create home directory
sudo createhomedir -c -u git
```

## Install RVM and Ruby

Before we start trying to install RVM we need to login as the right user. You can do this from the terminal with the `su` command. It will then ask you for the git users password you set in the previous steps.

```bash
su - git # The hyphen is important

# Follow the instructions: Hit enter to view the license agreement, use space to reach the bottom of the license and then you can type 'agree' to complete the step… you've read the license right?!
xcodebuild -license
```

We will be using [RVM](https://rvm.io) to install Ruby, again it's a one-line install for RVM and Ruby doesn't take much effort either. I'm installing Ruby 1.9.3 as at the time of writting this is the supported version for Gitlab.

```bash
curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
source ~/.rvm/scripts/rvm

rvm use 1.9.3


# Check our shell is using the correct Ruby version
ruby -v
```

### Create RVM Gemset for Gitlab

With Ruby installed and our shell now running the correct version of Ruby we need to make a gemset to make it easier to manage the gems we will install for Gitlab. We then set this gemset as the default. After this is done we need [Bundler](http://gembundler.com) installed to that gemset.

```bash
rvm gemset create gitlab
rvm use 1.9.3@gitlab --default

# Skip Rdoc generation
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
gem install bundler
```

```bash
env | grep -E "^(GEM_HOME|PATH|RUBY_VERSION|MY_RUBY_HOME|GEM_PATH)=" > ~/.ssh/environment
# TODO enable ssh options and permit environment
```

## Gitlab Shell
Since [5-0-stable](https://github.com/gitlabhq/gitlabhq/tree/5-0-stable) of Gitlab [Gitolite](https://github.com/sitaramc/gitolite) has been replaced with Gitlab's own implementation. 

```bash
su - git # If you're not still logged in as the git user

# Clone the gitlab-shell repo
git clone https://github.com/gitlabhq/gitlab-shell.git ~/gitlab-shell
cd ~/gitlab-shell

# Copy example config.yml
cp config.yml.example config.yml
```

Now open the `config.yml` in Vim, if you've not used Vim before worry you only need to know a couple of commands to use it so I'll talk you through those.

```bash
vim config.yml
```

With the file open in Vim use the arrow keys to navigate to the bottom couple of lines shown below as we need to change the paths here. Press <kbd>i</kbd> to change to `- INSERT -` mode and again use the arrow keys to navigate and change `home` to `Users` the same as below. Once finished press <kbd>esc</kbd> to leave the insert mode then type `:wq` this tells Vim to **w**rite the file and **q**uit.

```yaml
# Repositories path
repos_path: "/Users/git/repositories"

# File used as authorized_keys for gitlab user
auth_file: "/Users/git/.ssh/authorized_keys"
```

We're going to leave the `gitlab_url` as `localhost` for now.
With that done install the gitlab-shell with the following command (still as the git user): 

```bash
./bin/install
```

## Install and setup MySQL Database for Gitlab

```bash
brew install mysql
# TODO
# TODO create db and user
```

## Install and setup Redis

```bash
brew install redis
# TODO
```

## Setup Gitlab!

Finally we are now going to clone the Gitlab repository and setup the application.

```bash
su - git # If you're not still logged in as the git user

# Clone the Gitlabhq repo from Github
git clone https://github.com/gitlabhq/gitlabhq.git ~/gitlab
cd ~/gitlab

# Checkout the 5-0-stable branch
git checkout 5-0-stable
```

### Install gems

Using the power of Bundler we can install all the gems required by Gitlab, we will be installing the gems _without_ the `development`, `test` and `postgresql` groups as we won't be needing those.

```bash

# Please note the -- below is not a mistake
gem install charlock_holmes -- --version '0.6.9' --with-icu-dir=/usr/local/opt/icu4c

# Configure bundler to always use icu4c from Homebrew and install Gitlab gems
bundle config build.charlock_holmes --with-icu-dir=/usr/local/opt/icu4c
bundle install --deployment --without development test postgres
```

### Configure Gitlab and database settings

```bash
# Copy the example GitLab config
cp config/gitlab.yml.example config/gitlab.yml

vim config/gitlab.yml
# TODO 
```

```bash
cd ~/gitlab

# Make sure GitLab can write to the log/ and tmp/ directories
chmod -R u+rwX log/
chmod -R u+rwX tmp/

# Create directory for pids and make sure GitLab can write to it
mkdir tmp/pids/
chmod -R u+rwX tmp/pids/

# Create directory for satellites
mkdir ~/gitlab-satellites

# Copy the example Unicorn config
cp config/unicorn.rb.example config/unicorn.rb
# TODO
```

```bash
# Copy the example database config for MySQL
cp config/database.yml.mysql config/database.yml
```

### Initialise database and activate features

```bash
bundle exec rake gitlab:setup RAILS_ENV=production
```

### Check application status

```bash
bundle exec rake gitlab:env:info RAILS_ENV=production
```

### Quick test

```bash
RAILS_ENV=production bundle exec rake sidekiq:launchd > /dev/null 2>&1 &
RAILS_ENV=production bundle exec rails s
open http://127.0.0.1:3000
```
