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

configure :development do
  set :debug_assets, true
  set :analytics, false
  set :site_url, 'http://localhost:4567'
end
