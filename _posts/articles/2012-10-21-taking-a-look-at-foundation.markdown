---
layout: post
title: Taking a look at Foundation
categories: [articles]
grid: [wide]
alias: /blog/2012/10/taking-a-look-at-foundation.html
---

Recently I've been been experimenting with [Foundation](http://foundation.zurb.com), from the talented people at [Zurb](http://zurb.com). Foundation is now at version 3 and claims to be "The most advanced responsive front-end framework in the world".

Frameworks seems to be available for everything these days the question everyone always asks is which one is better? Well I'm not going to be answering that in this post as it's a matter of opinion based on many other things besides the actual framework.

> The most advanced responsive front-end framework in the world

Foundation uses [Sass](http://sass-lang.com/) as the pre-processor for the CSS and [Compass](http://compass-style.org/) to make use of the CSS3 mixins and other utilities it provides.

### Installation
If you're already familiar with Compass and Sass then you'll probably no what a [Ruby Gem](http://wikipedia.org/wiki/RubyGems) is. Foundation is best installed using this method so you can easily keep the library up to date for all your projects.

    [sudo] gem install zurb-foundation

More detailed installation and integration instructions can be found in the [Foundation documentation](http://foundation.zurb.com/docs/compass.php).

### The Grid
Probably the main reason you'd consider using a framework such as this is for a stable grid. [The Grid](http://foundation.zurb.com/docs/grid.php) in Foundation uses the familiar row and column idea, where rows create the width and the columns divide for structure. These columns do not have a fixed width however, this can take a little getting used to at first but it works well to accommodate for a range for viewport sizes.

### Customisation
All the options to adjust the grid, and most of the other components can be found in the `_settings.scss` that will be in the sass directory of your project. This is a prototyping framework however so it is not a cookie cutter for any design, however you've got a good starting point.

All the code used by Foundation is based on mixins that you can use yourself in your own classes very easily thanks Sass, so any of the purists can (if they can stand it) start by using the classes provided to quickly work up a prototype before refactoring them into something "cleaner".

### Give it ago
I like Foundation, it works well with my Rails applications and I find working with Sass easier than Less. But this is my opinion and is based on how I work. I would suggest taking a look and trying it out to see how you get on, the Foundation website is full of information and the documentation is very useful.
