---
layout: post
title: Personalise the Google URL shortening service with your own domain
categories: articles
tags: [guide,apache,nginx]
grid: wide
---

In this short article I'll show you one way to personalise the Google URL Shortening service known as [goo.gl](http://goo.gl) so you can use your own short URL domain. You can probably use this with any other URL shortening service as well but I have a Google account so this is just easy.

#### But why would to do this?
First, with so many services on offer these days (we really are spoilt) I see little point inventing your own system for the sake of some branding. Secondly, why not?! We live in adventurous times and it's only going to take a few minutes to set this up.

## What do I need?
This is the best part, you only need a couple of things which in this day and age you have probably already got access to.

1. A domain name, I'm going to be using `crtdby.pt` (notice the lack of vowels, a must have for any short url domain!). This domain should not be used for anything else.
2. Hosting space for the domain, this can be [Apache](http://httpd.apache.org/) or [Nginx](http://wiki.nginx.org/) driven I'll provide examples for both, you just need to be able to make a change to the vhost configuration. For Apache we can do this easily via the `.htaccess` file. Nginx people will probably be running a VPS or similar so I'll assume you have access to create a new vhost configuration.
3. A Google account, if you want to have the URLs you generate with [goo.gl](http://goo.gl) be unique to your account and kept in your dashboard to track number of clicks etc. Otherwise anonymous access will work just fine to generate the URL.

## I'm ready to go, what's next?
Everything ready to go we can make the magic happen!

### Apache configuration
Apache people create a `.htaccess` file in the root web directory and add the following lines to it. Of course if you have access to the main vhost configuration then use that to save Apache a little bit of leg work reading in the `.htaccess` file.

```apache
RewriteEngine On
RewriteRule ^(.*)$ http://goo.gl/$1 [L,R=301]
```

The code above is very simple. This rewrite rule simply takes the requested URL and swaps out your domain for the `goo.gl` domain and marks it as a permanent (301) redirect.

### Nginx Configuration
Nginx people you need to create a server block, I've always followed the `sites-available`, `sites-enabled` pattern used by Nginx on Ubuntu as I find this to be the most organised method but do it however you've been working so long as Nginx can read this server block it will answer any calls to the domain.

```nginx
server {
  server_name crtdby.pt;
  rewrite ^ http://goo.gl$request_uri permanent;
}
```

The server block does the same as the Apache rule above and it redirects any requests onto `goo.gl`. Simple.

## How do I use this to make my own short urls?
By now you've probably figured it out but just in case. Visit [goo.gl](http://goo.gl/) and sign in if you want to keep statistics on your links otherwise you will just see the input box **Paste your long URL here:** follow the instructions and paste in your long URL and shorten that URL!

In return you'll get a short URL in the form of `http://goo.gl/nY8J2` all we are interested in is the bit after the domain. We can then append that to our custom domain [crtdby.pt/nY8J2](http://crtdby.pt/nY8J2) like so and you're done!

Now when you use that URL it will first take a trip to your server where it will find the rewrite rules we setup, these will then send the request onto [goo.gl](http://goo.gl) to be translated into the long URL and the correct page.

#### Seriously is that it!?
Yup, that's it. This method ensures you can still use the analytical data collected by the `goo.gl` service in their pretty graphs and you get to use your own domain.
