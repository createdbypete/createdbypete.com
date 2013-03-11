---
layout: post
title: Absolute relativity, sizing text with CSS
categories: [articles]
alias: /blog/2012/11/absolute-relativity-sizing-text-with-css.html
---
Inspired by a recent Tweet from [@missrachilli](https://twitter.com/missrachilli) regarding the use of em and px values in CSS I thought a quick summary might help others. This is not a new discussion but with accepted opinions changing all the time I wanted to share how I deal with the decision.

I've always seem `em` values as a way to maintain a relative aspect ratio between elements, be that fonts or margins and padding. With an em you can scale all your fonts according to a base size and it doesn't matter what that base size is. With the same idea you could also scale all of your padding and margins relative to everything else so the ratio is maintained.

Typographically em is the best unit to use, but let's look at the real world for a moment. The `px` unit provides and absolute unit to scale things by, something that will be the same size no matter what everything else is doing. This is very appealing when you want to make sure everything is going to look how you intend no matter what (crazy) setup your client is using to view the site with. For this reason I believe px has become the preferred value.

In my opinion though I don't think it matter what you use, if you need a pixel perfect layout then use pixels, if you've got a more flexible layout then take advantage of the powerful em.