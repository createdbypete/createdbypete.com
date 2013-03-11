---
layout: post
title: Removing Heroku Toolbelt
categories: [articles]
---
So you would like to uninstall the [Heroku Toolbelt](http://toolbelt.heroku.com/) from OS X and you’ve noticed there is no information in the
documentation. No worries, you can run the following commands in a Terminal prompt:

{% highlight bash %}
rm -rf ~/.heroku
sudo rm -rf /usr/local/heroku
sudo rm -rf /usr/bin/heroku
{% endhighlight %}

This will delete the directories Heroku Toolbelt created during installation.