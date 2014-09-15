---
layout: post
title: Create a custom Liquid tag as a Jekyll plugin
categories: articles
updated: 2014-09-15 21:09
alias: articles/create-a-custom-liquid-tag-with-a-jekyll-plugin/index.html
---
If you didn't know already, this site was built in [Jekyll](http://jekyllrb.com/) (more recently in [Middleman](http://middlemanapp.com/)) and Jekyll makes use of the [Liquid](http://liquidmarkup.org/) templating language to process templates. All the standard [tags](http://docs.shopify.com/themes/liquid-basics/logic) and [filters](http://docs.shopify.com/themes/liquid-basics/output) for Liquid are supported, but sometimes you need a bit more!

I wanted to show a [QR code](http://en.wikipedia.org/wiki/QR_code) in the top corner of my article pages when it is printed off so you can scan the code and return to the page form a mobile device. A little bit of a gimmick but I wanted something real to base this article on.

## The plan

This plugin will need to do a couple of things:

1. Turn a page url into a QR code
1. Not rely on any third party services
1. Use base64 to encode the image directly into the page
1. Provide me with a convenient tag to use in my pages

## Creating a Liquid tag

Creating a new tag for Liquid is very simple, you just need to inherit from [Liquid::Tag](https://github.com/Shopify/liquid/blob/master/lib/liquid/tag.rb) and register your new tag.

```ruby
class QrCodeTag < Liquid::Tag
  def initialize(tag_name, url, tokens)
    super
    @url = url.strip
  end

  def render(context)
    # Create the QR code here
  end
end

Liquid::Template.register_tag('qr', QrCodeTag)
```

You would then be able to use your new tag in templates like so:

```html
{% qr http://createdbypete.com %}
```

## Creating a QR code

Again this is very simple thanks to the [rqrcode_png](https://rubygems.org/gems/rqrcode_png) gem. With this gem it is trivial to produce a QR code, as you can see below:

```ruby
require 'rqrcode_png'

qr = RQRCode::QRCode.new('http://createdbypete.com')
png = qr.to_img

# Now we have a chunky_png to work with we can base64 encode the image
png.to_data_url
```

As you can see in the last line [chunky_png](https://rubygems.org/gems/chunky_png) has a very useful method to allow for the image data to be converted into a data url for use in an ordinary `<img>` tag.

## Putting it all together

The following code is what I ended up with. You'll notice a new `lookup` method, this allow me to pass in the `page.url` variable into this tag since I don't want to be maintaining individual URLs here when I can let Jekyll and Liquid do it for me.

Thanks to [this StackOverflow post](http://stackoverflow.com/a/8771374) for helping me solve this one.

```ruby
class QrCodeTag < Liquid::Tag
  def initialize(tag_name, url, tokens)
    super
    @url = url.strip
  end

  def lookup(context, name)
    lookup = context
    name.split(".").each { |value| lookup = lookup[value] }
    lookup
  end

  def render(context)
    page_url = "#{lookup(context, 'site.url')}#{lookup(context, @url)}"
    qr = RQRCode::QRCode.new(page_url, size: 10) # Size increased because URLs can be long
    png = qr.to_img
    <<-MARKUP.strip
    <div class="qrcode">
      <img src="#{png.to_data_url}" alt="#{page_url}">
    </div>
    MARKUP
  end
end

Liquid::Template.register_tag('qr', QrCodeTag)
```

I've also included a variable from my Jekyll `_config.yml`, the `site.url`. This is just the full url to the website as the QR code will need to have this as well or it will only get a relative URL.

### A sprinkle of CSS

Now we've got our custom Liquid tag ready to go! We now need a small amount of CSS to finish the job so the `.qrcode` class is hidden by default but on print media is displayed.

```css
.qrcode {
  display: none;
}

@media print {
  .qrcode {
    display: block;
  }
}
```

Now you can just drop in the new tag to your article or add it as part of one of your layouts – this is how I've used it so it appears on all my articles. Try it out, bring up print preview and you should see in the top right corner of the first page a QR code for this article.

