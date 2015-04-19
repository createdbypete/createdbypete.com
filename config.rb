set :title, 'Created by Pete'
set :meta_description, "Hi, my name is Peter Rhoades I write about code."
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
activate :search_engine_sitemap do |s|
  s.exclude_if = ->(resource) { resource.instance_of?(Middleman::Sitemap::AliasResource) }
end

activate :syntax
activate :asset_hash

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true
set :debug_assets, false

configure :build do
  activate :minify_css
  activate :minify_javascript
end

configure :development do
  set :debug_assets, true
  set :analytics, false
  set :site_url, 'http://localhost:4567'
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.branch = 'master'
end

helpers do
  def qr_code(page_url)
    qr = RQRCode::QRCode.new(page_url.to_s, size: 14)
    png = qr.to_img
    <<-MARKUP.strip
    <div class="qrcode">
      <img src="#{png.to_data_url}" alt="#{page_url}">
    </div>
    MARKUP
  end
end
