---
layout: post
title: Make a local website mirror with Wget
alias: /articles/make-a-local-copy-of-any-website-with-wget/index.html
categories: articles
tags: [guide]
---
You've probably used the [Wget](http://www.gnu.org/software/wget/) command-line tool before but you may not be aware of a pretty neat feature it has tucked away.

You can download the resulting HTML of a website (including any linked assets)to your local machine. Not only that it will update any links to the local file reference. This can be useful for getting hold of a site you want to view offline (perhaps you are travelling).

## Let's get to it, mirroring a website!

If you're on OS X you won't have wget installed by default so once again it's [Homebrew](http://brew.sh/) to the rescue.

```
brew install wget
```

With wget now available let's create a local mirror of a website. In it's simplest form you can use it like this:

```
wget -mk http://www.example.com
```

If you want to be a good citizen and avoid being blocked by any well configured firewalls you might also want to add a delay to the download of each asset. You can do this with the `-w` flag, the example below will add a 1 second delay, it will take a bit longer but you can award yourself +1 internet point.

```
wget -mk -w 1 http://www.example.com
```

## Making it more intelligent

There are a few extra settings you can add to make it more "intelligent" as you probably don't want to try and download the internet (__wget__ will follow all the links in a site so you could end up with a lot of clutter).

### Set the domain

The example below will not follow any links outside of `example.com`.

```
wget -mk --domains example.com http://www.example.com
```

### More options

Check out the [manual for wget](http://www.gnu.org/software/wget/manual/wget.html) as there are many more options available. Or as usual with any command you can use `man wget` in your terminal.
