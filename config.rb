set :title, 'Created by Pete'
set :meta_description, "Hi, my name is Peter Rhoades and I'm a multidisciplinary design, developer and creator from the UK."
set :site_url, 'http://www.createdbypete.com'
set :analytics, true
activate :blog do |blog|
  blog.prefix = 'articles'
  blog.layout = 'post'
  blog.permalink = '{title}'
  blog.summary_separator = /\n/
end
activate :directory_indexes
activate :alias

page "/404.html", directory_index: false

set :url_root, 'http://www.createdbypete.com'
activate :search_engine_sitemap

configure :development do
  set :debug_assets, true
  set :analytics, false
  set :site_url, 'http://localhost:4567'
end

helpers do
  def qr_code(page_url)
    qr = RQRCode::QRCode.new(page_url.to_s, size: 10)
    png = qr.to_img
    <<-MARKUP.strip
    <div class="qrcode">
      <img src="#{png.to_data_url}" alt="#{page_url}">
    </div>
    MARKUP
  end
end
