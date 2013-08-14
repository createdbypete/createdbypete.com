# ## Retina Image Tag
#
# {% retina_img bg.jpg alt="foobar" %}
#
require "pathname"

class RetinaImageTag < Liquid::Tag
  def render context
    site = context.registers[:site]
    pathname = Pathname.new @markup[/^[^ ]+/]
    attributes = @markup[pathname.to_s.length..-1].strip

    small_asset = site.asset_path pathname.to_s

    filename = pathname.basename pathname.extname
    large_asset = site.assets_path "#{filename}@2x#{pathname.extname}"

    "<img src=#{small_asset.inspect} data-at2x=#{large_asset.inspect} #{attributes} />"
  end
end


Liquid::Template.register_tag "retina_img", RetinaImageTag
