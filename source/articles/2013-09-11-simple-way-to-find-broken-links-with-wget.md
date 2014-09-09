---
layout: post
title: Simple way to find broken links with Wget
categories: articles
---
After writing the previous post singing the praises of Wget by show it can be used to [mirror and entire website locally](/articles/make-a-local-website-mirror-with-wget/). I have stumbled across another useful feature, it can be used to [spider a website](http://en.wikipedia.org/wiki/Web_crawler) following every link it finds (including those of assets such as stylesheets etc) and log the results.

In short, it's a pretty effective broken link finder, brilliant news for anyone with a long standing blog for example as most CMS systems such as [Wordpress](http://wordpress.org/) will not update any article references you have put in your blog posts for you.

## Shut up and show me this thing!

First, you'll need to make sure you have [Wget](http://www.gnu.org/software/wget/), on OS X you can just use [Homebrew](http://brew.sh/).

    brew install wget

The command to give Wget is as follows, note this will output the resulting file to your home directory `~/`. It may take a little while depending on the size of your website.

    wget --spider -o ~/wget.log -e robots=off -w 1 -r -p http://www.example.com

Let's break this command down so you can see what Wget is being told to do:

* `--spider`, this tells Wget not to download anything since we only want a report so it will only do a HEAD request not a GET.
* `-o ~/wget.log`, log messages to the declared file, in this case a file called `wget.log` that will be saved to your home directory, you can change this to a more convenient location and filename.
* `-e robots=off`, this one tells wget to ignore the `robots.txt` file. [Learn more about robots.txt](http://www.robotstxt.org/).
* `-w 1`, adds a 1 second wait between requests, this slows down Wget to more consistent rate to minimise stress on the hosting server so you don't get back any false positives.
* `-r`, this means recursive so Wget will keep trying to follow links deeper into your sites until it can find no more!
* `-p`, get all page requisites such as images, etc. needed to display HTML page so we can find broken image links too.
* `http://www.example.com`, finally the website url to start from.

### Reading the log

If you take a look inside the log file created by the Wget output you'll wonder how you'd get any useful information out of it. Simple, our old friend [Grep](http://en.wikipedia.org/wiki/Grep). Obviously if you changed the location of the log file update the command accordingly.

    grep -B 2 '404' ~/wget.log

This will find all references to the [HTTP Code](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes) `404` indicating a page not found failure. It will also return the 2 lines above that line so that you can see the url concerned. If you're lucky you will get no output but if you do have some broken links you will get something similar to this:

    --2013-09-11 07:12:25--  http://createdbypete.com/something-not-found.html
    Reusing existing connection to createdbypete.com:80.
    HTTP request sent, awaiting response... 404 Not Found

Unfortunately this doesn't show you where it found the link but it at least tells you the link that is trying to be called so you might be able to start your own investigation. I will update this article if I find a way to get more details about the links location but Wget is not really designed as a website debugging tool.

### Try it out!

Give it a go on your website and see what comes back, you might be suprised even on a small site typos can creep in. You could even search the log for other HTTP response codes.

### More options

Check out the [manual for wget](http://www.gnu.org/software/wget/manual/wget.html) as there are many more options available. Or as usual with any command you can use `man wget` in your terminal.
