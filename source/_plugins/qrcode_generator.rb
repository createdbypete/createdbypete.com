require 'rqrcode_png'
require 'googl'

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
        page_url = Googl.shorten("#{lookup(context, 'site.url')}#{lookup(context, @url)}")
        qr = RQRCode::QRCode.new(page_url.short_url,)
        png = qr.to_img
        <<-MARKUP.strip
        <div class="qrcode">
          <img src="#{png.resize(90, 90).to_data_url}" alt="#{page_url.long_url}">
        </div>
        MARKUP
      end
    end
  end
end

Liquid::Template.register_tag('qr', CBP::Liquid::QrCodeTag)
