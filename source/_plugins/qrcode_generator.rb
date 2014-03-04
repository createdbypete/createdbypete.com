require 'cgi'

module CBP
  module Liquid
    class QrCodeTag < ::Liquid::Tag
      def initialize(tag_name, url, tokens)
        @url = url.strip
        super
      end

      def lookup(context, name)
        lookup = context

        name.split(".").each do |value|
          lookup = lookup[value]
        end

        lookup
      end

      def render(context)
        site_url = lookup(context, 'site.url')
        page_url = lookup(context, @url)
        img_uri = "https://chart.googleapis.com/chart?cht=qr&chs=100x100&chl=#{CGI.escape(site_url)}#{CGI.escape(page_url)}&choe=UTF-8&chld=M|0"
        <<-MARKUP.strip
<div class="qrcode"><img src="#{img_uri}"></div>
MARKUP
      end

    end
  end
end

Liquid::Template.register_tag('qr', CBP::Liquid::QrCodeTag)
