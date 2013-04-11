---
layout: post
title: Removing Heroku Toolbelt
categories: articles
alias: /blog/2012/08/removing-heroku-toolbelt.html
---
So you would like to uninstall the [Heroku Toolbelt](http://toolbelt.heroku.com/) from OS X and you've noticed there is no information in the
documentation. No worries, you can run the following commands in a Terminal prompt:

```bash
rm -rf ~/.heroku
sudo rm -rf /usr/local/heroku /usr/bin/heroku
```

This will delete the directories Heroku Toolbelt created during installation.